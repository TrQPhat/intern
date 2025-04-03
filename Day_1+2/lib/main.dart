import 'package:flutter/material.dart';
import 'package:tuan_01/screen/HomeScreen.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 227, 216, 246),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo'),
      debugShowCheckedModeBanner: false,
    );
  }
}
