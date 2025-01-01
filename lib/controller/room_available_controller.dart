import 'dart:developer';

import 'package:again/firebase_service.dart';
import 'package:again/model/room_available_model.dart';
import 'package:get/get.dart';

class RoomAvailableController extends GetxController {
  List<Room> roomList = [];
  List<Room> totalRoomList = [];

  int totalRoom = 0;

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

  void geTotalRooms() async {
    totalRoom = 0;
    totalRoomList = await FirebaseService().getRoomOnce();

    totalRoomList.map(
      (element) {
        totalRoom += element.maxRoom ?? 0;
      },
    ).toList();
    update();
  }
}
