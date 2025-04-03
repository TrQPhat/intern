import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/models/User.dart';

class AuthRepository {
  final String baseURL = "http://10.0.2.2:5000/api/users";
  Future<User> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("$baseURL/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return User.fromJson(data['user']);
    } else {
      throw Exception("Tên đăng nhập hoặc mật khẩu không chính xác!");
    }
  }

  Future<User> register(
    String username,
    String password,
    String email,
    String full_name,
  ) async {
    final response = await http.post(
      Uri.parse("$baseURL/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
        "email": email,
        "full_name": full_name,
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return User.fromJson(data['user']);
    } else if (response.statusCode == 500) {
      throw Exception("Username hoặc email đã tồn tại");
    } else {
      throw Exception("Đăng ký không thành công! Code: ${response.statusCode}");
    }
  }
}
