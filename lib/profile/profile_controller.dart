import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

import 'package:timezone/timezone.dart' as tz;
class ProfileController extends GetxController {
  RxString firstName = ''.obs;
  RxList<Task> toDoList = <Task>[].obs;

  Timer? resetTimer;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    loadSavedData();
    startResetTimer();
    initializeNotifications();
  }

  void initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void addToDoTask(String taskDescription) {
    final task = Task(name: taskDescription, isDone: false);
    toDoList.add(task);
    saveData();

    // Schedule a notification for the added task
    final notificationId = toDoList.indexOf(task) + 1;
    final taskTime = DateTime.now().add(const Duration(minutes: 2));
    scheduleNotification(notificationId, taskDescription, taskTime);
  }

  void scheduleNotification(
      int notificationId, String taskDescription, DateTime taskTime) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id', // Replace with your desired channel ID
      'your_channel_name', // Replace with your desired channel name

      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    final scheduledDate = tz.TZDateTime.from(taskTime, tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      taskDescription,
      '',
      scheduledDate,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'task', // Optional payload for identifying the notification
    );
  }

  DateTime _nextInstanceOfTaskTime() {
    final now = DateTime.now();
    final nextTaskTime = DateTime(now.year, now.month, now.day, 21, 5, 0);

    // If the current time is after the next task time, schedule it for the next day
    if (now.isAfter(nextTaskTime)) {
      return nextTaskTime.add(const Duration(days: 1));
    } else {
      return nextTaskTime;
    }
  }
  void setTaskDone(int index, bool isDone) {
    if (index >= 0 && index < toDoList.length) {
      toDoList[index].isDone = isDone;
      toDoList.refresh(); // Refresh the RxList to update the UI
      saveData();
    }
  }

  void deleteTask(int index) {
    if (index >= 0 && index < toDoList.length) {
      toDoList.removeAt(index);
      saveData();
    }
  }

  bool isTaskDone(int index) {
    if (index >= 0 && index < toDoList.length) {
      return toDoList[index].isDone;
    }
    return false;
  }

  Future<void> loadSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? savedFirstName = prefs.getString('firstName');
      if (savedFirstName != null) {
        firstName.value = savedFirstName;
      }

      final List<String>? taskList = prefs.getStringList('toDoList');
      if (taskList != null) {
        toDoList.value = taskList
            .map((task) => Task.fromJson(jsonDecode(task)))
            .toList()
            .obs;
      }
    } catch (e) {
      // Handle any exceptions
    }
  }

  Future<void> saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('firstName', firstName.value);

      final List<String> encodedTasks =
      toDoList.map((task) => jsonEncode(task.toJson())).toList();
      prefs.setStringList('toDoList', encodedTasks);
    } catch (e) {
      // Handle any exceptions
    }
  }

  void startResetTimer() {
    final now = DateTime.now();
    final resetTime = DateTime(now.year, now.month, now.day + 1);
    final difference = resetTime.difference(now);

    resetTimer = Timer(difference, () {
      resetCheckBoxes();
      startResetTimer();
    });
  }

  void resetCheckBoxes() {
    toDoList.forEach((task) => task.isDone = false);
    saveData();
  }

  @override
  void onClose() {
    resetTimer?.cancel();
    super.onClose();
  }
}

class Task {
  String name;
  bool isDone;

  Task({required this.name, this.isDone = false});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      name: json['name'] as String,
      isDone: json['isDone'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isDone': isDone,
    };
  }
}
