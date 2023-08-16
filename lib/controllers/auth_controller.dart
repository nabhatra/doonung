import 'dart:async';

import 'package:doonung/pages/home_screen.dart';
import 'package:doonung/pages/login_screen.dart';
import 'package:doonung/utils/mytheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  bool isLoging = false;
  User? get user => _user.value;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.authStateChanges());
    ever(_user, loginRedirect);
  }

  loginRedirect(User? user) {
    Timer(const Duration(seconds: 2), () {
      if (user == null) {
        Get.offAll(() => const LoginScreen());
      } else {
        Get.offAll(() => const HomeScreen());
      }
    });
  }

  void registerUser(email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      //define error
      getErrorSnackBar("Account Creating Failed", e);
    }
  }

  getErrorSnackBar(String message, _) {
    Get.snackbar(
      "Error",
      "$message\n%{_.message}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: MyTheme.redBorder,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.only(
        bottom: 10,
        left: 10,
        right: 10,
      ),
    );
  }
}
