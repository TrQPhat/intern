import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/models/Contract.dart';

class ContractRepository {
  final String baseURL = "http://10.0.2.2:5000/api/contracts";

  Future<List<Contract>> getContracts() async {
    try {
      final response = await http.get(
        Uri.parse("$baseURL/"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Contract.fromJson(json)).toList();
      } else {
        throw Exception(
          "Failed to load contracts. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Error fetching contracts: ${e.toString()}");
    }
  }
}
