import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_task_app/bindings/home_binding.dart';
import 'package:todo_task_app/controller/task_controller.dart';
import 'package:todo_task_app/firebase_options.dart';
import 'package:todo_task_app/route_names/route_name.dart';
import 'package:todo_task_app/routes/routes.dart';
import 'package:todo_task_app/views/home_screen.dart';
import 'package:todo_task_app/views/login_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      // darkTheme: ThemeData(cardColor: Colors.black),
      theme: ThemeData(
        fontFamily: "Poppins",
        cardColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            fixedSize: WidgetStatePropertyAll(Size(500, 40)),
            backgroundColor: WidgetStatePropertyAll(Colors.transparent),
            shadowColor: WidgetStatePropertyAll(Colors.transparent),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: .circular(12)),
            ),
          ),
        ),
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      initialBinding: HomeBinding(),
      initialRoute: RouteName.KSplash,
      getPages: getPages,
    );
  }
}
