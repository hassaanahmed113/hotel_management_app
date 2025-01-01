import 'package:again/controller/admin_request_controller.dart';
import 'package:again/firebase_service.dart';
import 'package:again/model/change_request_model.dart';
import 'package:again/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RoomChangeRequestScreen extends StatelessWidget {
  const RoomChangeRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0XFF5E35B1),
        title: Text(
          'Room Change Requests',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GetBuilder<AdminRequestController>(
        init: AdminRequestController(),
        builder: (controller) {
          return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.allRoomRequest.length,
              itemBuilder: (context, index) {
                RoomChangeRequest request = controller.allRoomRequest[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: RequestCard(
                    onApproved: (String requestId) async {
                      RoomChangeRequest data = controller.allRoomRequest
                          .where((element) => element.requestId == requestId)
                          .first;

                      UserProfile? user = await FirebaseService()
                          .getUserForStudent(data.userId ?? "");
                      user = user?.copyWith(
                          blockNumber: data.chngBlockNumber,
                          roomNumber: data.chngRoomNumber);
                      print(user?.toJson().toString());
                      controller.updateUserRequest(
                          data, 'Approved', user ?? UserProfile());
                    },
                    onRejected: (String requestId) async {
                      RoomChangeRequest data = controller.allRoomRequest
                          .where((element) => element.requestId == requestId)
                          .first;
                      UserProfile? user = await FirebaseService()
                          .getUserForStudent(data.userId ?? "");

                      controller.updateUserRequest(
                          data, 'Rejected', user ?? UserProfile());
                    },
                    request: request,
                  ),
                );
              });
        },
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  final RoomChangeRequest request;
  final void Function(String id)? onRejected;
  final void Function(String id)? onApproved;
  const RequestCard(
      {Key? key,
      required this.request,
      required this.onRejected,
      required this.onApproved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0XFF5E35B1).withOpacity(0.1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0XFF5E35B1),
                  child: Text(
                    (request.firstName ?? '').substring(0, 2).toUpperCase(),
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${request.firstName} ${request.lastName}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0XFF5E35B1),
                        ),
                      ),
                      Text(
                        'Room ${request.roomNumber}, Block ${request.blockNumber}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                _PriorityBadge(priority: 'Low'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _DetailRow(
                  icon: Icons.swap_horiz,
                  title: 'Requested Change',
                  value:
                      'Block ${request.chngBlockNumber}, Room ${request.chngRoomNumber}',
                ),
                const SizedBox(height: 8),
                // _DetailRow(
                //   icon: Icons.phone,
                //   title: 'Contact',
                //   value: '9003298398',
                // ),
                // const SizedBox(height: 8),
                _DetailRow(
                  icon: Icons.email,
                  title: 'Email',
                  value: '${request.email}',
                ),
                const SizedBox(height: 12),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reason for Change',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${request.reason}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          onRejected!(request.requestId ?? '');
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(color: Colors.red[400]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Reject',
                          style: GoogleFonts.poppins(
                            color: Colors.red[400],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          onApproved!(request.requestId ?? '');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: const Color(0XFF5E35B1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Approve',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0XFF5E35B1)),
        const SizedBox(width: 8),
        Text(
          '$title:',
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  final String priority;

  const _PriorityBadge({required this.priority});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: priority.contains('High') ? Colors.red[400] : Colors.amber,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        priority,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
