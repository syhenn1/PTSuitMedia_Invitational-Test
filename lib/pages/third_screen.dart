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
      if (scrollC.position.pixels >=
              scrollC.position.maxScrollExtent - 200 &&
          userC.hasMore.value) {
        userC.fetchUsers();
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Third Screen')),
      body: Obx(() {
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
                return ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email),
                  onTap: () => userC.selectUser('${user.firstName} ${user.lastName}'),
                );
              },
            ),
          );
        }
      }),
    );
  }
}