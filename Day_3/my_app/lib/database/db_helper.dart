import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DBHelper {
  static late Isar _isar;

  // Getter để truy cập cơ sở dữ liệu
  static Isar get isar => _isar;

  // Khởi tạo Isar và kết nối với database
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.path;

    _isar = await Isar.open([YourModelSchema], directory: path);
  }

  // Đóng kết nối với database
  static Future<void> close() async {
    await _isar.close();
  }
}
