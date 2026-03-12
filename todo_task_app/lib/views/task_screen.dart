import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:todo_task_app/controller/task_controller.dart';
import 'package:todo_task_app/models/project_data_model.dart';
import 'package:todo_task_app/models/tasks_data_model.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "My Tasks",
          style: TextStyle(
            fontSize: 22,
            fontWeight: .w600,
            color: Colors.deepPurple.shade900,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.deepPurple),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
                fixedSize: WidgetStatePropertyAll(Size(150, 10)),
              ),
              onPressed: () async {
                controller.loadProjects();
                if (controller.projectList.isEmpty) {
                  Get.snackbar(
                    "No Projects",
                    "Create a project first before adding the tasks",
                    backgroundColor: Colors.deepPurple.shade400,
                    colorText: Colors.white,
                  );
                } else {
                  Get.bottomSheet(
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: addTaskBottomSheet(),
                      ),
                    ),
                    isScrollControlled: true,
                  );
                }
              },
              child: Text("Add Task"),
            ),
          ),
        ],
      ),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
            return desktopTaskView();
          }
          if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
            return mobileTaskView();
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

  Widget mobileTaskView() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: .start,
              spacing: 10,
              mainAxisSize: .min,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Container(
                      width: 80,
                      height: 22,
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: .circular(20),
                      ),
                      child: Text(
                        "Todo",
                        style: TextStyle(color: Colors.red.shade900),
                        textAlign: .center,
                      ),
                    ),
                  ],
                ),

                Container(
                  padding: .all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,

                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: DragTarget<TasksDataModel>(
                    onAccept: (data) async {
                      final task = data.copyWith(type: TaskType.todo);
                      await controller.updateTask(task);
                      Get.snackbar(
                        "Task Updated!",
                        "Task moved back to todo",
                        backgroundColor: Colors.deepPurple.shade400,
                        colorText: Colors.white,
                      );
                      log("onAccept: $data");
                    },
                    builder: (context, candidateData, _) => Obx(() {
                      final tasks = controller.todoList
                          .where((element) => element.type == TaskType.todo)
                          .toList();
                      return SizedBox(
                        height: 210,
                        child: ListView.separated(
                          scrollDirection: .horizontal,
                          itemBuilder: (context, index) {
                            final task = tasks.elementAt(index);
                            return Card(elevation: 4, child: taskCard(task));
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 10),
                          itemCount: tasks.length,
                        ),
                      );
                    }),
                  ),
                ),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      "In Progress",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: .w600,
                        color: Colors.deepPurple.shade900,
                      ),
                    ),

                    Container(
                      width: 100,
                      height: 22,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: .circular(20),
                      ),
                      child: Text(
                        "In-Progress",
                        style: TextStyle(color: Colors.blue.shade900),
                        textAlign: .center,
                      ),
                    ),
                  ],
                ),

                Container(
                  padding: .all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,

                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: DragTarget<TasksDataModel>(
                    onAccept: (data) async {
                      final task = data.copyWith(type: TaskType.progress);
                      await controller.updateTask(task);
                      Get.snackbar(
                        "Task Updated!",
                        "Task moved to Inprogress",
                        backgroundColor: Colors.deepPurple.shade400,
                        colorText: Colors.white,
                      );
                      log("onAccept: $data");
                    },

                    builder: (context, candidateData, _) => Obx(() {
                      final tasks = controller.todoList
                          .where((element) => element.type == TaskType.progress)
                          .toList();
                      return SizedBox(
                        height: 210,
                        child: ListView.separated(
                          scrollDirection: .horizontal,
                          itemBuilder: (context, index) {
                            final task = tasks.elementAt(index);
                            return Card(elevation: 4, child: taskCard(task));
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 10),
                          itemCount: tasks.length,
                        ),
                      );
                    }),
                  ),
                ),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      "Completed",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: .w600,
                        color: Colors.deepPurple.shade900,
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 22,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: .circular(20),
                      ),
                      child: Text(
                        "completed",
                        style: TextStyle(color: Colors.green.shade900),
                        textAlign: .center,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: .all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,

                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: DragTarget<TasksDataModel>(
                    onAccept: (data) async {
                      final task = data.copyWith(type: TaskType.completed);
                      await controller.updateTask(task);
                      Get.snackbar(
                        "Task Finished!",
                        "Task moved to Completed",
                        backgroundColor: Colors.deepPurple.shade400,
                        colorText: Colors.white,
                      );
                      log("onAccept: $data");
                    },

                    builder: (context, candidateData, _) => Obx(() {
                      final tasks = controller.todoList
                          .where(
                            (element) => element.type == TaskType.completed,
                          )
                          .toList();
                      return SizedBox(
                        height: 210,
                        child: ListView.separated(
                          scrollDirection: .horizontal,
                          itemBuilder: (context, index) {
                            final task = tasks.elementAt(index);
                            return Card(elevation: 4, child: taskCard(task));
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 10),
                          itemCount: tasks.length,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget desktopTaskView() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: .start,
          spacing: 20,
          children: [
            Expanded(child: todoTaskCard()),
            Expanded(child: inprogressTaskcard()),
            Expanded(child: completedTaskCard()),
          ],
        ),
      ),
    );
  }

  Widget todoTaskCard() {
    return Container(
      padding: .all(10),
      decoration: BoxDecoration(
        color: Colors.red.shade100,

        borderRadius: BorderRadius.circular(10),
      ),

      child: ListView(
        children: [
          Text(
            "Todo",
            style: TextStyle(color: Colors.red.shade900),
            textAlign: .center,
          ),
          SizedBox(height: 10),
          DragTarget<TasksDataModel>(
            onAccept: (data) async {
              final task = data.copyWith(type: TaskType.todo);
              await controller.updateTask(task);
              Get.snackbar(
                "Task Updated!",
                "Task moved back to todo",
                backgroundColor: Colors.deepPurple.shade400,
                colorText: Colors.white,
              );
              log("onAccept: $data");
            },

            builder: (context, candidateData, _) => Obx(() {
              final tasks = controller.todoList
                  .where((element) => element.type == TaskType.todo)
                  .toList();
              return SizedBox(
                height: 600,
                child: ListView.separated(
                  scrollDirection: .vertical,
                  itemBuilder: (context, index) {
                    final task = tasks.elementAt(index);
                    return Card(elevation: 4, child: taskCard(task));
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount: tasks.length,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget inprogressTaskcard() {
    return Container(
      padding: .all(10),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,

        borderRadius: BorderRadius.circular(10),
      ),

      child: ListView(
        children: [
          Text(
            "Inprogress",
            style: TextStyle(color: Colors.blue.shade900),
            textAlign: .center,
          ),
          SizedBox(height: 10),

          DragTarget<TasksDataModel>(
            onAccept: (data) async {
              final task = data.copyWith(type: TaskType.progress);
              await controller.updateTask(task);
              Get.snackbar(
                "Task Updated!",
                "Task moved to Inprogress",
                backgroundColor: Colors.deepPurple.shade400,
                colorText: Colors.white,
              );
              log("onAccept: $data");
            },

            builder: (context, candidateData, _) => Obx(() {
              final tasks = controller.todoList
                  .where((element) => element.type == TaskType.progress)
                  .toList();
              return SizedBox(
                height: 600,
                child: ListView.separated(
                  scrollDirection: .vertical,
                  itemBuilder: (context, index) {
                    final task = tasks.elementAt(index);
                    return Card(elevation: 4, child: taskCard(task));
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: tasks.length,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget completedTaskCard() {
    return Container(
      padding: .all(10),
      decoration: BoxDecoration(
        color: Colors.green.shade100,

        borderRadius: BorderRadius.circular(10),
      ),

      child: ListView(
        children: [
          Text(
            "Completed",
            style: TextStyle(color: Colors.green.shade900),
            textAlign: .center,
          ),
          SizedBox(height: 10),
          DragTarget<TasksDataModel>(
            onAccept: (data) async {
              log("onAccept: $data");

              final task = data.copyWith(type: TaskType.completed);
              await controller.updateTask(task);
              Get.snackbar(
                "Task Finished!",
                "Task moved to Completed",
                backgroundColor: Colors.deepPurple.shade400,
                colorText: Colors.white,
              );
              log("onAccept: $data");
            },

            builder: (context, candidateData, _) => Obx(() {
              final tasks = controller.todoList
                  .where((element) => element.type == TaskType.completed)
                  .toList();
              return SizedBox(
                height: 600,
                child: ListView.separated(
                  scrollDirection: .vertical,
                  itemBuilder: (context, index) {
                    final task = tasks.elementAt(index);
                    return Card(elevation: 4, child: taskCard(task));
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: tasks.length,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget testCard() {
    return Draggable(
      feedback: testCard2(),
      data: Colors.amber,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.orangeAccent,
        child: const Center(child: Text('box')),
      ),
    );
  }

  Widget testCard2() {
    return Material(
      child: Container(
        width: 150,
        height: 150,
        color: Colors.red,
        child: const Center(child: Text('box')),
      ),
    );
  }

  Widget taskCard(TasksDataModel task) {
    return Draggable<TasksDataModel>(
      data: task,
      feedback: Transform.rotate(angle: 0.1, child: taskCard2(task)),
      child: Material(
        borderRadius: .circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: .circular(20),
            color: Colors.white,
          ),
          width: 200,
          padding: .all(10),
          child: Column(
            spacing: 8,
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      task.title ?? '',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),

              Text(
                maxLines: 2,
                overflow: .ellipsis,
                task.description ?? '',
                style: TextStyle(fontSize: 14, fontWeight: .w400),
              ),
              SizedBox(height: 10),
              Divider(),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: .end,
                    children: [
                      Align(
                        widthFactor: 0.6,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundImage: AssetImage(
                            'assets/images/girl_avatar.png',
                          ),
                        ),
                      ),
                      Align(
                        widthFactor: 0.4,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundImage: AssetImage(
                            'assets/images/girl_avatar.png',
                          ),
                        ),
                      ),
                      Align(
                        widthFactor: 0.4,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundImage: AssetImage(
                            'assets/images/girl_avatar.png',
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    spacing: 4,
                    children: [
                      Icon(Icons.date_range),
                      Obx(() => Text(controller.date.value)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget taskCard2(TasksDataModel task) {
    return Material(
      borderRadius: .circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: .circular(20),
          color: Colors.white,
        ),
        width: 400,
        padding: .all(10),
        child: Column(
          spacing: 8,
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    task.title ?? '',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ],
            ),

            Text(
              maxLines: 2,
              overflow: .ellipsis,
              task.description ?? '',
              style: TextStyle(fontSize: 14, fontWeight: .w400),
            ),
            SizedBox(height: 10),
            Divider(),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: .end,
                  children: [
                    Align(
                      widthFactor: 0.6,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundImage: AssetImage(
                          'assets/images/girl_avatar.png',
                        ),
                      ),
                    ),
                    Align(
                      widthFactor: 0.4,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundImage: AssetImage(
                          'assets/images/girl_avatar.png',
                        ),
                      ),
                    ),
                    Align(
                      widthFactor: 0.4,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundImage: AssetImage(
                          'assets/images/girl_avatar.png',
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  spacing: 4,
                  children: [
                    Icon(Icons.date_range),
                    Obx(() => Text(controller.date.value)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget addTaskBottomSheet() {
    TextEditingController titleTxtController = TextEditingController();
    TextEditingController descriptionTxtController = TextEditingController();
    return Container(
      padding: .all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: .circular(20),
      ),
      child: Column(
        spacing: 10,
        crossAxisAlignment: .start,
        children: [
          Text("Projects:", style: TextStyle(fontSize: 20)),
          Obx(
            () => DropdownButtonFormField<ProjectDataModel>(
              hint: Text("Select project"),
              value: controller.selectedProject.value,
              items: controller.projectList.map((element) {
                return DropdownMenuItem<ProjectDataModel>(
                  value: element,
                  child: Text(element.title ?? ''),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedProject.value = value!;
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          Text("Title:", style: TextStyle(fontSize: 20)),
          TextFormField(
            controller: titleTxtController,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          Text("Description:", style: TextStyle(fontSize: 20)),
          TextFormField(
            controller: descriptionTxtController,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),

          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.deepPurple),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
                fixedSize: WidgetStatePropertyAll(Size(150, 10)),
              ),
              onPressed: () {
                final task = TasksDataModel(
                  title: titleTxtController.text,
                  description: descriptionTxtController.text,
                  type: TaskType.todo,
                );

                controller.addTask(task);
                Get.back();
              },
              child: Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }
}

final TaskController controller = Get.find();
