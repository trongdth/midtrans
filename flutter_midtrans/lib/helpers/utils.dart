import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static final Utils _singleton = new Utils._internal();

  factory Utils() {
    return _singleton;
  }

  Utils._internal();

  // only use this if reuse image for both dark & light theme
  // otherwise using getSvgPicture in Themes class
  static getSvgPicture(String name) => SvgPicture.asset('assets/$name.svg');

  static bool isValidEmail(String email) {
    String p = r"^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(email);
  }

  bool isEmptyString(String str) {
    return str == null || str.isEmpty;
  }

  toast(dynamic str) {
    Fluttertoast.showToast(
        msg: str,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0);
  }
}

final utils = new Utils();
