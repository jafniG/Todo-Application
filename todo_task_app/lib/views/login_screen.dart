import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:todo_task_app/controller/authentication_controller.dart';
import 'package:todo_task_app/controller/login_controller.dart';
import 'package:todo_task_app/controller/task_controller.dart';
import 'package:todo_task_app/views/home_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthenticationController authcontroller = Get.find();
  final LoginController loginController = Get.find();

  late TextEditingController emailTxtController;

  late TextEditingController passwordTxtController;
  @override
  void initState() {
    emailTxtController = TextEditingController();
    passwordTxtController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
            return desktopLoginPage();
          }
          if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
            return mobileLoginPage();
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

  Widget mobileLoginPage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: .topCenter,
          end: .bottomCenter,

          colors: [const Color.fromARGB(255, 17, 4, 57), Colors.deepPurple],
        ),
      ),
      child: ListView(
        children: [
          SizedBox(height: 100),
          Image.asset(height: 200, width: 250, "assets/images/task_img.png"),
          Container(
            margin: .symmetric(horizontal: 20),
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),

            child: Column(
              mainAxisAlignment: .center,
              children: [
                Obx(
                  () => Text(
                    loginController.isLogin.value ? "Welcome Back!" : "SignUp",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.deepPurple.shade800,
                      fontWeight: .bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Enter your email and password to access your account",
                  textAlign: .center,
                ),

                SizedBox(height: 25),
                Form(
                  key: widget.loginFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (!GetUtils.isEmail(value!)) {
                            return "Email is not valid";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailTxtController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: .circular(12),
                          ),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(
                        () => TextFormField(
                          validator: (value) {
                            final RegExp passwordRegex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                            );
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            } else if (!passwordRegex.hasMatch(value)) {
                              return 'Password must contain at least 8 characters, one uppercase, one lowercase, one number, and one special character.';
                            }
                            return null;
                          },
                          controller: passwordTxtController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: loginController.isHidden.value,
                          decoration: InputDecoration(
                            hintText: "Password",

                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                loginController.passwordVisibility();
                              },
                              icon: Icon(
                                loginController.isHidden.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: .circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      borderRadius: .circular(12),
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 17, 4, 57),
                          Colors.deepPurple,
                        ],
                      ),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size(500, 40)),
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                        shadowColor: WidgetStatePropertyAll(Colors.transparent),
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(borderRadius: .circular(12)),
                        ),
                      ),
                      onPressed: () async {
                        final isValid =
                            widget.loginFormKey.currentState?.validate() ??
                            false;
                        final isLogin = loginController.isLogin.value;
                        if (isValid) {
                          if (isLogin) {
                            final result = await authcontroller.signinAccount(
                              emailTxtController.text,
                              passwordTxtController.text,
                            );
                            if (!result) {
                              return;
                            }

                            Get.to(() => HomeScreen());
                          } else {
                            final result = await authcontroller.createAccount(
                              emailTxtController.text,
                              passwordTxtController.text,
                            );

                            if (!result) {
                              return;
                            }
                            Get.to(() => HomeScreen());
                          }
                        } else {
                          return;
                        }
                      },
                      child: Text(
                        loginController.isLogin.value ? "SignIn" : "SignUp",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Obx(
                  () => RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      text: loginController.isLogin.value
                          ? "Don't have an account? "
                          : "Already have an account? ",
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = loginController.loginState,
                          style: TextStyle(
                            color: Colors.deepPurple.shade800,
                            fontSize: 15,
                          ),
                          text: loginController.isLogin.value
                              ? " SignUp"
                              : "SignIn",
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget desktopLoginPage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: .topCenter,
          end: .bottomRight,
          colors: [Colors.black, Colors.deepPurple],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 50),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 200),
                Text(
                  "Organize your\nTask Effortlessly",

                  textAlign: .left,
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: .w700,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: Text(
                    "Signup now and start managing your tasks ease!\nFrom daily tasks to team projects, Todo keeps everything organized \nso you focused on what matters most.",
                    style: TextStyle(color: Colors.white.withOpacity(0.8)),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                margin: .all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 550,
                width: 500,

                child: Column(
                  spacing: 10,
                  mainAxisAlignment: .center,
                  children: [
                    Image.asset(
                      height: 150,
                      width: 250,
                      "assets/images/task_img.png",
                    ),
                    Obx(
                      () => Text(
                        loginController.isLogin.value
                            ? "Welcome Back!"
                            : "SignUp",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.deepPurple.shade900,
                          fontWeight: .bold,
                          fontFamily: "Lato",
                        ),
                      ),
                    ),
                    Text(
                      "Enter your email and password to access your account",
                      textAlign: .center,
                    ),

                    SizedBox(height: 10),
                    Form(
                      key: widget.loginFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (!GetUtils.isEmail(value!)) {
                                return "Email is not valid";
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: emailTxtController,
                            decoration: InputDecoration(
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: .circular(12),
                              ),
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                          SizedBox(height: 20),
                          Obx(
                            () => TextFormField(
                              validator: (value) {
                                final RegExp passwordRegex = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                                );
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                } else if (!passwordRegex.hasMatch(value)) {
                                  return 'Password must contain at least 8 characters, one uppercase, one lowercase, one number, and one special character.';
                                }
                                return null;
                              },
                              controller: passwordTxtController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: loginController.isHidden.value,
                              decoration: InputDecoration(
                                hintText: "Password",

                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    loginController.passwordVisibility();
                                  },
                                  icon: Icon(
                                    loginController.isHidden.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: .circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),

                    Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          borderRadius: .circular(12),
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 17, 4, 57),
                              Colors.deepPurple,
                            ],
                          ),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            fixedSize: WidgetStatePropertyAll(Size(500, 40)),
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.transparent,
                            ),
                            shadowColor: WidgetStatePropertyAll(
                              Colors.transparent,
                            ),
                            foregroundColor: WidgetStatePropertyAll(
                              Colors.white,
                            ),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: .circular(12),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            final isValid =
                                widget.loginFormKey.currentState?.validate() ??
                                false;
                            final isLogin = loginController.isLogin.value;
                            if (isValid) {
                              if (isLogin) {
                                final result = await authcontroller
                                    .signinAccount(
                                      emailTxtController.text,
                                      passwordTxtController.text,
                                    );
                                if (!result) {
                                  return;
                                }

                                Get.to(() => HomeScreen());
                              } else {
                                final result = await authcontroller
                                    .createAccount(
                                      emailTxtController.text,
                                      passwordTxtController.text,
                                    );

                                if (!result) {
                                  return;
                                }
                                Get.to(() => HomeScreen());
                              }
                            } else {
                              return;
                            }
                          },
                          child: Text(
                            loginController.isLogin.value ? "SignIn" : "SignUp",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Obx(
                      () => RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          text: loginController.isLogin.value
                              ? "Don't have an account? "
                              : "Already have an account? ",
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = loginController.loginState,
                              style: TextStyle(
                                color: Colors.deepPurple.shade800,
                                fontSize: 15,
                              ),
                              text: loginController.isLogin.value
                                  ? " SignUp"
                                  : "SignIn",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
