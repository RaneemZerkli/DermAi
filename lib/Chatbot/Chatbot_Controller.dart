import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Chatbot_Model.dart';

class Chatbot_Controller extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  RxList<String> messages = <String>[].obs;
  RxBool isLoading = false.obs;

  void onInit() {
    // Listen to changes in the 'messages' list and update the UI
    ever(messages, (_) => update());
    super.onInit();
  }

  void sendMessage() async {
    final message = textEditingController.text;
    if (message.isNotEmpty) {
      messages.add(message);
      textEditingController.clear();
      isLoading.value = true;

      // Generate or retrieve the response based on the user's input
      final response = await generateResponse(message);
      messages.add(response);
    }
    isLoading.value = false;
  }

  Future<String> generateResponse(String message) async {
    await Future.delayed(Duration(seconds: 2));
    final apiUrl = 'https://chatbot10-g7vj.onrender.com/predict';
    final userInput = UserInput(predictionInput: message);
    final requestBody = jsonEncode(userInput.toJson());

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody is List) {
        // If the response body is an array, extract the first item as a string
        final prediction = responseBody.first.toString();
        return prediction;
      } else {
        // If the response body is not an array, handle it as a single string
        final prediction = responseBody.toString();
        return prediction;
      }
    } else if (response.statusCode == 422) {
      final errorResponse = HTTPValidationError.fromJson(jsonDecode(response.body));
      // Handle validation error response
      return 'Validation Error: ${errorResponse.detail.first.msg}';
    } else {
      // Handle other error responses
      return 'Sorry, something went wrong. Please try again later.';
    }
  }


  void handleUserInput(String input) {

  }
}

