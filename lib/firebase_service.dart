import 'dart:async';
import 'dart:developer' as log;
import 'dart:math';

import 'package:again/View/Auth/Login/LoginScreen.dart';
import 'package:again/View/Dashboard/DashboardScreen.dart';
import 'package:again/controller/dashboard_controller.dart';
import 'package:again/model/change_request_model.dart';
import 'package:again/model/create_issue_model.dart';
import 'package:again/model/room_available_model.dart';
import 'package:again/model/staff_model.dart';
import 'package:again/model/student_issue_model.dart';
import 'package:again/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Get the current user
  User? get currentUser => _auth.currentUser;

  // addIssueUser
  Future<void> addIssueUser(Issue data) async {
    data = data.copyWith(docId: currentUser?.uid);
    try {
      await _firestore
          .collection("create_issue")
          .doc(currentUser?.uid)
          .collection('all')
          .add(data.toJson());
    } catch (e) {
      print('Error addIssueUser: $e');
    }
  }

  // addIssueUser
  Future<void> addStaff(Staff data) async {
    try {
      await _firestore.collection("staff").add(data.toJson());
    } catch (e) {
      print('Error staff: $e');
    }
  }

  // getIssueUser
  Future<List<Issue>> getIssuesOnce() async {
    try {
      final snapshot = await _firestore
          .collection("create_issue")
          .doc(currentUser?.uid)
          .collection('all')
          .get();

      final data =
          snapshot.docs.map((doc) => Issue.fromJson(doc.data())).toList();
      return data;
    } catch (e) {
      log.log("Error fetching issues: $e");
      return [];
    }
  }

  Stream<List<Issue>> listenToIssues() {
    return _firestore
        .collection("create_issue")
        .doc(currentUser?.uid)
        .collection('all')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Issue.fromJson(doc.data())).toList();
    });
  }

  // getIssueUser
  Future<List<Staff>> getStaff() async {
    try {
      final snapshot = await _firestore.collection("staff").get();

      final data =
          snapshot.docs.map((doc) => Staff.fromJson(doc.data())).toList();
      return data;
    } catch (e) {
      log.log("Error fetching staff: $e");
      return [];
    }
  }

  Stream<List<Staff>> listenToStaff() {
    return _firestore.collection("staff").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Staff.fromJson(doc.data())).toList();
    });
  }

  Future<void> deleteStaff(String staffId) async {
    try {
      final querySnapshot = await _firestore
          .collection("staff")
          .where('staff_id', isEqualTo: staffId)
          .get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      log.log("Error fetching staff: $e");
    }
  }

  // getIssueUser
  Future<List<Room>> getRoomOnce() async {
    try {
      final snapshot = await _firestore.collection("room_available").get();

      final data =
          snapshot.docs.map((doc) => Room.fromJson(doc.data())).toList();
      return data;
    } catch (e) {
      log.log("Error fetching issues: $e");
      return [];
    }
  }

  Stream<List<Room>> listenToRoom() {
    return _firestore.collection("room_available").snapshots().map((snapshot) {
      try {
        return snapshot.docs.map((doc) => Room.fromJson(doc.data())).toList();
      } catch (e) {
        log.log("Error parsing Room data: $e");
        return [];
      }
    });
  }

