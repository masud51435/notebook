import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../core/app_colors.dart';
import '../../pages/ultils/Uitilities.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
            utils.toastMessage(
              message: 'SignUp Successfully',
              color: greenColor,
            );
            setLoading(false);
            context.go('/homePage');
          })
          .onError((error, stackTrace) {
            setLoading(false);
            utils.toastMessage(message: error.toString());
          });
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      if (e.code == 'weak-password') {
        utils.toastMessage(message: 'password should be atleast 6 character');
      } else if (e.code == 'email-already-in-use') {
        utils.toastMessage(
          message: 'The account already exists for that email,please login now',
        );
        setLoading(false);
        context.go('/login');
      }
    } catch (e) {
      print(e);
      utils.toastMessage(message: e.toString());
      setLoading(false);
    }
  }
}
