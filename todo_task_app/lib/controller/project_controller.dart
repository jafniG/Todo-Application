import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';
import 'package:todo_task_app/models/project_data_model.dart';
import 'package:todo_task_app/models/tasks_data_model.dart';
import 'package:todo_task_app/services/firebase_database_service.dart';

class ProjectController extends GetxController {
  final listOfProjects = <ProjectDataModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getProject();
  }

  Future<void> addProject(ProjectDataModel project) async {
    await FirebaseDatabaseService().addprojects(project: project);
    await getProject();
  }

  Future<void> getProject() async {
    final list = await FirebaseDatabaseService().getProjects();
    listOfProjects.value = list;
  }

  Future<void> updateProject({
    required String docId,
    required String description,
    required String title,
  }) async {
    await FirebaseFirestore.instance
        .collection('projects')
        .doc(docId)
        .update({'title': title, 'description': description})
        .then((value) => log("Project Updated"))
        .catchError((error) => log("Failed to update Project: $error"));

    await getProject();
  }

  Future<void> deleteProject(String docId) async {
    await FirebaseFirestore.instance
        .collection('projects')
        .doc(docId)
        .delete()
        .then((value) => log("Project Deleted"))
        .catchError((error) => log("Failed to delete Project: $error"));
    await getProject();
  }
}
