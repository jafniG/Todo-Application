import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:todo_task_app/route_names/route_name.dart';
import 'package:todo_task_app/views/home_screen.dart';
import 'package:todo_task_app/views/login_screen.dart';
import 'package:todo_task_app/views/splash_screen.dart';

List<GetPage<dynamic>> getPages = [
  (GetPage(name: RouteName.kSplash, page: () => SplashScreen())),
  (GetPage(name: RouteName.kHome, page: () => HomeScreen())),
  (GetPage(name: RouteName.kLogin, page: () => LoginScreen())),
];
