import 'package:dermatologist/Authentication/login/loginScreen.dart';
import 'package:dermatologist/Chatbot/Chatbot_Screen.dart';
import 'package:dermatologist/profile/profile_controller.dart';
import 'package:dermatologist/profile/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'onBoarding/OnBoardingScreen.dart';

void main() {
  Get.put(ProfileController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: OnBoardingScreen(),
    );
  }
}
