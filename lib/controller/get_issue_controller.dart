import 'dart:developer';

import 'package:again/firebase_service.dart';
import 'package:again/model/create_issue_model.dart';
import 'package:get/get.dart';

class GetIssueController extends GetxController {
  List<Issue> issueUser = [];

  void getIssueUser() async {
    issueUser.clear();
    issueUser = await FirebaseService().getIssuesOnce();
    update();
  }

  void startListening() {
    FirebaseService().listenToIssues().listen((issues) {
      issueUser = issues;
      update();
    }, onError: (error) {
      log("Error listening to issues: $error");
    });
  }
}
