class User {
  final int? id;
  final String username;
  final String password;
  final String email;
  final String full_name;

  const User({
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
      full_name: json['full_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'full_name': full_name,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, password: $password, email: $email, full_name: $full_name)';
  }
}
