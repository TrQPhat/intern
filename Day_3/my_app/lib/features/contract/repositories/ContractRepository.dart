import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/database/contract_controller.dart';
import 'package:my_app/models/contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContractRepository {
  static final String baseURL = "http://10.0.2.2:5000/api/contracts";

  Future<List<Contract>> getContracts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final user_id = int.tryParse(prefs.getString('user_id') ?? "0") ?? 0;

      final response = await http.get(
        Uri.parse("$baseURL/$user_id"),
        headers: {"Content-Type": "application/json"},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data.map((json) => Contract.fromJson(json)).toList();
      } else {
        throw Exception(
          "Err. Status code: ${response.statusCode}",
        );
      }
    } on TimeoutException {
      throw Exception("Quá thời gian");
    } on http.ClientException {
      throw Exception("Kết nối không ổn định");
    } catch (e) {
      throw Exception("Error fetching contracts: ${e.toString()}");
    }
  }

  // Thêm
  Future<Contract> addContract(Contract contract) async {
    try {
      final response = await http.post(
        Uri.parse("$baseURL/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(contract.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return Contract.fromJson(responseData['contract']);
      } else {
        throw Exception('Lỗi thêm HĐ: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception("Quá thời gian");
    } on http.ClientException {
      throw Exception("Kết nối không ổn định");
    } catch (e) {
      throw Exception('lỗi api: $e');
    }
  }

  static Future<Contract> getContractByID(int contractId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseURL/getone/$contractId'),
        headers: {"Content-Type": "application/json"},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Contract.fromJson(data);
      } else if (response.statusCode == 404) {
        throw Exception('Không tìm thấy hợp đồng với ID: $contractId');
      } else {
        throw Exception('Lỗi khi lấy hợp đồng. Mã lỗi: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception("Yêu cầu quá thời gian chờ");
    } on http.ClientException {
      throw Exception("Lỗi kết nối mạng");
    } on FormatException {
      throw Exception("Dữ liệu trả về không hợp lệ");
    } catch (e) {
      throw Exception('Lỗi hệ thống: ${e.toString()}');
    }
  }

  // Xóa
  Future<bool> deleteContract(int contractId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseURL/$contractId'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete contract: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception("Quá thời gian");
    } on http.ClientException {
      throw Exception("Kết nối không ổn định");
    } catch (e) {
      throw Exception('API Error: $e');
    }
  }

// Sửa
  Future<Contract> updateContract(Contract contract) async {
    try {
      final response = await http.put(
        Uri.parse('$baseURL/${contract.contractId}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(contract.toJson()),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return Contract.fromJson(responseData);
      } else {
        throw Exception('Failed to update contract: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception("Quá thời gian");
    } on http.ClientException {
      throw Exception("Kết nối không ổn định");
    } catch (e) {
      throw Exception('API Error: $e');
    }
  }

  Future<void> syncContractsToServer(List<Contract> contracts) async {
    for (var contract in contracts) {
      try {
        switch (contract.syncStatus) {
          case 'created':
            await addContract(contract);
            break;
          case 'updated':
            await updateContract(contract);
            break;
          case 'deleted':
            await deleteContract(contract.contractId!);
            break;
        }

        //xóa log
        try {
          final response = await http.delete(
            Uri.parse('$baseURL/contract-log/${contract.contractId}'),
            headers: {"Content-Type": "application/json"},
          );

          if (response.statusCode == 200) {
            print('Xóa log thành công');
          } else if (response.statusCode == 404) {
            print('Không tìm thấy log để xóa');
          } else {
            print('Lỗi khi xóa log: ${response.statusCode}');
          }
        } catch (e) {
          print('Lỗi kết nối khi gọi API: $e');
        }

        // đổi thành 'synced'
        contract.syncStatus = 'synced';
        await ContractController.updateContract(contract);
      } catch (e) {
        debugPrint('Lỗi khi sync contract ${contract.contractId}: $e');
      }
    }
  }
}
