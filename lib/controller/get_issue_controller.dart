import 'dart:developer';

import 'package:again/firebase_service.dart';
import 'package:again/model/create_issue_model.dart';
import 'package:again/model/student_issue_model.dart';
import 'package:get/get.dart';

class GetIssueController extends GetxController {
  List<Issue> issueUser = [];
  List<Issue> totalIssues = [];
  void getIssueUser() async {
    issueUser.clear();
    issueUser = await FirebaseService().getIssuesOnce();
    update();
  }

  void getTotalIssue() async {
    totalIssues.clear();
    try {
      await for (var event in FirebaseService().listenToStudentIssues()) {
        event.forEach((e) {
          log(e.toString());
          totalIssues.addAll(e.allUserIssue ?? []);
        });
        update();
      }
    } catch (error) {
      log("Error fetching student issues: $error");
    }
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
