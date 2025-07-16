// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/user_controller.dart';
import 'pages/first_screen.dart';

void main() {
  // Inisialisasi controller GetX secara global
  Get.put(UserController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Palindrome App',
      debugShowCheckedModeBanner: false,
      home: const FirstScreen(),
    );
  }
}
