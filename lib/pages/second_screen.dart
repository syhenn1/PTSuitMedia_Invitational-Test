import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import 'third_screen.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userC = Get.find<UserController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome', style: TextStyle(fontSize: 24)),
            Obx(() => Text(userC.name.value, style: const TextStyle(fontSize: 20))),
            const SizedBox(height: 16),
            const Text('Selected User:', style: TextStyle(fontWeight: FontWeight.bold)),
            Obx(() => Text(userC.selectedUser.value.isEmpty
                ? 'None'
                : userC.selectedUser.value)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                userC.fetchUsers();
                Get.to(() => const ThirdScreen());
              },
              child: const Text('Choose a User'),
            ),
          ],
        ),
      ),
    );
  }
}