import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/auth/bloc/AuthBloc.dart';
import 'package:my_app/features/auth/repositories/AuthRepository.dart';
import 'package:my_app/features/auth/screen/LoginScreen.dart';
import 'package:my_app/features/auth/screen/RegisterScreen.dart';
import 'package:my_app/features/contract/bloc/ContractBloc.dart';
import 'package:my_app/features/contract/repositories/ContractRepository.dart';
import 'package:my_app/features/contract/screen/HomeScreen.dart';
import 'package:my_app/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initialize();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(AuthRepository())),
        BlocProvider(create: (_) => ContractBloc(ContractRepository())),
      ],
      child: MaterialApp(
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
          "/register": (context) => RegisterScreen(),
        },
      ),
    ),
  );
}
