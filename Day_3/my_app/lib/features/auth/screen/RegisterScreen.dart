import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/auth/bloc/AuthBloc.dart';
import 'package:my_app/features/auth/bloc/AuthEvent.dart';
import 'package:my_app/features/auth/bloc/AuthState.dart';
import 'package:my_app/widgets/CustomLink.dart';
import 'package:my_app/widgets/CustomLogo.dart';
import 'package:my_app/widgets/CustomTextField.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng Ký Tài Khoản'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocProvider.value(
        value: BlocProvider.of<AuthBloc>(context),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Đăng ký thành công người dùng ${state.user.full_name}!",
                  ),
                ),
              );
              Navigator.pop(context);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  CustomLogo(
                    iconColor: Colors.blue,
                    text: "Tạo Tài Khoản Mới",
                    textColor: Colors.black,
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    controller: _fullNameController,
                    label: "Họ và tên",
                    icon: Icons.person,
                    isPassword: false,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _emailController,
                    label: "Email",
                    icon: Icons.email,
                    isPassword: false,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _usernameController,
                    label: "Tên đăng nhập",
                    icon: Icons.key,
                    isPassword: false,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _passwordController,
                    label: "Mật khẩu",
                    icon: Icons.lock,
                    isPassword: true,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _confirmPasswordController,
                    label: "Nhập lại mật khẩu",
                    icon: Icons.lock,
                    isPassword: true,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed:
                              state is AuthLoading
                                  ? null
                                  : () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthBloc>().add(
                                        RegisterEvent(
                                          username: _usernameController.text,
                                          password: _passwordController.text,
                                          confirmPassword:
                                              _confirmPasswordController.text,
                                          email: _emailController.text,
                                          full_name: _fullNameController.text,
                                        ),
                                      );
                                    }
                                  },
                          child:
                              state is AuthLoading
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                    'ĐĂNG KÝ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomLink(
                    text: "Đăng nhập ngay",
                    titleColor: Colors.black,
                    textColor: Colors.blueAccent,
                    route: "login",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
