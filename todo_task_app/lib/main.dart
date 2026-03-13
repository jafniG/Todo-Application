import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_task_app/Theme/app_theme.dart';
import 'package:todo_task_app/bindings/home_binding.dart';
import 'package:todo_task_app/controller/providers/theme_provider.dart';
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
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      // darkTheme: ThemeData(cardColor: Colors.black),
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: themeProvider.themeMode,
      initialBinding: HomeBinding(),
      initialRoute: RouteName.kSplash,
      getPages: getPages,
    );
  }
}
