import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:todo_task_app/controller/task_controller.dart';
import 'package:todo_task_app/views/profile_screen.dart';
import 'package:todo_task_app/views/project_dashboard.dart';
import 'package:todo_task_app/views/task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => buildView()),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.current_index.value,
          onTap: (value) {
            controller.selectedPage(value);
          },
          selectedItemColor: Colors.deepPurple,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.checklist), label: "Tasks"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }

  Widget buildView() {
    switch (controller.current_index.value) {
      case 0:
        return ProjectDashboard();
      case 1:
        return TaskScreen();
      case 2:
        return ProfileScreen();
      default:
        return SizedBox();
    }
  }
}
