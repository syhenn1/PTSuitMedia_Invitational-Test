import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userC = Get.find<UserController>();
    final scrollC = ScrollController();

    scrollC.addListener(() {
      if (scrollC.position.pixels >= scrollC.position.maxScrollExtent - 200 &&
          userC.hasMore.value) {
        userC.fetchUsers();
      }
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shadowColor: Colors.black.withOpacity(0.2),
        title: const Text(
          'Third Screen',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Image.asset('assets/images/back.png', width: 24, height: 24),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.withOpacity(0.3)),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Obx(() {
          if (userC.users.isEmpty && userC.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (userC.users.isEmpty) {
            return const Center(child: Text('No users available.'));
          } else {
            return RefreshIndicator(
              onRefresh: () async => userC.fetchUsers(isRefresh: true),
              child: ListView.builder(
                controller: scrollC,
                itemCount: userC.users.length,
                itemBuilder: (_, i) {
                  final user = userC.users[i];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFE0E0E0),
                          width: 1,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar),
                        radius: 24,
                      ),
                      title: Text(
                        '${user.firstName} ${user.lastName}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () => userC.selectUser(
                        '${user.firstName} ${user.lastName}',
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }),
      ),
    );
  }
}
