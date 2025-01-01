import 'dart:developer';

import 'package:again/firebase_service.dart';
import 'package:again/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  UserProfile? userProfile = UserProfile();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController degree = TextEditingController();

  void getUser() async {
    userProfile = await FirebaseService().getUserOnce();
    update();
  }

  void updateUser() async {
    if (firstName.text == userProfile?.firstName &&
        lastName.text == userProfile?.lastName &&
        degree.text == userProfile?.degree) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Your name and degree is already saved'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      userProfile = userProfile?.copyWith(
        firstName:
            firstName.text.isNotEmpty ? firstName.text : userProfile?.firstName,
        lastName:
            lastName.text.isNotEmpty ? lastName.text : userProfile?.lastName,
        degree: degree.text.isNotEmpty ? degree.text : userProfile?.degree,
      );
      update();
      await FirebaseService().updateUserProfile(userProfile: userProfile!).then(
        (value) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text('Sucessfully saved your profile'),
              backgroundColor: Colors.green,
            ),
          );
        },
      );
    }
  }

  void startListening() {
    FirebaseService().listenToUser().listen((user) {
      userProfile = user;
      update();
    }, onError: (error) {
      log("Error listening to user: $error");
    });
  }
}
