import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import 'second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final nameController = TextEditingController();
  final sentenceController = TextEditingController();

  bool isPalindrome(String text) {
    final cleaned = text.replaceAll(RegExp(r'\s+'), '').toLowerCase();
    return cleaned == cleaned.split('').reversed.join();
  }

  void showResult() {
    final sentence = sentenceController.text;
    final result = isPalindrome(sentence)
        ? '"$sentence" is a palindrome'
        : '"$sentence" is not a palindrome';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(result),
        actions: [TextButton(onPressed: () => Get.back(), child: Text('OK'))],
      ),
    );
  }

  void goToSecond() {
    if (nameController.text.trim().isEmpty) return;
    Get.find<UserController>().name.value = nameController.text.trim();
    Get.to(() => const SecondScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/firstscreenBg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Enter your name'),
            ),
            TextField(
              controller: sentenceController,
              decoration: const InputDecoration(labelText: 'Enter a sentence'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: showResult, child: const Text('Check')),
            ElevatedButton(onPressed: goToSecond, child: const Text('Next')),
          ],
        ),
      ),
    );
  }
}
