import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_app/database/contract_controller.dart';
import 'package:my_app/features/auth/repositories/AuthRepository.dart';
import 'package:my_app/features/contract/repositories/ContractRepository.dart';
import 'package:my_app/services/connection_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Khởi tạo Firebase và FCM
  static Future<void> initialize() async {
    await Firebase.initializeApp();

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Lấy FCM Token
    String? token = await messaging.getToken();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('device_token', token!);

    print("🔑 FCM Token: $token");

    // Cấu hình local notification
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    await flutterLocalNotificationsPlugin.initialize(initSettings);
    await setupFlutterNotifications();

    // Khi app bị đóng hẳn
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleFCM(message, from: "🚪 Terminated");
      }
    });

    // App đang foreground
    FirebaseMessaging.onMessage.listen((message) {
      _handleFCM(message, from: "🟢 Foreground");
      _showLocalNotification(message);
    });

    // App đang background và được mở lên từ thông báo
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleFCM(message, from: "🔄 Background");
    });
  }

  /// Xử lý message tùy trạng thái
  static Future<void> _handleFCM(RemoteMessage message,
      {String from = ""}) async {
    final data = message.data;

    final contractId = data['contract_id'];
    final actionType = data['action_type'];

    if (contractId == null || actionType == null) return;

    print("$from - Nhận FCM:");
    print("📌 Title: ${message.notification?.title}");
    print("📝 Body: ${message.notification?.body}");
    print("📦 Data: ${message.data}");

    final connectionService = ConnectionService();
    final isConnected = await connectionService.hasConnection();
    if (!isConnected) {
      print('⚠️ Không có kết nối mạng, không thể đồng bộ');
      return;
    }

    switch (actionType) {
      case 'insert':
        try {
          final contract =
              await ContractRepository.getContractByID(int.parse(contractId));
          await ContractController.addContract(contract, status: "synced");
          print('đã thêm contract: $contractId');
        } catch (e) {
          print(' Lỗi lấy contract: $e');
        }
        break;
      case 'update':
        try {
          final contract =
              await ContractRepository.getContractByID(int.parse(contractId));
          await ContractController.updateContract(contract, status: "synced");
          print('đã cập nhật contract: $contractId');
        } catch (e) {
          print(' Lỗi khi đồng bộ contract: $e');
        }
        break;

      case 'delete':
        try {
          await ContractController.deleteContract(int.parse(contractId),
              status: "synced");
          print('Đã xóa contract $contractId khỏi isar');
        } catch (e) {
          print(' Lỗi khi xóa contract: $e');
        }
        break;

      default:
        print('⚠️ Unknown action_type: $actionType');
    }
  }

  /// Hiển thị local notification khi app đang foreground
  static Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'fcm_default_channel', // channel ID
      'Thông báo FCM', // channel name
      channelDescription: 'Hiển thị thông báo khi app foreground',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? 'Thông báo',
      message.notification?.body ?? '',
      notificationDetails,
    );
  }

  static Future<void> setupFlutterNotifications() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'default_channel', // ID phải trùng với `default_notification_channel_id`
      'Thông báo mặc định', // Tên hiển thị trong cài đặt
      description: 'Kênh thông báo mặc định',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
}
