import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:todo_task_app/controller/project_controller.dart';
import 'package:todo_task_app/controller/task_controller.dart';
import 'package:todo_task_app/models/project_data_model.dart';

Widget buildProjectCard({required ProjectDataModel project}) {
  final ProjectController projectController = Get.find();
  final TaskController controller = Get.find();

  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(20),
    ),
    child: Container(
      padding: .all(20),
      decoration: BoxDecoration(
        // color: Colors.deepPurple.withOpacity(0.3),
        borderRadius: .circular(20),
        gradient: LinearGradient(
          begin: .topLeft,
          end: .bottomRight,
          colors: [Colors.deepPurple, Colors.deepPurple.shade200],
        ),
      ),
      height: 180,
      width: Get.width,
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                project.title ?? '',
                maxLines: 2,
                overflow: .ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: .w600,
                ),
              ),

              PopupMenuButton<String>(
                iconColor: Colors.white,
                onSelected: (String result) {},
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'edit',
                    onTap: () {
                      final editTitleController = TextEditingController(
                        text: project.title,
                      );
                      final editDescriptionController = TextEditingController(
                        text: project.description,
                      );
                      Get.bottomSheet(
                        Container(
                          padding: const EdgeInsets.all(20),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              const Text(
                                "Edit Project",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 20),

                              const Text("Title"),

                              TextField(
                                controller: editTitleController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),

                              const SizedBox(height: 10),

                              const Text("Description"),

                              TextField(
                                controller: editDescriptionController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),

                              const SizedBox(height: 20),

                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                    foregroundColor: Colors.white,
                                  ),

                                  onPressed: () {
                                    if (project.id == null) {
                                      return;
                                    }
                                    projectController.updateProject(
                                      docId: project.id!,
                                      title: editTitleController.text,
                                      description:
                                          editDescriptionController.text,
                                    );

                                    Get.back();
                                  },

                                  child: const Text("Update"),
                                ),
                              ),
                            ],
                          ),
                        ),

                        isScrollControlled: true,
                      );
                    },
                    child: Row(
                      spacing: 10,
                      children: [Icon(Icons.edit, size: 20), Text('Edit')],
                    ),
                  ),
                  PopupMenuItem<String>(
                    onTap: () {
                      if (project.id == null) {
                        return;
                      }
                      projectController.deleteProject(project.id!);
                    },
                    value: 'delete',
                    child: Row(
                      spacing: 10,
                      children: [Icon(Icons.delete, size: 20), Text('Delete')],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            maxLines: 2,
            overflow: .ellipsis,
            project.description ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: .w400,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Row(
                spacing: 6,
                children: [
                  Icon(Icons.timelapse, color: Colors.white, size: 16),
                  Obx(
                    () => Text(
                      controller.date.value,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: .end,
                children: [
                  Align(
                    widthFactor: 0.6,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage(
                        'assets/images/girl_avatar.png',
                      ),
                    ),
                  ),
                  Align(
                    widthFactor: 0.4,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage(
                        'assets/images/girl_avatar.png',
                      ),
                    ),
                  ),
                  Align(
                    widthFactor: 0.4,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage(
                        'assets/images/girl_avatar.png',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
