import 'package:isar/isar.dart';

part 'user.g.dart';

@Collection()
class User {
  Id? id;
  final String username;
  final String password;
  final String email;
  final String full_name;

  User({
    this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.full_name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user_id'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      full_name: json['full_name'], // Vẫn dùng snake_case cho JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'full_name': full_name, // Giữ nguyên cho API
    };
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, password: $password, email: $email, full_name: $full_name)';
  }
}
