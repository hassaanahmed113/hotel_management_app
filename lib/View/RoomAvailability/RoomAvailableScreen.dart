import 'package:again/View/ChangeRoom/ChangeroomScreen.dart';
import 'package:again/controller/room_available_controller.dart';
import 'package:again/model/room_available_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RoomAvailabilitiesScreen extends StatefulWidget {
  const RoomAvailabilitiesScreen({Key? key}) : super(key: key);

  @override
  State<RoomAvailabilitiesScreen> createState() =>
      _RoomAvailabilitiesScreenState();
}

class _RoomAvailabilitiesScreenState extends State<RoomAvailabilitiesScreen> {
  final getRoomController = Get.put(RoomAvailableController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRoomController.getRoomList();
    getRoomController.startListening();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomAvailableController>(
        init: getRoomController,
        builder: (controller) {
          return Scaffold(
            // backgroundColor: const Color(0xFFF5F5F5),
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xff5e35b1),
              title: Text(
                'Room Availabilities',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              itemCount: controller.roomList.length,
              itemBuilder: (context, index) {
                Room room = controller.roomList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeRoomScreen(
                                  selectedBlock: room.blockNumber,
                                  selectedRoom: room.roomNumber,
                                )));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff5e35b1).withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xff5e35b1).withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Room ${room.roomNumber}',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff5e35b1),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xff5e35b1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Available',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xff5e35b1).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.hotel_outlined,
                                  color: Color(0xff5e35b1),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RoomInfoRow(
                                      icon: Icons.location_on_outlined,
                                      text: room.blockNumber ?? '',
                                    ),
                                    const SizedBox(height: 8),
                                    RoomInfoRow(
                                      icon: Icons.people_outline,
                                      text:
                                          "${room.occupied}/${room.maxRoom} Occupied",
                                    ),
                                    const SizedBox(height: 8),
                                    RoomInfoRow(
                                      icon: Icons.star_outline,
                                      text: room.roomType ?? '',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}

class RoomInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const RoomInfoRow({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: const Color(0xff5e35b1),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
