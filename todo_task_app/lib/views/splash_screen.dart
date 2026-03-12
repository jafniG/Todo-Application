import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:todo_task_app/storage/user_preference.dart';
import 'package:todo_task_app/views/home_screen.dart';
import 'package:todo_task_app/views/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserPreference.checkExistingUser().then((value) {
        if (value) {
          Get.to(HomeScreen());
          return;
        }
        Get.to(LoginScreen());
      }),
      builder: (context, asyncSnapshot) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: .topCenter,
                end: .bottomCenter,

                colors: [
                  const Color.fromARGB(255, 17, 4, 57),
                  Colors.deepPurple,
                ],
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  Icon(Icons.task_outlined,color: Colors.white,),
                  Text(
                    "Todo Application",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: .bold,
                      fontStyle: .italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
