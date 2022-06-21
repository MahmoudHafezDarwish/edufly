import 'package:edufly/utile/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastMessage {
  static void showToast(String message, bool status) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: status ? kPrimaryColor : Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
