import 'package:again/View/AllIssues/StudentissueScreen.dart';
import 'package:again/View/AllStaff/AllStaffScren.dart';
import 'package:again/View/Auth/Login/LoginScreen.dart';
import 'package:again/View/RoomChangeRequest/RoomChangeRequest.dart';
import 'package:again/controller/dashboard_controller.dart';
import 'package:again/controller/get_issue_controller.dart';
import 'package:again/controller/hostel_fee_controller.dart';
import 'package:again/controller/room_available_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userController = Get.find<DashboardController>();

  bool isAdmin = false;

  final getRoomController = Get.put(RoomAvailableController());
  final totalStudent = Get.put(HostelFeeController());
  final getIssues = Get.put(GetIssueController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (userController.userProfile?.isAdmin == true) {
      getRoomController.geTotalRooms();
      totalStudent.getHostelFee();
      getIssues.getTotalIssue();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: userController,
        builder: (controller) {
          controller.firstName.text = controller.userProfile?.firstName ?? "";
          controller.lastName.text = controller.userProfile?.lastName ?? "";
          controller.degree.text = controller.userProfile?.degree ?? "";

          return Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xff5e35b1),
              elevation: 0,
              title: Text(
                'Profile',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff5e35b1),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: Icon(Icons.person,
                              size: 50, color: Color(0xff5e35b1)),
                        ),
                        SizedBox(height: 16),
                        Text(
                          (controller.userProfile?.isAdmin ?? false)
                              ? 'You\'re Admin'
                              : '${controller.userProfile?.firstName} ${controller.userProfile?.lastName}',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                  (controller.userProfile?.isAdmin ?? false)
                      ? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GetBuilder<HostelFeeController>(
                                            init: totalStudent,
                                            builder: (controller) {
                                              return _buildStatCard(
                                                  'Total Students',
                                                  '${controller.allUserFees.length}',
                                                  Icons.people_outline,
                                                  context);
                                            }),
                                        GetBuilder<RoomAvailableController>(
                                          init: getRoomController,
                                          builder: (controller) {
                                            return _buildStatCard(
                                                'Total Rooms',
                                                '${controller.totalRoom}',
                                                Icons.apartment_outlined,
                                                context);
                                          },
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GetBuilder<GetIssueController>(
                                            init: getIssues,
                                            builder: (controller) {
                                              return _buildStatCard(
                                                  'Complaints',
                                                  '${controller.totalIssues.length}',
                                                  Icons.warning_amber_outlined,
                                                  context);
                                            }),
                                        _buildStatCard(
                                            'Notices',
                                            '12',
                                            Icons.notifications_outlined,
                                            context),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 25),
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    _buildQuickActionButton(
                                      'All Issues',
                                      Icons.report_outlined,
                                      () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StudentIssuesScreen()));
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    _buildQuickActionButton(
                                      'Manage Staff',
                                      Icons.people_outlined,
                                      () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AllStaffScreen()));
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    _buildQuickActionButton(
                                      'Change Requests',
                                      Icons.swap_horiz_outlined,
                                      () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RoomChangeRequestScreen()));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ModernTextField(
                                      controller: controller.firstName,
                                      label: 'First Name',
                                      initialValue:
                                          controller.userProfile?.firstName ??
                                              '',
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: ModernTextField(
                                      controller: controller.lastName,
                                      label: 'Last Name',
                                      initialValue:
                                          controller.userProfile?.lastName ??
                                              '',
                                    ),
                                  ),
                                ],
                              ),
                              ModernTextField(
                                isRead: true,
                                label: 'Email',
                                initialValue:
                                    controller.userProfile?.email ?? '',
                                icon: Icons.email_outlined,
                              ),
                              ModernTextField(
                                isRead: true,
                                label: 'Username',
                                initialValue:
                                    controller.userProfile?.username ?? '',
                                icon: Icons.person_outline,
                              ),
                              ModernTextField(
                                isRead: true,
                                label: 'Room No.',
                                initialValue: controller.userProfile?.roomNumber
                                        .toString() ??
                                    '',
                                icon: Icons.room_outlined,
                              ),
                              ModernTextField(
                                isRead: true,
                                label: 'Block No.',
                                initialValue:
                                    controller.userProfile?.blockNumber ?? '',
                                icon: Icons.apartment_outlined,
                              ),
                              ModernTextField(
                                controller: controller.degree,
                                label: 'Degree',
                                initialValue:
                                    controller.userProfile?.degree ?? '',
                                icon: Icons.school_outlined,
                              ),
                              SizedBox(height: 15),
                              Container(
                                width: double.infinity,
                                height: 55,
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.updateUser();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff5e35b1),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    'Save',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          );
        });
  }
}

class ModernTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final IconData? icon;
  final bool isRead;
  final TextEditingController? controller;

  const ModernTextField({
    Key? key,
    required this.label,
    this.isRead = false,
    this.controller,
    required this.initialValue,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        readOnly: isRead,
        controller: controller,
        // Only use initialValue if controller is not provided
        initialValue: controller == null ? initialValue : null,
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(
            color: Colors.grey[600],
            fontSize: 14,
          ),
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: Color(0xff5e35b1),
                  size: 22,
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xff5e35b1), width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}

Widget _buildStatCard(
    String title, String value, IconData icon, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.38,
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Color(0xff5e35b1).withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Color(0xff5e35b1),
          size: 24,
        ),
        SizedBox(height: 12),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xff5e35b1),
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    ),
  );
}

Widget _buildQuickActionButton(
    String title, IconData icon, VoidCallback onTap) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xff5e35b1).withOpacity(0.2),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Color(0xff5e35b1),
              size: 24,
            ),
            SizedBox(width: 16),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xff5e35b1),
              size: 18,
            ),
          ],
        ),
      ),
    ),
  );
}
