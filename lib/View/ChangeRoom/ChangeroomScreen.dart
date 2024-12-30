import 'package:again/controller/change_room_controller.dart';
import 'package:again/controller/dashboard_controller.dart';
import 'package:again/model/change_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class ChangeRoomScreen extends StatelessWidget {
  final String? selectedBlock;
  final int? selectedRoom;
  ChangeRoomScreen({Key? key, this.selectedBlock, this.selectedRoom})
      : super(key: key);
  final userController = Get.find<DashboardController>();
  final changeRoomController = Get.put(ChangeRoomController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: userController,
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            foregroundColor: Colors.white,
            elevation: 0,
            backgroundColor: const Color(0xff5e35b1),
            title: Text(
              'Change Room',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xff5e35b1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Room',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildCurrentDetailBox(
                                'Room',
                                '${controller.userProfile?.roomNumber}',
                                Icons.door_sliding_outlined,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildCurrentDetailBox(
                                'Block',
                                '${controller.userProfile?.blockNumber}',
                                Icons.apartment_outlined,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('New Room Details'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdown(
                                selectedBlock ?? '', ['Block A', 'Block B']),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildDropdown(selectedRoom.toString(),
                                ['Room 201', 'Room 202']),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildSectionTitle('Reason for Change'),
                      const SizedBox(height: 16),
                      _buildReasonTextField(changeRoomController.reason),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: _buildSubmitButton(
            () {
              var uuid = Uuid();
              String uniqueId = uuid.v4();
              if (changeRoomController.reason.text.isNotEmpty) {
                RoomChangeRequest data = RoomChangeRequest(
                  blockNumber: controller.userProfile?.blockNumber,
                  email: controller.userProfile?.email,
                  firstName: controller.userProfile?.firstName,
                  lastName: controller.userProfile?.lastName,
                  roomNumber: controller.userProfile?.roomNumber,
                  userId: controller.userProfile?.userId,
                  status: 'Pending',
                  chngBlockNumber: selectedBlock,
                  chngRoomNumber: selectedRoom,
                  reason: changeRoomController.reason.text,
                  requestId: uniqueId,
                );
                changeRoomController.changeRoomUser(data);
              } else {
                ScaffoldMessenger.of(Get.context!).showSnackBar(
                  SnackBar(
                    content: Text('Please enter your reason'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildCurrentDetailBox(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: const Color(0xff5e35b1),
      ),
    );
  }

  Widget _buildDropdown(String hint, List<String> items) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        hint,
        style: GoogleFonts.poppins(fontSize: 14),
      ),
      // child: DropdownButtonFormField<String>(
      //   decoration: InputDecoration(
      //     contentPadding:
      //         const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      //     border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(12),
      //       borderSide: BorderSide.none,
      //     ),
      //     filled: true,
      //     fillColor: Colors.white,
      //   ),
      //   items: items.map((item) {
      //     return DropdownMenuItem(
      //       value: item,
      //       child: Text(
      //         item,
      //         style: GoogleFonts.poppins(fontSize: 14),
      //       ),
      //     );
      //   }).toList(),
      //   onChanged: (value) {},
      //   hint: Text(
      //     hint,
      //     style: GoogleFonts.poppins(
      //       fontSize: 14,
      //       color: Colors.grey.shade600,
      //     ),
      //   ),
      // ),
    );
  }

  Widget _buildReasonTextField(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: 'Write your reason here...',
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey.shade400,
          ),
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSubmitButton(void Function()? onPressed) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff5e35b1),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          'Submit Request',
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}
