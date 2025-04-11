import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/auth/bloc/AuthBloc.dart';
import 'package:my_app/features/auth/bloc/AuthEvent.dart';
import 'package:my_app/features/auth/bloc/AuthState.dart';
import 'package:my_app/features/contract/bloc/ContractBloc.dart';
import 'package:my_app/features/contract/bloc/ContractEvent.dart';
import 'package:my_app/services/sync_manager.dart';
import 'package:my_app/widgets/CustomLink.dart';
import 'package:my_app/widgets/CustomTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Chào mừng, ${state.user.full_name}!")),
            );
            Navigator.pushReplacementNamed(context, "/home");

            context.read<ContractBloc>().add(SyncContractsFromServer());
            SyncManager().initialize(context.read<ContractBloc>());
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.lightBlueAccent],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.account_circle,
                      size: 100, color: Colors.white),
                  const SizedBox(height: 20),
                  const Text(
                    'Đăng Nhập',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 40),
                  CustomTextField(
                    controller: _emailController,
                    label: 'Tên đăng nhập',
                    icon: Icons.email,
                    isPassword: false,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _passwordController,
                    label: 'Mật khẩu',
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: state is AuthLoading
                              ? null
                              : () {
                                  context.read<AuthBloc>().add(
                                        LoginEvent(
                                          username:
                                              _emailController.text.trim(),
                                          password: _passwordController.text,
                                        ),
                                      );
                                },
                          child: state is AuthLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'ĐĂNG NHẬP',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      // TODO: forgot password
                    },
                    child: const Text('Quên mật khẩu?',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 20),
                  CustomLink(
                    text: "Đăng ký ngay",
                    titleColor: Colors.white,
                    textColor: Colors.black,
                    route: "register",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
