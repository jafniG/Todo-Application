import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:todo_task_app/controller/project_controller.dart';
import 'package:todo_task_app/controller/task_controller.dart';
import 'package:todo_task_app/models/project_data_model.dart';
import 'package:todo_task_app/services/firebase_database_service.dart';
import 'package:todo_task_app/views/task_screen.dart';
import 'package:todo_task_app/views/widgets/project_card_widget.dart';

class ProjectDashboard extends StatefulWidget {
  ProjectDashboard({super.key});
  final TaskController controller = Get.find();
  @override
  State<ProjectDashboard> createState() => _ProjectDashboardState();
}

class _ProjectDashboardState extends State<ProjectDashboard> {
  final ProjectController projectController = Get.find();

  late TextEditingController titleTxtController;
  late TextEditingController descriptionTxtController;

  @override
  void initState() {
    titleTxtController = TextEditingController();
    descriptionTxtController = TextEditingController();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
            return desktopProjectScreen(context);
          }
          if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
            return mobileProjectPage(context);
          }
          return Center(
            child: Text(
              "Reduce or increase the screen size to obtain the clear layout",
            ),
          );
        },
      ),
    );
  }

  @override
  Widget mobileProjectPage(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Obx(() {
            return projectController.listOfProjects.isEmpty
                ? Center(
                    child: Text(
                      "Click the + icon to add your first project",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  )
                : ListView(
                    children: projectController.listOfProjects
                        .map((element) => buildProjectCard(project: element))
                        .toList(),
                  );
          }),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 300,
        height: 80,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: .circular(50)),
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: .w500,
                        color: Colors.black,
                      ),
                    ),
                    TextFormField(
                      controller: titleTxtController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),

                    Text(
                      "Description:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: .w500,
                        color: Colors.black,
                      ),
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

  Widget desktopProjectScreen(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Obx(() {
            return projectController.listOfProjects.isEmpty
                ? Center(
                    child: Text(
                      "Click the + icon to add your first project",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  )
                : GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 180,
                      crossAxisCount: 2,
                    ),
                    children: projectController.listOfProjects
                        .map((element) => buildProjectCard(project: element))
                        .toList(),
                  );
          }),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 300,
        height: 80,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: .circular(50)),
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: .w500,
                        color: Colors.black,
                      ),
                    ),
                    TextFormField(
                      controller: titleTxtController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),

                    Text(
                      "Description:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: .w500,
                        color: Colors.black,
                      ),
                    ),
                    TextFormField(
                      controller: descriptionTxtController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(borderRadius: .circular(10)),
                          ),
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.deepPurple,
                          ),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                        ),
                        onPressed: () async {
                          final project = ProjectDataModel(
                            title: titleTxtController.text,
                            description: descriptionTxtController.text,
                          );
                          await projectController.addProject(project);
                          Get.back();
                        },
                        child: Text("Submit"),
                      ),
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
