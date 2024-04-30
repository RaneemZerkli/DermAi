import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Chatbot/Chatbot_Screen.dart';
import '../../profile/profile_controller.dart';
import '../../profile/profile_screen.dart';
import 'login-model.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;
  final Rx<User?> user = Rx<User?>(null);

  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter both email and password',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    // Send the login request to the API
    try {
      final response = await http.post(
        Uri.parse('https://skincareapp69.onrender.com/api/login/'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print('Signin failed with status code: ${response.statusCode}');
      print('Signin response: ${response.body}');
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final authenticatedUser = User(
          email: email,
          token: responseData['token'],
        );

        // Store the authenticated user and handle further actions
        user.value = authenticatedUser;
        isLoggedIn.value = true;
        Get.put(ProfileController()); // Initialize ProfileController

        // Navigate to the home screen or any other screen
        Get.offAll(() => ProfileScreen());
      }  else if (response.statusCode == 404) {
        // User does not exist
        Get.snackbar(
          'Authentication Failed',
          'User does not exist',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (response.statusCode == 403) {
        // Please verify your email address
        Get.snackbar(
          'Authentication Failed',
          'Please verify your email address',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (response.statusCode == 401) {
        // Incorrect password
        Get.snackbar(
          'Authentication Failed',
          'Incorrect password',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        // Authentication failed for other reasons
        Get.snackbar(
          'Authentication Failed',
          'An error occurred while authenticating',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Error occurred while making the API call
      Get.snackbar(
        'Error',
        'An error occurred while authenticating',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
