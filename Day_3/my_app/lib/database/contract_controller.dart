// db/contract_controller.dart
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/contract.dart';
import 'db_helper.dart';

class ContractController {
  /// Thêm một hợp đồng
  static Future<void> addContract(Contract contract,
      {String status = "created"}) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = int.tryParse(prefs.getString('user_id') ?? "0") ?? 0;

    Contract newContract = Contract(
      userId: userId,
      contractType: contract.contractType,
      startDate: contract.startDate,
      endDate: contract.endDate,
      status: contract.status,
      createdAt: contract.createdAt,
      syncStatus: status,
    );

    if (contract.contractId != 0) newContract.contractId = contract.contractId;

    final isarInstance = await DBHelper.isar;
    await isarInstance.writeTxn(() async {
      await isarInstance.contracts.put(newContract);
    });
  }

  /// Thêm nhiều hợp đồng
  static Future<void> saveContracts(List<Contract> contracts) async {
    final isarInstance = await DBHelper.isar;
    await isarInstance.writeTxn(() async {
      await isarInstance.contracts.putAll(contracts);
    });
    print(
        "Đã lưu ${await isarInstance.contracts.count()} hợp đồng vào database.");
  }

  /// Lấy tất cả hợp đồng
  static Future<List<Contract>> getAllContracts() async {
    final isarInstance = await DBHelper.isar;
    final allContracts = await isarInstance.contracts.where().findAll();
    return allContracts.where((c) => c.syncStatus != 'deleted').toList();
  }

  /// Lấy danh sách hợp đồng theo userId
  static Future<List<Contract>> getContractsByUserId(int userId) async {
    final isarInstance = await DBHelper.isar;
    return await isarInstance.contracts
        .filter()
        .userIdEqualTo(userId)
        .findAll();
  }

  static Future<void> updateContract(Contract updatedContract,
      {String status = "updated"}) async {
    updatedContract.syncStatus = status;

    final isarInstance = await DBHelper.isar;
    await isarInstance.writeTxn(() async {
      await isarInstance.contracts.put(updatedContract);
    });
  }

  /// Xóa hợp đồng theo ID
  static Future<void> deleteContract(int id,
      {String status = "deleted"}) async {
    final isarInstance = await DBHelper.isar;
    final contract = await isarInstance.contracts.get(id);
    if (contract != null) {
      if (status == "deleted") {
        contract.syncStatus = status;
        await isarInstance.writeTxn(() async {
          await isarInstance.contracts.put(contract);
        });
      } else {
        await isarInstance.writeTxn(() async {
          await isarInstance.contracts.delete(id);
        });
      }
    }
  }

  //clear
  static Future<void> clearContract() async {
    final isarInstance = await DBHelper.isar;

    await isarInstance.writeTxn(() async {
      await isarInstance.contracts.clear();
    });
  }

  //lấy các hợp đồng cần đồng bô
  static Future<List<Contract>> getUnsyncedContracts() async {
    final isarInstance = await DBHelper.isar;

    // Lấy tất cả hợp đồng từ local DB
    final allContracts = await isarInstance.contracts.where().findAll();

    // Lọc thủ công bằng Dart
    return allContracts.where((contract) {
      return contract.syncStatus != 'synced';
    }).toList();
  }
}
