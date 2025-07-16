import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import 'second_screen.dart';
import '../components/alertcard.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with TickerProviderStateMixin {
  final nameController = TextEditingController();
  final sentenceController = TextEditingController();
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isPalindrome(String text) {
    final cleaned = text.replaceAll(RegExp(r'\s+'), '').toLowerCase();
    return cleaned == cleaned.split('').reversed.join();
  }

  void showResult() {
    final sentence = sentenceController.text;
    final isPalin = isPalindrome(sentence);

    final result = isPalin
        ? '"$sentence" is a Palindrome!'
        : '"$sentence" is not a Palindrome!';

    showTopSnackBar(
      result,
      isPalin ? NotificationType.success : NotificationType.error,
    );
  }

  void goToSecond() {
    if (nameController.text.trim().isEmpty) return;
    Get.find<UserController>().name.value = nameController.text.trim();
    Get.to(() => const SecondScreen());
  }

  void showTopSnackBar(String message, NotificationType type) {
    final overlay = Overlay.of(context);
    final bgColor = switch (type) {
      NotificationType.success => Colors.green.shade600,
      NotificationType.warning => Colors.orange.shade700,
      NotificationType.error => Colors.red.shade600,
    };
    final icon = switch (type) {
      NotificationType.success => Icons.check_circle,
      NotificationType.warning => Icons.warning_amber_rounded,
      NotificationType.error => Icons.cancel_rounded,
    };

    final animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    final animation =
        Tween<Offset>(
          begin: const Offset(0, -1), // Start di luar layar atas
          end: const Offset(0, 0), // Akhir di posisi normal
        ).animate(
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        );

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 16,
        left: 16,
        right: 16,
        child: SlideTransition(
          position: animation,
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    animationController.forward();

    Future.delayed(const Duration(seconds: 2), () async {
      await animationController.reverse();
      entry.remove();
      animationController.dispose();
    });
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 192, 24, 0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(36),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(98, 255, 255, 255),
                ),
                child: Image.asset(
                  'assets/images/addperson.png',
                  width: 65,
                  height: 65,
                ),
              ),
              SizedBox(height: 64),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  hintText: 'Name',
                  contentPadding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(104, 103, 119, 0.36),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: const Color.fromRGBO(1, 50, 55, 0.25),
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: const Color.fromRGBO(1, 50, 55, 0.25),
                      width: 1.0,
                    ),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24),
              TextField(
                controller: sentenceController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  hintText: 'Palindrome',
                  contentPadding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(104, 103, 119, 0.36),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: const Color.fromRGBO(1, 50, 55, 0.25),
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: const Color.fromRGBO(1, 50, 55, 0.25),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                height: 41,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: showResult,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: const Color(0xFF2B637B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  child: Text(
                    'CHECK',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 41,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: goToSecond,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: const Color(0xFF2B637B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  child: Text(
                    'NEXT',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
