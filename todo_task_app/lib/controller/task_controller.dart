import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_task_app/models/project_data_model.dart';
import 'package:todo_task_app/models/tasks_data_model.dart';
import 'package:todo_task_app/services/firebase_database_service.dart';

class TaskController extends GetxController {
  final current_index = 0.obs;
  final weekOffset = 0.obs;
  final FirebaseDatabaseService firebaseData = FirebaseDatabaseService();
  final projectList = <ProjectDataModel>[].obs;
  final selectedProject = Rxn<ProjectDataModel>();
  final todoList = <TasksDataModel>[].obs;
  final date = ''.obs;

  @override
  void onInit() {
    getTasks();
    dateFormat();
    loadProjects();
    super.onInit();
  }

  void selectedPage(int value) {
    current_index.value = value;
  }

  void dateFormat() {
    DateTime now = DateTime.now();
    date.value = DateFormat.yMMMd().format(now);
  }

  Future<void> loadProjects() async {
    final val = await firebaseData.getProjects();
    projectList.value = val;
  }

  Future<void> getTasks() async {
    final val = await firebaseData.getTasks();
    todoList.value = val;
  }

  Future<void> addTask(TasksDataModel task) async {
    await firebaseData.addTasks(tasks: task);
    await getTasks();
  }

  Future<void> updateTask(TasksDataModel task) async {
    await firebaseData.updateTask(task: task);
    await getTasks();
  }
}
