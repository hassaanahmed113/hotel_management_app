import 'package:again/View/AllIssues/StudentissueScreen.dart';
import 'package:again/View/AllStaff/AllStaffScren.dart';
import 'package:again/View/CreateIssue/CreateissueScreen.dart';
import 'package:again/View/CreateStaff/CreatestaffScreen.dart';
import 'package:again/View/HostelFee/HostelFeeScreen.dart';
import 'package:again/View/HostelMenu/HostelMenuScreen.dart';
import 'package:again/View/ManageFees/ManageFeesScreen.dart';
import 'package:again/View/Profile/ProfileScreen.dart';
import 'package:again/View/RoomAvailability/RoomAvailableScreen.dart';
import 'package:again/View/RoomChangeRequest/RoomChangeRequest.dart';
import 'package:again/View/YourIssues/YourIssuesScreen.dart';
import 'package:again/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isAdmin = false;
  final dashboard = Get.put(DashboardController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dashboard.getUser();
    dashboard.startListening();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: dashboard,
        builder: (controller) {
          return Scaffold(
            backgroundColor: const Color(0xFF5E35B1),
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dashboard',
                          style: GoogleFonts.poppins(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.person_outline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF5E35B1).withOpacity(0.1),
                                      const Color(0xFF5E35B1).withOpacity(0.05),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${controller.userProfile?.firstName} ${controller.userProfile?.lastName}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF5E35B1),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          RichText(
                                            text: TextSpan(
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.black87,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Room ',
                                                  style: TextStyle(
                                                    color: Color(0xFF5E35B1),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: controller.userProfile
                                                          ?.roomNumber
                                                          .toString() ??
                                                      '',
                                                ),
                                                TextSpan(
                                                  text: ' • Block ',
                                                  style: TextStyle(
                                                    color: Color(0xFF5E35B1),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: controller.userProfile
                                                          ?.blockNumber ??
                                                      '',
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/images/dash.png',
                                      height: 100,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 25),
                              Text(
                                'Quick Actions',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 15),
                              GridView.count(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  childAspectRatio: 1.1,
                                  children:
                                      (controller.userProfile?.isAdmin ?? false)
                                          ? [
                                              _buildCategoryCard(
                                                context: context,
                                                icon: Icons.bed_outlined,
                                                label: 'Room Availability',
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        RoomAvailabilitiesScreen(),
                                                  ),
                                                ),
                                              ),
                                              _buildCategoryCard(
                                                context: context,
                                                icon: Icons.report_outlined,
                                                label: 'All Issues',
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        StudentIssuesScreen(),
                                                  ),
                                                ),
                                              ),
                                              _buildCategoryCard(
                                                context: context,
                                                icon: Icons.people_outline,
                                                label: 'Staff Members',
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AllStaffScreen(),
                                                  ),
                                                ),
                                              ),
                                              _buildCategoryCard(
                                                context: context,
                                                icon: Icons.person_add_outlined,
                                                label: 'Create Staff',
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CreateStaffScreen(),
                                                  ),
                                                ),
                                              ),
                                              _buildCategoryCard(
                                                context: context,
                                                icon: Icons
                                                    .account_balance_wallet_outlined,
                                                label: 'Manage Fees',
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        HostelFeeManagementScreen(),
                                                  ),
                                                ),
                                              ),
                                              _buildCategoryCard(
                                                context: context,
                                                icon: Icons.swap_horiz_outlined,
                                                label: 'Change Requests',
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        RoomChangeRequestScreen(),
                                                  ),
                                                ),
                                              ),
                                            ]
                                          : [
                                              _buildCategoryCard(
                                                context: context,
                                                icon: Icons.add_circle_outline,
                                                label: 'Create Issue',
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CreateIssueScreen(),
                                                  ),
                                                ),
                                              ),
                                              _buildCategoryCard(
                                                context: context,
                                                icon: Icons.bed_outlined,
                                                label: 'Room Availability',
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        RoomAvailabilitiesScreen(),
                                                  ),
                                                ),
                                              ),
                                              _buildCategoryCard(
                                                context: context,
                                                icon: Icons.report_outlined,
                                                label: 'Your Issues',
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        YourIssuesScreen(),
                                                  ),
                                                ),
                                              ),
                                              _buildCategoryCard(
                                                context: context,
                                                icon: Icons.food_bank_outlined,
                                                label: 'Hostel Menu',
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        HostelMenuScreen(),
                                                  ),
                                                ),
                                              ),
                                              _buildCategoryCard(
                                                context: context,
                                                icon: Icons
                                                    .account_balance_wallet_outlined,
                                                label: 'Hostel Fee',
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        HostelFeesScreen(),
                                                  ),
                                                ),
                                              ),
                                            ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildCategoryCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF5E35B1).withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                size: 30,
                color: const Color(0xFF5E35B1),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
