import 'package:buktorgrow/services/api_services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../screens/chat_list.dart';
// Your AuthService location

class LoginController extends GetxController {
  var isLoading = false.obs;

  final AuthService _authService = AuthService();

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      bool? result = await _authService.login(email, password);
      isLoading.value = false;

      if (result == true) {
        // Navigate to the chat list page on success
        Get.to(() => const ChatList());
      } else {
        // Show error message
        Get.snackbar('Error', 'Invalid login credentials');
      }
    } catch (e) {
      isLoading.value = false;
      // Handle error
      Get.snackbar('Error', 'Failed to login: ${e.toString()}');
    }
  }
}
