import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:notebook/core/app_colors.dart';

import '../../pages/ultils/Uitilities.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final emailControllers = TextEditingController();
  final passwordControllers = TextEditingController();
  GlobalKey<FormState> formKeys = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Utils utils = Utils();

  RxBool toggle = true.obs;
  RxBool loading = false.obs;

  setToggle() {
    toggle.value = !toggle.value;
  }

  setLoading(bool value) {
    loading.value = value;
  }

  void login(BuildContext context) async {
    try {
      setLoading(true);
      await _auth
          .signInWithEmailAndPassword(
            email: emailControllers.text.trim(),
            password: passwordControllers.text.trim(),
          )
          .then((value) {
            if (!context.mounted) return;
            utils.toastMessage(message:'Login Successfully',color: greenColor);
            setLoading(false);
            context.go('/homePage');
          })
          .onError((error, stackTrace) {
            setLoading(false);
            utils.toastMessage(message:error.toString());
          });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        utils.toastMessage(message:'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        utils.toastMessage(message: 'Wrong password provided for that user.');
        setLoading(false);
      }
    } catch (e) {
      utils.toastMessage(message: e.toString());
      setLoading(false);
    }
  }
}
