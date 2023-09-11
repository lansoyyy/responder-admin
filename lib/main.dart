import 'package:flutter/material.dart';
import 'package:responder_admin/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ADMIN',
      home: LoginScreen(),
    );
  }
}
