import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionService {
  static final ConnectionService _instance = ConnectionService._internal();

  factory ConnectionService() {
    return _instance;
  }

  ConnectionService._internal();

  final Connectivity _connectivity = Connectivity();

  /// Kiểm tra kết nối hiện tại (true nếu có mạng)
  Future<bool> hasConnection() async {
    final result = await _connectivity.checkConnectivity();
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi;
  }

  /// Lắng nghe thay đổi kết nối
  Stream<ConnectivityResult> get onConnectionChanged =>
      _connectivity.onConnectivityChanged;
}
