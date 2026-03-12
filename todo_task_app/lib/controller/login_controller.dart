import 'package:get/state_manager.dart';

class LoginController extends GetxController{
  final isHidden = true.obs;
  final isLogin = true.obs;
  void passwordVisibility() {
    isHidden.value = !isHidden.value;
  }

  void loginState() {
    isLogin.value = !isLogin.value;
  }
}