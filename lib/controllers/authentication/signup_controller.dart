import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../pages/ultils/Uitilities.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool toggle = true.obs;
  RxBool loading = false.obs;

  setToggle() {
    toggle.value = !toggle.value;
  }

  setLoading(bool value) {
    loading.value = value;
  }

  void signUp(BuildContext context) async {
    try {
      setLoading(true);
      await _auth
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
          .then((value) {
            if (!context.mounted) return;
            Utils().toastMessage('SignUp Successfully');
            setLoading(false);
            context.go('/homePage');
          })
          .onError((error, stackTrace) {
            setLoading(false);
            Utils().toastMessage(error.toString());
          });
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      if (e.code == 'weak-password') {
        Utils().toastMessage('password should be atleast 6 character');
      } else if (e.code == 'email-already-in-use') {
        Utils().toastMessage(
          'The account already exists for that email,please login now',
        );
        setLoading(false);
        context.go('/login');
      }
    } catch (e) {
      print(e);
      Utils().toastMessage(e.toString());
      setLoading(false);
    }
  }
}
