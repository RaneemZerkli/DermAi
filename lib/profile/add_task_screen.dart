import 'package:dermatologist/profile/profile_controller.dart';
import 'package:dermatologist/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskScreen extends StatelessWidget {
  final ProfileController profileController = Get.find();
  final TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add new skincare tip'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: taskController,
                decoration: InputDecoration(labelText: 'e.g. Apply facial serum'),
              ),
              const SizedBox(height: 20),

              const SizedBox(height: 20),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.teal,
                onPressed: () {
                  // Add the task to the to-do list if it's not empty
                  String taskDescription = taskController.text.trim();
                  if (taskDescription.isNotEmpty) {
                    profileController.addToDoTask(taskDescription);
                    Get.back(); // Go back to the previous screen
                  } else {
                    Get.snackbar(
                      'Error',
                      'Skincare routine cannot be empty',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 50),
              Image.asset(
                'assets/1.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
