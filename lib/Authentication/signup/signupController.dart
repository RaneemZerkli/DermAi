import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../login/login-model.dart';

class SignupController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.toggle();
  }

  Future<void> signUp() async {
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      // Create the signup request data object
      final signupRequest = SignupRequest(
        first_name: firstName,
        last_name: lastName,
        email: email,
        password: password,
      );

      // Send the signup request to the API
      final response = await http.post(
        Uri.parse('https://skincareapp69.onrender.com/api/signup/'),
        body: jsonEncode(signupRequest.toJson()),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      final responseBody = response.body;
      print('Signup failed with status code: ${response.statusCode}');
      print('Response body: $responseBody');

      if (response.statusCode == 201) {
        // Signup successful
        final responseData = jsonDecode(response.body);
        final token = responseData['token'] ?? '';
        final message = responseData['message'] ?? '';
        final status = responseData['status'] ?? '';

        final signupResponse = SignupResponse(
          token: token,
          message: message,
          status: status,
        );

        // Clear the form fields
        firstNameController.clear();
        lastNameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();

        Get.back(); // Close the loading dialog

        // Handle the signup response accordingly
        handleSignupResponse(signupResponse);
      }
      else if (response.statusCode == 202) {
        Get.back();
        // Account verification required
        Get.snackbar(
          'Account Verification',
          'Please verify your account. We have sent you a verification email!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orangeAccent,
          colorText: Colors.white,
        );

      }



      else if (response.statusCode == 409) {
        // Email already exists in the database
        Get.back(); // Close the loading dialog

        // Print the response body


        Get.snackbar(
          'Error',
          'Email already Signed up',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        // Signup failed for other reasons
        Get.back(); // Close the loading dialog



        Get.snackbar(
          'Error',
          'Signup failed',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Error occurred while making the API call
      Get.back(); // Close the loading dialog
      Get.snackbar(
        'Error',
        'An error occurred',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error: $e');
    }
  }

  void handleSignupResponse(SignupResponse response) {
    if (response.message == 'User created successfully.') {
      // Signup successful
      Get.snackbar(
        'Success',
        response.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      // Signup failed
      Get.snackbar(
        'Error',
        response.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
