import 'dart:async';

import 'package:again/View/Auth/Login/LoginScreen.dart';
import 'package:flutter/material.dart';

class Splashservices {
  void isLogin(BuildContext context) {
    bool isLogin = true;
    if (isLogin) {
      Timer(const Duration(milliseconds: 3000), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }
  }
}
