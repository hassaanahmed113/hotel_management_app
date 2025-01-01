import 'dart:developer';

import 'package:again/View/YourIssues/YourIssuesScreen.dart';
import 'package:again/controller/hostel_fee_controller.dart';
import 'package:again/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HostelFeeManagementScreen extends StatefulWidget {
  const HostelFeeManagementScreen({Key? key}) : super(key: key);

  @override
  State<HostelFeeManagementScreen> createState() =>
      _HostelFeeManagementScreenState();
}

class _HostelFeeManagementScreenState extends State<HostelFeeManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelFeeController>(
      init: HostelFeeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            foregroundColor: Colors.white,
            elevation: 0,
            backgroundColor: const Color(0xff5e35b1),
            title: Text(
              'Hostel Fee Management',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search student...',
                    hintStyle: GoogleFonts.poppins(),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  onChanged: (value) {
                    log(value);
                    controller.searchVal = value;
                    controller.update();
                    controller.tempSearchList();
                  },
                ),
              ),
              controller.searchVal.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: controller.allUserFeesTemp.length,
                        itemBuilder: (context, index) {
                          return StudentFeeCard(
                            studentData: controller.allUserFeesTemp[index],
                            onCollectFee: (String userId) {
                              UserProfile user = controller.allUserFeesTemp
                                  .where(
                                    (element) => element.userId == userId,
                                  )
                                  .first;
                              controller.updateUserProfile(user);
                            },
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: controller.allUserFees.length,
                        itemBuilder: (context, index) {
                          return StudentFeeCard(
                            studentData: controller.allUserFees[index],
                            onCollectFee: (String userId) {
                              UserProfile user = controller.allUserFees
                                  .where(
                                    (element) => element.userId == userId,
                                  )
                                  .first;
                              controller.updateUserProfile(user);
                            },
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}

class StudentFeeCard extends StatelessWidget {
  final UserProfile studentData;
  final void Function(String userId)? onCollectFee;

  const StudentFeeCard({
    Key? key,
    required this.studentData,
    required this.onCollectFee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPaid = studentData.charges?.status == 'Paid';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xff5e35b1),
                  child: Text(
                    '${studentData.firstName}'.substring(0, 1).toUpperCase(),
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${studentData.firstName} ${studentData.lastName}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${studentData.charges?.feeId} | Room ${studentData.roomNumber}',
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isPaid ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${studentData.charges?.status}',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fee Amount:',
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
                Text(
                  '${'\$'}${(double.parse(studentData.charges?.roomCharge.toString() ?? '') + double.parse(studentData.charges?.maintenance.toString() ?? '') + double.parse(studentData.charges?.parking.toString() ?? '') + double.parse(studentData.charges?.water.toString() ?? '')).toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            if (isPaid) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Last Paid: ',
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                  Text(
                    '${formatTimestampFromFirebase(studentData.charges?.lastPaid ?? Timestamp(0, 0))}',
                    style: GoogleFonts.poppins(color: Colors.green),
                  ),
                ],
              ),
            ],
            if (!isPaid) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff5e35b1),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    onCollectFee!(studentData.userId ?? '');
                  },
                  child: Text(
                    'Collect Fee',
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
