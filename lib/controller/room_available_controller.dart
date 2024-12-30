import 'dart:developer';

import 'package:again/firebase_service.dart';
import 'package:again/model/room_available_model.dart';
import 'package:get/get.dart';

class RoomAvailableController extends GetxController {
  List<Room> roomList = [];

  void getRoomList() async {
    roomList.clear();
    roomList = await FirebaseService().getRoomOnce();
    roomList.removeWhere(
      (element) => (element.occupied) == (element.maxRoom),
    );
    update();
  }

  void startListening() {
    FirebaseService().listenToRoom().listen((rooms) {
      roomList = rooms;
      roomList.removeWhere(
        (element) => (element.occupied) == (element.maxRoom),
      );

      update();
    }, onError: (error) {
      log("Error listening to rooms: $error");
    });
  }
}
