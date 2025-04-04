import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/user.dart';
import '../models/contract.dart';

class DBHelper {
  static Isar? _isar;

  static Future<void> initialize() async {
    if (_isar != null) return; // Tránh khởi tạo lại nếu đã được khởi tạo
    final dir = await getTemporaryDirectory();

    _isar = await Isar.open(
      [UserSchema, ContractSchema], // Thêm các model vào đây
      directory: dir.path,
    );
  }

  /// Lấy instance của Isar
  static Future<Isar> get isar async {
    if (_isar == null) {
      await initialize(); // Đảm bảo Isar đã được khởi tạo trước khi sử dụng
    }
    return _isar!;
  }

  /// Thêm hợp đồng vào database
  static Future<void> addContract(Contract contract) async {
    final isarInstance = await isar;
    await isarInstance.writeTxn(() async {
      await isarInstance.contracts.put(contract);
    });
  }

  /// Lấy danh sách tất cả hợp đồng
  static Future<List<Contract>> getAllContracts() async {
    final isarInstance = await isar;
    return await isarInstance.contracts.where().findAll();
  }

  static Future<void> saveContractToDB(List<Contract> contracts) async {
    await DBHelper.initialize(); // Đảm bảo Isar được khởi tạo
    final isarInstance = await DBHelper.isar;

    await isarInstance.writeTxn(() async {
      await isarInstance.contracts.putAll(contracts); // Lưu danh sách vào DB
    });

    print(
        "Đã lưu ${await isarInstance.contracts.count()} người dùng vào database.");
  }
}
