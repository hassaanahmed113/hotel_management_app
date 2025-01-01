import 'dart:developer';

import 'package:again/firebase_service.dart';
import 'package:again/model/create_issue_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentIssueController extends GetxController {
  void updateStudenIssue(Issue issue, String issueDocId, String allId) async {
    log(issueDocId.toString() + " ssdsds " + allId.toString());
    await FirebaseService().updateIssueUser(issue, issueDocId, allId).then(
      (value) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Issue Updated'),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }
}