// getUser
  Future<UserProfile?> getUserOnce() async {
    try {
      final snapshot = await _firestore
          .collection("user_profile")
          .doc(currentUser?.uid)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data();

        if (data != null) {
          return UserProfile.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      log.log("Error fetching user profile: $e");
      return null;
    }
  }

  Stream<UserProfile?> listenToUser() {
    return _firestore
        .collection("user_profile")
        .doc(currentUser?.uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null) {
          return UserProfile.fromJson(data);
        }
      }
      return null;
    });
  }

  Future<void> updateUserProfile(
      {required UserProfile userProfile, String? userId}) async {
    try {
      final userProfileMap = userProfile.toJson();

      await _firestore
          .collection("user_profile")
          .doc(userId == null ? currentUser?.uid : userId)
          .update(userProfileMap);
    } catch (e, stackTrace) {
      log.log("Error updating user profile for userId:",
          error: e, stackTrace: stackTrace);
    }
  }

  // change room
  Future<void> changeRoomUser(RoomChangeRequest data) async {
    try {
      await _firestore
          .collection("changeroom_request")
          .doc(currentUser?.uid)
          .set(data.toJson());
    } catch (e) {
      print('Error addIssueUser: $e');
    }
  }

  Future<String?> getDocumentIdForIssue(
      String mainDocId, String issueId) async {
    log.log(mainDocId + " UPRR " + issueId);
    final snapshot = await FirebaseFirestore.instance
        .collection("create_issue")
        .doc(mainDocId)
        .collection("all")
        .where('issue_id', isEqualTo: issueId)
        .get();

    log.log(snapshot.docs.first.toString() + " SSSSSSSSSSSSS");

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.id;
    }

    return null;
  }

  Future<List<RoomChangeRequest>> getRoomRequestOnce() async {
    try {
      final snapshotUser = await _firestore
          .collection('user_profile')
          .where('isAdmin', isEqualTo: true)
          .get();
      log.log(snapshotUser.docs.first['user_id']);
      final snapshot = await _firestore
          .collection("changeroom_request")
          .where('user_id', isNotEqualTo: snapshotUser.docs.first['user_id'])
          .get();

      final data = snapshot.docs
          .map((doc) => RoomChangeRequest.fromJson(doc.data()))
          .toList();
      return data;
    } catch (e) {
      log.log("Error fetching issues: $e");
      return [];
    }
  }

  Stream<List<RoomChangeRequest>> listenToRoomRequest() async* {
    final snapshotUser = await _firestore
        .collection('user_profile')
        .where('isAdmin', isEqualTo: true)
        .get();
    log.log(snapshotUser.docs.first['user_id']);

    yield* _firestore
        .collection("changeroom_request")
        .where('user_id', isNotEqualTo: snapshotUser.docs.first['user_id'])
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => RoomChangeRequest.fromJson(doc.data()))
          .toList();
    });
  }

  Future<void> updateRoomRequest(
      RoomChangeRequest request, UserProfile user) async {
    try {
      final requestUpdate = request.toJson();

      await _firestore
          .collection("changeroom_request")
          .doc(request.userId)
          .update(requestUpdate);
      if (requestUpdate['status'] == 'Approved') {
        await _firestore
            .collection("user_profile")
            .doc(request.userId)
            .update(user.toJson());

        final snapshot = await _firestore
            .collection('room_available')
            .where('room_number', isEqualTo: request.chngRoomNumber)
            .where('block_number', isEqualTo: request.chngBlockNumber)
            .get();

        for (var element in snapshot.docs) {
          int occupied = element.data()['occupied'] ?? 0;
          await element.reference.update({
            'occupied': occupied + 1,
          });
        }
      }
    } catch (e, stackTrace) {
      log.log("Error updating request:", error: e, stackTrace: stackTrace);
    }
  }

  // getIssueUser
  Future<List<Map<String, dynamic>>> getStudentUserId() async {
    try {
      final snapshot = await _firestore.collection("create_issue").get();

      List<Map<String, dynamic>> issues = snapshot.docs.map((doc) {
        return {
          'user_id': doc.data()['user_id'],
        };
      }).toList();

      return issues;
    } catch (e) {
      log.log("Error fetching issues: $e");
      return [];
    }
  }

  Stream<List<StudentIssue>> listenToStudentIssues() {
    return _firestore
        .collection("create_issue")
        .snapshots()
        .asyncMap((snapshot) async {
      List<StudentIssue> studentIssues =
          await Future.wait(snapshot.docs.map((doc) async {
        String docId = doc.id;
        Map<String, dynamic> mainData = doc.data();

        String userId = mainData['user_id'] ?? '';
        UserProfile? userProfile =
            await FirebaseService().getUserForStudent(userId);

        List<Issue> userIssues = await _firestore
            .collection("create_issue")
            .doc(docId)
            .collection("all")
            .snapshots()
            .asyncMap((subSnapshot) {
          return subSnapshot.docs
              .map((subDoc) => Issue.fromJson(subDoc.data()))
              .toList();
        }).first;

        return StudentIssue(
          allUserIssue: userIssues,
          user: userProfile,
          userId: userId,
        );
      }).toList());
      return studentIssues;
    });
  }

  Future<UserProfile?> getUserForStudent(String userId) async {
    try {
      final snapshot =
          await _firestore.collection("user_profile").doc(userId).get();

      if (snapshot.exists) {
        final data = snapshot.data();

        if (data != null) {
          return UserProfile.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      log.log("Error fetching user profile: $e");
      return null;
    }
  }

  Stream<List<Issue>> getIssuesStreamWithID(String userId) {
    return _firestore
        .collection("create_issue")
        .doc(userId)
        .collection('all')
        .snapshots()
        .map((snapshot) {
      final data =
          snapshot.docs.map((doc) => Issue.fromJson(doc.data())).toList();
      return data;
    });
  }

  Future<void> updateIssueUser(
      Issue issue, String issueDocId, String allId) async {
    await _firestore
        .collection("create_issue")
        .doc(issueDocId)
        .collection('all')
        .doc(allId)
        .update(issue.toJson());
  }

  Future<void> updateUserID() async {
    try {
      await _firestore.collection("create_issue").doc(currentUser?.uid).set({
        'user_id': currentUser?.uid,
      });
    } catch (e) {
      print('Error addIssueUser: $e');
    }
  }

  Future<User?> signUpUser(String email, String pw) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pw,
      );
      final user = _auth.currentUser;

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        String errorCode = "Email already in use";

        var snackbar = SnackBar(
          content: Text(errorCode),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackbar);
      } else {
        String errorCode = "An error occurred during signup";
        var snackbar = SnackBar(
          content: Text(errorCode),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackbar);
      }
    }
    return null;
  }

  Future<void> addUser(
    UserProfile userdata,
  ) async {
    final datauser = FirebaseFirestore.instance.collection('user_profile');
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final user = auth.currentUser;
      userdata.charges = userdata.charges
          ?.copyWith(status: 'Pending', feeId: generateCustomString());
      if (user != null) {
        String code = "User signup successfully!!";
        var snackbar = SnackBar(
          content: Text(code),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackbar);
        await datauser.doc(user.uid).set(userdata.toJson());
        Navigator.pushReplacement(
          Get.context!,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      }
    } catch (e) {
      debugPrint('Error adding item: $e');
    }
  }

  String generateCustomString() {
    final currentYear = DateTime.now().year;
    final yearSuffix = (currentYear - 2000).toString().padLeft(2, '0');
    final random = Random();
    final randomNumber = (1000 + random.nextInt(9000)).toString();

    return "$yearSuffix-NTU-CS-$randomNumber";
  }

  void signInUser(String email, String pw) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: pw);
      String errorMessage = "login successfully!!";
      var snackbar = SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.green,
      );
      Navigator.pushReplacement(
        Get.context!,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackbar);
    } on FirebaseAuthException catch (e) {
      String errorMessage = "";
      if (e.code == 'invalid-credential') {
        errorMessage = "User not exist";
        var snackbar = SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackbar);
      } else {
        errorMessage = "Other exception";
        var snackbar = SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackbar);
      }
    }
  }

  Future forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      String errorMessage =
          "We have sent you email to recover password. please check email";
      var snackbar = SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.green,
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackbar);
    } on FirebaseAuthException catch (err) {
      throw Exception(err.message.toString());
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<List<UserProfile>> getHotelfeeOnce() async {
    try {
      final snapshotUser = await _firestore
          .collection('user_profile')
          .where('isAdmin', isEqualTo: true)
          .get();
      log.log(snapshotUser.docs.first['user_id']);
      final snapshot = await _firestore
          .collection('user_profile')
          .where('user_id', isNotEqualTo: snapshotUser.docs.first['user_id'])
          .get();

      final data =
          snapshot.docs.map((doc) => UserProfile.fromJson(doc.data())).toList();
      return data;
    } catch (e) {
      log.log("Error fetching user: $e");
      return [];
    }
  }

  Stream<List<UserProfile>> listenToHotelfee() async* {
    final snapshotUser = await _firestore
        .collection('user_profile')
        .where('isAdmin', isEqualTo: true)
        .get();
    log.log(snapshotUser.docs.first['user_id']);

    yield* _firestore
        .collection('user_profile')
        .where('user_id', isNotEqualTo: snapshotUser.docs.first['user_id'])
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => UserProfile.fromJson(doc.data()))
          .toList();
    });
  }

  // // Update a document
  // Future<void> updateDocument(
  //     String collectionPath, String docId, Map<String, dynamic> data) async {
  //   try {
  //     await _firestore.collection(collectionPath).doc(docId).update(data);
  //   } catch (e) {
  //     print('Error updating document: $e');
  //   }
  // }

  // // Delete a document
  // Future<void> deleteDocument(String collectionPath, String docId) async {
  //   try {
  //     await _firestore.collection(collectionPath).doc(docId).delete();
  //   } catch (e) {
  //     print('Error deleting document: $e');
  //   }
  // }

  // // Authenticate user
  // Future<User?> signIn(String email, String password) async {
  //   try {
  //     final credential = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     return credential.user;
  //   } catch (e) {
  //     print('Error signing in: $e');
  //     return null;
  //   }
  // }

  // Future<void> signOut() async {
  //   await _auth.signOut();
  // }
}
