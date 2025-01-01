import 'dart:developer';

import 'package:again/firebase_service.dart';
import 'package:again/model/change_request_model.dart';
import 'package:again/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminRequestController extends GetxController {
  List<RoomChangeRequest> allRoomRequest = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAdminRoomRequest();
    startListening();
  }

  void getAdminRoomRequest() async {
    allRoomRequest.clear();
    allRoomRequest = await FirebaseService().getRoomRequestOnce();
    allRoomRequest.removeWhere(
      (element) => element.status != 'Pending',
    );
    update();
  }

  void startListening() {
    FirebaseService().listenToRoomRequest().listen((allRequest) {
      allRoomRequest = allRequest;
      allRoomRequest.removeWhere(
        (element) => element.status != 'Pending',
      );

      update();
    }, onError: (error) {
      log("Error listening to request: $error");
    });
  }

  void updateUserRequest(
      RoomChangeRequest request, String status, UserProfile user) async {
    request = request.copyWith(status: status);
    update();
    await FirebaseService().updateRoomRequest(request, user).then(
      (value) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Request Updated Sucessfully'),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }
}
