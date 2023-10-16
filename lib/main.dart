import 'package:flutter/material.dart';
import 'package:login/modules/auth/auth.dart';
import 'package:login/modules/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
      home: const Auth(),
      routes: {
        '/auth': (context) => const Auth(),
        '/home': (context) => const Home(),
      },
    );
  }
}
