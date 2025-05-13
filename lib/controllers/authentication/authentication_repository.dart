import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import '../../core/app_routes.dart';

class AuthenticationRepository {
  final deviceStorage = GetStorage();

  Future<void> screenRedirect(BuildContext context) async {
    final bool? isFirstTime = deviceStorage.read('isFirstTime');

    if (isFirstTime == null || isFirstTime == true) {
      // Show splash screen
      context.go(AppRoutes.splashScreen);
    } else {
      // Check if user is logged in
      isLogin(context);
    }
  }

  void isLogin(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      context.go(AppRoutes.homePage);
    } else {
      context.go(AppRoutes.login);
    }
  }
}
