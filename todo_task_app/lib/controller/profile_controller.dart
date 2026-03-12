import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class ProfileController extends GetxController {
  final RxBool isDark = false.obs;
  final username = ''.obs;
  final email = ''.obs;
  final userData = Rxn<User>();

  final FirebaseFirestore firebaseData = FirebaseFirestore.instance;
  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    userData.value = user;
  }

  void updateUserName(String newName) async {
    await FirebaseAuth.instance.currentUser?.updateDisplayName(newName);
    await FirebaseAuth.instance.currentUser?.reload();
    loadUserData();
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed("/login");
  }
}
