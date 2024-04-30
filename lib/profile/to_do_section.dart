import 'package:dermatologist/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class ToDoSection extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    // Add the default tasks when the screen is loaded for the first time only
    if (profileController.toDoList.isEmpty) {
      profileController.addToDoTask("Use a daily moisturizer");
      profileController.addToDoTask("Cleanse your skin");
      profileController.addToDoTask("Protect with sunscreen");
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '  Your Skin Routine for Today:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: 10),
          Obx(
                () => ListView.builder(
              shrinkWrap: true,
              itemCount: profileController.toDoList.length,
              itemBuilder: (context, index) {
                final task = profileController.toDoList[index];
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  secondaryActions: [
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        profileController.deleteTask(index);
                      },
                    ),
                  ],
                  child: ListTile(
                    leading: Checkbox(
                      activeColor: Colors.teal,
                      value: task.isDone,
                      onChanged: (value) {
                        profileController.setTaskDone(index, value ?? false);
                      },
                    ),
                    title: Text(
                      task.name,
                      style: TextStyle(
                        decoration:
                        task.isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
