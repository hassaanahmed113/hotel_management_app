import 'package:again/firebase_service.dart';
import 'package:again/model/create_issue_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CreateIssueController extends GetxController {
  TextEditingController blockNumber = TextEditingController();
  TextEditingController comment = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController roomNumber = TextEditingController();
  String? issueType;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    clearText();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    clearText();
  }

  void createIssueUser() async {
    var uuid = Uuid();
    String uniqueId = uuid.v4();
    DateTime currentDateTime = DateTime.now();

    Timestamp timestamp = Timestamp.fromDate(currentDateTime);
    Issue data = Issue(
      blockNumber: blockNumber.text,
      comment: comment.text,
      email: email.text,
      issueId: uniqueId,
      issueStatus: "Pending",
      phoneNumber: phoneNumber.text,
      roomNumber: int.parse(roomNumber.text),
      issueType: issueType,
      date: timestamp,
      lastUpdated: timestamp,
      userId: 'ZMv9SCzJawg684iC8tXi',
    );

    await FirebaseService().addIssueUser(data).then(
      (value) async {
        await FirebaseService().updateUserID();
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Your issue submitted'),
            backgroundColor: Colors.green,
          ),
        );
        Get.back();
      },
    );
  }

  void clearText() {
    blockNumber.clear();
    comment.clear();
    email.clear();
    phoneNumber.clear();
    roomNumber.clear();
    issueType = '';
    update();
  }
}
