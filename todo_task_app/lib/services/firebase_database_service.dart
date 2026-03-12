// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_task_app/models/project_data_model.dart';
import 'package:todo_task_app/models/tasks_data_model.dart';

class FirebaseDatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<ProjectDataModel>> getProjects() async {
    final snapshot = await firestore.collection("projects").get();
    final snapShotData = snapshot.docs.map((e) {
      final mapData = e.data();
      var data = ProjectDataModel.fromMap(mapData);
      data = data.copyWith(id: e.id);
      return data;
    }).toList();

    return snapShotData;
  }

  Future<void> addprojects({required ProjectDataModel project}) {
    CollectionReference users = FirebaseFirestore.instance.collection(
      'projects',
    );

    return users
        .add(project.toMap())
        .then((value) => log("Project added successfully!"))
        .catchError((error) => log("Failed to add project: $error"));
  }


  Future<List<TasksDataModel>> getTasks() async {
    final snapshot = await firestore.collection('tasks').get();
    final snapshotData = snapshot.docs.map((e) {
      final mapData = e.data();
      var data = TasksDataModel.fromMap(mapData);
      data = data.copyWith(id: e.id);
      return data;
    }).toList();
    return snapshotData;
  }
  
  Future<void> addTasks({required TasksDataModel tasks}) {
    CollectionReference users = FirebaseFirestore.instance.collection('tasks');

    return users
        .add(tasks.toMap())
        .then((value) => log("Project added successfully!"))
        .catchError((error) => log("Failed to add project: $error"));
  }

  Future<void> updateTask({
 required TasksDataModel task
  }) async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(task.id)
        .update(task.toMap())
        .then((value) => log("Task Updated"))
        .catchError((error) => log("Failed to update Task: $error"));
  }

}
