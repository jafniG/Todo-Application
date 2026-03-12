import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_task_app/controller/project_controller.dart';
import 'package:todo_task_app/controller/task_controller.dart';
import 'package:todo_task_app/models/project_data_model.dart';
import 'package:todo_task_app/services/firebase_database_service.dart';
import 'package:todo_task_app/views/task_screen.dart';
import 'package:todo_task_app/views/widgets/project_card_widget.dart';

class ProjectDashboard extends StatefulWidget {
  const ProjectDashboard({super.key});

  @override
  State<ProjectDashboard> createState() => _ProjectDashboardState();
}

class _ProjectDashboardState extends State<ProjectDashboard> {
  final TaskController controller = Get.find();
  final ProjectController projectController = Get.find();

  late TextEditingController titleTxtController;
  late TextEditingController descriptionTxtController;
  late TextEditingController timeTxtController;

  @override
  void initState() {
    titleTxtController = TextEditingController();
    descriptionTxtController = TextEditingController();
    timeTxtController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: projectController.listOfProjects.isEmpty
              ? Center(
                  child: Text(
                    "Click the + icon to add your first project",
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
                  ),
                )
              : Obx(
                  () => ListView(
                    children: projectController.listOfProjects
                        .map((element) => buildProjectCard(project: element))
                        .toList(),
                  ),
                ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 300,
        height: 80,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: .circular(50)),
          backgroundColor: Colors.white,
          foregroundColor: Colors.deepPurple,
          onPressed: () {
            Get.bottomSheet(
              Container(
                padding: .all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: .circular(20),
                ),

                width: Get.width,

                child: Column(
                  spacing: 10,
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      "Title:",
                      style: TextStyle(fontSize: 18, fontWeight: .w500),
                    ),
                    TextFormField(
                      controller: titleTxtController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),

                    Text(
                      "Description:",
                      style: TextStyle(fontSize: 18, fontWeight: .w500),
                    ),
                    TextFormField(
                      controller: descriptionTxtController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.deepPurple,
                        ),
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                      ),
                      onPressed: () async {
                        final project = ProjectDataModel(
                          title: titleTxtController.text,
                          description: descriptionTxtController.text,
                          time: timeTxtController.text,
                        );
                        await projectController.addProject(project);
                        Get.back();
                      },
                      child: Text("Submit"),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Row(
            spacing: 8,
            mainAxisAlignment: .center,
            children: [
              Icon(Icons.add),
              Text("Add Project", style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: .centerFloat,
    );
  }
}
