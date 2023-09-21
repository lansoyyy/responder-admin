import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:responder_admin/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          authDomain: 'responder-67a90.firebaseapp.com',
          apiKey: "AIzaSyA12fFunT5kbj2TmPZIBiSjImXsoPM3pi",
          appId: "1:697586667913:web:f4701a7d869d013082d158",
          messagingSenderId: "697586667913",
          projectId: "responder-67a90",
          storageBucket: "responder-67a90.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ADMIN',
      home: HomeScreen(),
    );
  }
}
