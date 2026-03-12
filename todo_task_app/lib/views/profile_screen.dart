import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:todo_task_app/controller/profile_controller.dart';
import 'package:todo_task_app/views/login_screen.dart';
import 'package:todo_task_app/views/task_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
            return desktopProfileView(context);
          }
          if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
            return mobileProfileView(context);
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

  Widget mobileProfileView(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: .topLeft,
              end: .bottomRight,
              colors: [Colors.black, Colors.deepPurple],
            ),
          ),
        ),
        Positioned(
          left: 160,
          top: 40,
          child: Text(
            "PROFILE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: .bold,
            ),
          ),
        ),

        Positioned(
          left: 14,
          right: 14,
          top: 200,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: .circular(20),
            ),
            height: Get.height / 2,
          ),
        ),
        Positioned(
          top: 150,
          left: 150,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              'https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg',
            ),
          ),
        ),
        Positioned(
          top: 260,
          left: 140,
          child: Obx(
            () => Column(
              children: [
                Text(
                  profileController.userData.value?.displayName ?? 'User',
                  style: TextStyle(fontSize: 20, fontWeight: .w500),
                ),
                Text(
                  profileController.userData.value?.email ?? 'user@gmail.com',
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 350,
          left: 40,
          right: 40,
          child: Column(
            children: [
              Card(
                color: Colors.white,
                child: ListTile(
                  onTap: () {
                    TextEditingController nameTxtController =
                        TextEditingController(
                          text: profileController.username.value,
                        );
                    Get.defaultDialog(
                      titlePadding: .only(top: 20),
                      contentPadding: .all(20),
                      title: "Edit Username",
                      content: TextField(
                        controller: nameTxtController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "New Username",
                        ),
                      ),
                      textConfirm: "Save",
                      buttonColor: Colors.deepPurple,

                      onConfirm: () {
                        profileController.updateUserName(
                          nameTxtController.text,
                        );
                        Get.back();
                      },
                    );
                  },
                  leading: Icon(Icons.edit),
                  title: Text("Edit Username"),
                ),
              ),
              Card(
                color: Theme.of(context).cardColor,
                child: Obx(
                  () => SwitchListTile(
                    secondary: Icon(Icons.dark_mode),
                    title: Text("Dark Mode"),
                    value: profileController.isDark.value,
                    onChanged: (value) {
                      profileController.isDark.value = value;
                      if (value) {
                        Get.changeTheme(ThemeData.dark());
                      } else {
                        Get.changeTheme(ThemeData.light());
                      }
                    },
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                  onTap: () {
                    Get.defaultDialog(
                      contentPadding: .all(10),
                      titlePadding: .only(top: 20),
                      buttonColor: Colors.deepPurple,
                      title: "Logout",
                      middleText: "Are you sure you want to logout?",
                      textConfirm: "Yes",
                      textCancel: "No",
                      onConfirm: () {
                        profileController.logOut();
                        Get.to(LoginScreen());
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget desktopProfileView(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: .topLeft,
              end: .bottomRight,
              colors: [Colors.black, Colors.deepPurple],
            ),
          ),
        ),
        Positioned(
          left: 600,
          top: 40,
          child: Text(
            "PROFILE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: .bold,
            ),
          ),
        ),

        Positioned(
          left: 14,
          right: 14,
          top: 120,
          child: Container(
            margin: .symmetric(horizontal: 300),
            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: .circular(20),
            ),
            height: Get.height / 1.8,
          ),
        ),
        Positioned(
          top: 140,
          left: 350,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/girl_avatar.png'),
          ),
        ),
        Positioned(
          top: 170,
          left: 480,
          child: Obx(
            () => Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  profileController.userData.value?.displayName ?? 'User',
                  style: TextStyle(fontSize: 20, fontWeight: .w500),
                ),
                Text(
                  profileController.userData.value?.email ?? 'user@gmail.com',
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 260,
          left: 350,
          right: 350,
          child: Column(
            children: [
              Card(
                color: Colors.white,
                child: ListTile(
                  onTap: () {
                    TextEditingController nameTxtController =
                        TextEditingController(
                          text: profileController.username.value,
                        );
                    Get.defaultDialog(
                      titlePadding: .only(top: 20),
                      contentPadding: .all(20),
                      title: "Edit Username",
                      content: TextField(
                        controller: nameTxtController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "New Username",
                        ),
                      ),
                      textConfirm: "Save",
                      buttonColor: Colors.deepPurple,

                      onConfirm: () {
                        profileController.updateUserName(
                          nameTxtController.text,
                        );
                        Get.back();
                      },
                    );
                  },
                  leading: Icon(Icons.edit),
                  title: Text("Edit Username"),
                ),
              ),
              Card(
                color: Theme.of(context).cardColor,
                child: Obx(
                  () => SwitchListTile(
                    secondary: Icon(Icons.dark_mode),
                    title: Text("Dark Mode"),
                    value: profileController.isDark.value,
                    onChanged: (value) {
                      profileController.isDark.value = value;
                      if (value) {
                        Get.changeTheme(ThemeData.dark());
                      } else {
                        Get.changeTheme(ThemeData.light());
                      }
                    },
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                  onTap: () {
                    Get.defaultDialog(
                      contentPadding: .all(10),
                      titlePadding: .only(top: 20),
                      buttonColor: Colors.deepPurple,
                      title: "Logout",
                      middleText: "Are you sure you want to logout?",
                      textConfirm: "Yes",
                      textCancel: "No",
                      onConfirm: () {
                        profileController.logOut();
                        Get.to(LoginScreen());
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
