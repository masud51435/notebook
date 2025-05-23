import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notebook/core/app_colors.dart';

class Utils {
  void toastMessage({required String message, Color? color}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color ?? redColor,
      textColor:whiteColor,
      fontSize: 18.0,
    );
  }
}
