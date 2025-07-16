import 'package:get/get.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  var name = ''.obs;
  var selectedUser = ''.obs;
  var users = <UserModel>[].obs;
  var isLoading = false.obs;
  var page = 1.obs;
  var hasMore = true.obs;

  void reset() {
    users.clear();
    page.value = 1;
    hasMore.value = true;
  }

  Future<void> fetchUsers({bool isRefresh = false}) async {
    if (isRefresh) reset();
    if (!hasMore.value || isLoading.value) return;

    isLoading.value = true;
    final response = await GetConnect().get(
      'https://reqres.in/api/users?page=1&per_page=8',
      headers: {'x-api-key': 'reqres-free-v1'},
    );
    if (response.statusCode == 200) {
      final data = response.body['data'] as List;
      if (data.isEmpty) {
        hasMore.value = false;
      } else {
        users.addAll(data.map((e) => UserModel.fromJson(e)));
        page.value++;
      }
    }
    isLoading.value = false;
  }

  void selectUser(String fullName) {
    selectedUser.value = fullName;
    Get.back();
  }
}
