import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/database/user_controller.dart';
import 'package:my_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static final String baseURL = "http://10.0.2.2:5000/api/users";
  Future<User> login(String username, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseURL/login"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"username": username, "password": password}),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        WidgetsFlutterBinding.ensureInitialized();
        final prefs = await SharedPreferences.getInstance();

        await UserController.addUser(
          User.fromJson(data['user']),
        );

        // Lưu thông tin người dùng vào SharedPreferences
        prefs.setString('user_id', data['user']['user_id'].toString());

        return User.fromJson(data['user']);
      } else {
        throw Exception("Tên đăng nhập hoặc mật khẩu không chính xác!");
      }
    } on TimeoutException {
      throw Exception("Kết nối quá hạn, vui lòng thử lại");
    } on http.ClientException catch (e) {
      throw Exception("Lỗi kết nối: ${e.message}");
    } catch (e) {
      throw Exception("Lỗi không xác định: ${e.toString()}");
    }
  }

  Future<User> register(
    String username,
    String password,
    String email,
    String full_name,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseURL/register"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "username": username,
              "password": password,
              "email": email,
              "full_name": full_name,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return User.fromJson(data['user']);
      } else if (response.statusCode == 500) {
        throw Exception("Username hoặc email đã tồn tại");
      } else {
        throw Exception(
            "Đăng ký không thành công! Code: ${response.statusCode}");
      }
    } on TimeoutException {
      throw Exception("Kết nối quá hạn, vui lòng thử lại");
    } on http.ClientException catch (e) {
      throw Exception("Lỗi kết nối: ${e.message}");
    } catch (e) {
      throw Exception("Lỗi không xác định: ${e.toString()}");
    }
  }

  Future<User> updateDeviceToken(int userId, String deviceToken) async {
    final url = Uri.parse('$baseURL/$userId');

    try {
      final response = await http
          .put(
            url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'device_token': deviceToken,
            }),
          )
          .timeout(const Duration(seconds: 10)); // Timeout sau 10 giây

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Đã cập nhật device_token");
        return User.fromJson(data['user']);
      } else {
        print("Lỗi khi cập nhật device_token");
        throw Exception('Lỗi server: ${response.statusCode}');
      }
    } on HttpException {
      throw Exception('Kết nối không ổn định.');
    } on TimeoutException {
      throw Exception('Kết nối đến máy chủ quá lâu. Vui lòng thử lại sau.');
    } catch (e) {
      throw Exception('Lỗi không xác định: $e');
    }
  }
}
