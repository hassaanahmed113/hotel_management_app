import 'package:again/firebase_service.dart';
import 'package:again/model/change_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeRoomController extends GetxController {
  TextEditingController reason = TextEditingController();

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

  void changeRoomUser(RoomChangeRequest request) async {
    await FirebaseService().changeRoomUser(request).then(
      (value) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Your request submitted'),
            backgroundColor: Colors.green,
          ),
        );
        Get.back();
        clearText();
      },
    );
  }

  void clearText() {
    reason.clear();

    update();
  }
}
