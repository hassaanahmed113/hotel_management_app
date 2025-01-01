import 'dart:developer';

import 'package:again/firebase_service.dart';
import 'package:again/model/staff_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class StaffController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController role = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController pw = TextEditingController();

  List<Staff> staffList = [];
  List<Staff> staffListTemp = [];
  String searchVal = '';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    clearText();
    startListening();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getStaff();
    clearText();
  }

  void tempSearchList() {
    staffListTemp.clear();
    log(searchVal);

    staffListTemp.addAll(
      staffList.where(
        (element) {
          String name = '${element.firstName} ${element.lastName}';
          return name.contains(searchVal);
        },
      ),
    );

    update();
  }

  void createStaff() async {
    var uuid = Uuid();
    String uniqueId = uuid.v4();
    Staff data = Staff(
      email: email.text,
      firstName: firstName.text,
      lastName: lastName.text,
      phone: phoneNumber.text,
      pass: pw.text,
      role: role.text,
      staffId: uniqueId,
      username: username.text,
    );

    await FirebaseService().addStaff(data).then(
      (value) async {
        await FirebaseService().updateUserID();
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Staff added'),
            backgroundColor: Colors.green,
          ),
        );
        Get.back();
      },
    );
  }

  void getStaff() async {
    staffList.clear();
    staffList = await FirebaseService().getStaff();
    update();
  }

  void startListening() {
    FirebaseService().listenToStaff().listen((staff) {
      staffList = staff;
      update();
    }, onError: (error) {
      log("Error listening to stafff: $error");
    });
  }

  void deleteStaff(String staffId) async {
    await FirebaseService().deleteStaff(staffId);
  }

  void clearText() {
    username.clear();
    firstName.clear();
    lastName.clear();
    email.clear();
    phoneNumber.clear();
    pw.clear();
    role.clear();
    update();
  }
}
