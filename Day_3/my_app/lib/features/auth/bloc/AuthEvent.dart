import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckOldLogin extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class RegisterEvent extends AuthEvent {
  final String username;
  final String password;
  final String confirmPassword;
  final String email;
  final String full_name;

  RegisterEvent({
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.email,
    required this.full_name,
  });

  @override
  List<Object> get props => [
        username,
        password,
        confirmPassword,
        email,
        full_name,
      ];
}

class LogOut extends AuthEvent {}
