import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Style {
  static basicToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor: toast == toast ? Colors.green : Colors.red,
        textColor: Colors.white);
  }

  static errorToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor: toast == toast ? Colors.red : Colors.red,
        textColor: Colors.white);
  }
}
