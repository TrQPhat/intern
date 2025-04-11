import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:my_app/features/contract/bloc/ContractBloc.dart';
import 'package:my_app/features/contract/bloc/ContractEvent.dart';
import 'package:my_app/services/connection_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SyncManager {
  static final SyncManager _instance = SyncManager._internal();
  factory SyncManager() => _instance;
  SyncManager._internal();

  Timer? _timer;
  bool _isSyncing = false;
  DateTime? _lastSyncTime;
  late ContractBloc _bloc;
  StreamSubscription<ConnectivityResult>? _connectionSubscription;

  final List<Future<void> Function()> _syncQueue = [];

  void initialize(ContractBloc bloc) {
    _bloc = bloc;
    _startConnectionListener();
    _startSyncScheduler();
  }

  void _startConnectionListener() {
    _connectionSubscription?.cancel();
    _connectionSubscription =
        ConnectionService().onConnectionChanged.listen((result) async {
      final hasConnection = await ConnectionService().hasConnection();
      if (hasConnection) {
        _retrySyncQueue();
      }
    });
  }

  void _startSyncScheduler() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      enqueueSync("Đồng bộ tự động mỗi 5 phút");
    });
  }

  /// đưa tác vụ vào hàng đợi
  void enqueueSync(String reason) {
    _syncQueue.add(() => _syncNow(reason: reason));
    _retrySyncQueue();
  }

  Future<void> _retrySyncQueue() async {
    if (_isSyncing || _syncQueue.isEmpty) return;

    final connected = await ConnectionService().hasConnection();
    if (!connected) return;

    _isSyncing = true;

    while (_syncQueue.isNotEmpty) {
      final syncTask = _syncQueue.removeAt(0);
      try {
        await syncTask(); // thực thi task
      } catch (e) {
        if (kDebugMode) print("Đồng bộ lỗi: $e – Đưa lại vào hàng đợi");
        _syncQueue.insert(0, syncTask); // đưa lại đầu queue
        break;
      }
    }

    _isSyncing = false;
  }

  Future<void> _syncNow({String reason = "Không rõ lý do"}) async {
    final connected = await ConnectionService().hasConnection();
    if (!connected) throw Exception("Không có kết nối mạng");

    _bloc.add(SyncContractsFromIsar());
    _lastSyncTime = DateTime.now();

    if (kDebugMode) {
      print("$reason, $_lastSyncTime");
    }
  }

  void dispose() {
    _timer?.cancel();
    _connectionSubscription?.cancel();
  }
}
