import 'package:again/View/CreateIssue/CreateissueScreen.dart';
import 'package:again/controller/dashboard_controller.dart';
import 'package:again/controller/get_issue_controller.dart';
import 'package:again/model/create_issue_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class YourIssuesScreen extends StatefulWidget {
  YourIssuesScreen({Key? key}) : super(key: key);

  @override
  State<YourIssuesScreen> createState() => _YourIssuesScreenState();
}

class _YourIssuesScreenState extends State<YourIssuesScreen> {
  final getScreenController = Get.put(GetIssueController());
  final userController = Get.find<DashboardController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getScreenController.getIssueUser();
    getScreenController.startListening();
  }

  @override
  Widget build(BuildContext context) {
    // String firstTwoLetters = studentData['name'].substring(0, 2);

    return GetBuilder<GetIssueController>(
      init: getScreenController,
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            elevation: 0,
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xff5e35b1),
            title: Text(
              'Your Issues',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 20),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Student Profile Card
                GetBuilder<DashboardController>(
                    init: userController,
                    builder: (controller) {
                      return Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff5e35b1).withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  const Color(0xff5e35b1).withOpacity(0.1),
                              radius: 30,
                              child: Text(
                                (controller.userProfile?.firstName ?? '')
                                    .substring(0, 2)
                                    .toUpperCase(),
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff5e35b1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${controller.userProfile?.firstName} ${controller.userProfile?.lastName}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Room ${controller.userProfile?.roomNumber}, Block ${controller.userProfile?.blockNumber}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                // Issues Summary
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _buildSummaryCard(
                        'Total Issues',
                        controller.issueUser.length.toString(),
                        Icons.list_alt,
                        const Color(0xff5e35b1),
                      ),
                      const SizedBox(width: 12),
                      _buildSummaryCard(
                        'Pending',
                        controller.issueUser
                            .where(
                              (e) => e.issueStatus == 'Pending',
                            )
                            .length
                            .toString(),
                        Icons.pending_actions,
                        Colors.orange,
                      ),
                      const SizedBox(width: 12),
                      _buildSummaryCard(
                        'Resolved',
                        controller.issueUser
                            .where(
                              (e) => e.issueStatus == 'Resolved',
                            )
                            .length
                            .toString(),
                        Icons.check_circle_outline,
                        Colors.green,
                      ),
                    ],
                  ),
                ),

                // Issues List
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'YOUR REPORTED ISSUES',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff5e35b1),
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.issueUser.length,
                        itemBuilder: (context, index) {
                          Issue issue = controller.issueUser[index];
                          return IssueCard(issueData: issue);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xff5e35b1),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateIssueScreen()));
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryCard(
      String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class IssueCard extends StatelessWidget {
  final Issue issueData;

  const IssueCard({
    Key? key,
    required this.issueData,
  }) : super(key: key);

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'in progress':
        return Colors.blue;
      case 'resolved':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xff5e35b1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 16,
                      color: const Color(0xff5e35b1),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      issueData.issueType ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff5e35b1),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor(issueData.issueStatus ?? '')
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  issueData.issueStatus ?? '',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(issueData.issueStatus ?? ''),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            issueData.comment ?? '',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Submitted: ${formatTimestampFromFirebase(issueData.date ?? Timestamp(0, 0))}',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Last Updated: ${formatTimestampFromFirebase(issueData.lastUpdated ?? Timestamp(0, 0))}',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String formatTimestampFromFirebase(Timestamp timestamp) {
  try {
    DateTime dateTime = timestamp.toDate();

    return DateFormat("yyyy-MM-dd").format(dateTime);
  } catch (e) {
    print('Error formatting Firebase timestamp: $e');
    return '';
  }
}
