import 'dart:async';
import 'dart:developer';

import 'package:again/firebase_service.dart';
import 'package:again/model/create_issue_model.dart';
import 'package:again/model/student_issue_model.dart';
import 'package:again/model/user_model.dart';
import 'package:get/get.dart';

class StudentIssueController extends GetxController {
  // final List<StudentIssue> allStudentIssue = [];

  // @override
  // void onInit() {
  //   super.onInit();
  //   // listenToStudentIssues();
  //   // listenToIDs();
  // }

  // void listenToStudentIssues() {
  //   FirebaseService().listenToStudentIssues().listen(
  //     (studentIssues) {
  //       allStudentIssue.clear();
  //       allStudentIssue.addAll(studentIssues);
  //       update();
  //     },
  //     onError: (error) {
  //       print("Error listening to student issues: $error");
  //     },
  //   );
  // }

  // void listenToIDs(String userId) async {
  //   List<Issue> data = await FirebaseService().getIssuesOnceWithID(userId);
  //   log(data.toString());
  //   allStudentIssue
  //       .where(
  //         (element) => element.userId == userId,
  //       )
  //       .first
  //       .allUserIssue = data;

  //   update();
  // }
}
