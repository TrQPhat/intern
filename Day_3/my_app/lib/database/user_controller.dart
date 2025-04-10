import 'package:isar/isar.dart';
import '../models/user.dart';
import 'db_helper.dart';

class UserController {
  /// Thêm user vào database
  static Future<void> addUser(User user) async {
    final isarInstance = await DBHelper.isar;
    await isarInstance.writeTxn(() async {
      await isarInstance.users.put(user);
    });
  }

  /// Lấy tất cả users
  static Future<List<User>> getAllUsers() async {
    final isarInstance = await DBHelper.isar;
    return await isarInstance.users.where().findAll();
  }

  /// Lấy user theo ID
  static Future<User?> getUserById(int id) async {
    final isarInstance = await DBHelper.isar;
    return await isarInstance.users.get(id);
  }

  /// Cập nhật user
  static Future<void> updateUser(User updatedUser) async {
    final isarInstance = await DBHelper.isar;
    await isarInstance.writeTxn(() async {
      await isarInstance.users.put(updatedUser);
    });
  }

  /// Xóa user theo ID
  static Future<void> deleteUser(int id) async {
    final isarInstance = await DBHelper.isar;
    await isarInstance.writeTxn(() async {
      await isarInstance.users.delete(id);
    });
  }

  /// Xóa tất cả users
  static Future<void> deleteAllUsers() async {
    final isarInstance = await DBHelper.isar;
    await isarInstance.writeTxn(() async {
      await isarInstance.users.clear();
    });
  }
}
