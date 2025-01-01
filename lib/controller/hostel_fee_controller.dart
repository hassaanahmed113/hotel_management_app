import 'dart:developer';

import 'package:again/firebase_service.dart';
import 'package:again/model/change_request_model.dart';
import 'package:again/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostelFeeController extends GetxController {
  List<UserProfile> allUserFees = [];
  List<UserProfile> allUserFeesTemp = [];

  String searchVal = '';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHostelFee();
    startListening();
  }

  void tempSearchList() {
    allUserFeesTemp.clear();
    log(searchVal);

    allUserFeesTemp.addAll(
      allUserFees.where(
        (element) {
          String name = '${element.firstName} ${element.lastName}';
          return name.contains(searchVal);
        },
      ),
    );

    update();
  }

  void getHostelFee() async {
    allUserFees.clear();
    allUserFees = await FirebaseService().getHotelfeeOnce();

    update();
  }

  void startListening() {
    FirebaseService().listenToHotelfee().listen((hostel) {
      allUserFees = hostel;

      update();
    }, onError: (error) {
      log("Error listening to userr: $error");
    });
  }

  void updateUserProfile(UserProfile user) async {
    DateTime currentDateTime = DateTime.now();

    Timestamp timestamp = Timestamp.fromDate(currentDateTime);
    user.charges = user.charges?.copyWith(status: 'Paid', lastPaid: timestamp);
    await FirebaseService()
        .updateUserProfile(userProfile: user, userId: user.userId)
        .then(
      (value) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Updated Sucessfully'),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }
}
