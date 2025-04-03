import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/auth/bloc/AuthBloc.dart';
import 'package:my_app/features/auth/repositories/AuthRepository.dart';
import 'package:my_app/features/auth/screen/LoginScreen.dart';
import 'package:my_app/features/auth/screen/RegisterScreen.dart';
import 'package:my_app/features/contract/screen/HomeScreen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(AuthRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        routes: {
          "/home": (context) => HomeScreen(),
          "/register": (context) => RegisterScreen(),
        },
      ),
    ),
  );
}
