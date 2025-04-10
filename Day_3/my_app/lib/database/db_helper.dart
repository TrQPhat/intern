import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/user.dart';
import '../models/contract.dart';

class DBHelper {
  static Isar? _isar;

  static Future<void> initialize() async {
    if (_isar != null) return;
    final dir = await getTemporaryDirectory();

    _isar = await Isar.open(
      [UserSchema, ContractSchema],
      directory: dir.path,
    );
  }

  /// Lấy instance của Isar
  static Future<Isar> get isar async {
    if (_isar == null) {
      await initialize();
    }
    return _isar!;
  }
}
