import 'package:dermatologist/Authentication/login/login-model.dart';
import 'package:dermatologist/profile/profile_controller.dart';
import 'package:dermatologist/profile/to_do_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Authentication/login/login-model.dart';
import 'add_task_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find(); // Retrieve ProfileController instance

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title:  Text(  'Welcome to DermAI ', style: TextStyle(color: Colors.white)),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            ToDoSection(),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Navigate to the AddTaskScreen when tapped
                Get.to(AddTaskScreen());
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(25)),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                  child: const Text(
                    '        Add More        ',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
