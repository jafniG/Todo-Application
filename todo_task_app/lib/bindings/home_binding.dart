import 'package:get/get.dart';
import 'package:todo_task_app/controller/authentication_controller.dart';
import 'package:todo_task_app/controller/login_controller.dart';
import 'package:todo_task_app/controller/profile_controller.dart';
import 'package:todo_task_app/controller/project_controller.dart';
import 'package:todo_task_app/controller/task_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => TaskController());
    Get.lazyPut(() => AuthenticationController());
    Get.lazyPut(() => ProjectController());
    Get.lazyPut(() => ProfileController());
  }
}
