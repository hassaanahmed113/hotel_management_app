// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class StudentIssuesScreen extends StatelessWidget {
//   const StudentIssuesScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       appBar: AppBar(
//         elevation: 0,
//         foregroundColor: Colors.white,
//         backgroundColor: const Color(0xff5e35b1),
//         title: Text(
//           'Student Issues',
//           style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(24),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xff5e35b1).withOpacity(0.1),
//                       blurRadius: 20,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: const Color(0xff5e35b1).withOpacity(0.1),
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(24),
//                           topRight: Radius.circular(24),
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               shape: BoxShape.circle,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.1),
//                                   blurRadius: 10,
//                                 ),
//                               ],
//                             ),
//                             child: Icon(
//                               Icons.person,
//                               size: 32,
//                               color: const Color(0xff5e35b1),
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Uzair Arshad',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: const Color(0xff5e35b1),
//                                 ),
//                               ),
//                               Text(
//                                 'Room 201, Block 2-A',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 14,
//                                   color: Colors.black54,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Column(
//                         children: [
//                           DetailTile(
//                             icon: Icons.person_outline,
//                             label: 'Username',
//                             value: 'Uzair',
//                           ),
//                           DetailTile(
//                             icon: Icons.email_outlined,
//                             label: 'Email ID',
//                             value: 'uzair@gmail.com',
//                           ),
//                           const Divider(height: 32),
//                           Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: const Color(0xff5e35b1).withOpacity(0.05),
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'ISSUE DETAILS',
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     color: const Color(0xff5e35b1),
//                                     letterSpacing: 1.2,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 12),
//                                 DetailTile(
//                                   icon: Icons.warning_amber_rounded,
//                                   label: 'Issue Type',
//                                   value: 'Bathroom',
//                                 ),
//                                 DetailTile(
//                                   icon: Icons.comment_outlined,
//                                   label: 'Comment',
//                                   value: 'Leakage',
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 height: 56,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xff5e35b1),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     elevation: 2,
//                   ),
//                   onPressed: () {},
//                   child: Text(
//                     'Resolve Issue',
//                     style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DetailTile extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;

//   const DetailTile({
//     Key? key,
//     required this.icon,
//     required this.label,
//     required this.value,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Icon(
//             icon,
//             size: 20,
//             color: const Color(0xff5e35b1),
//           ),
//           const SizedBox(width: 12),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: GoogleFonts.poppins(
//                   fontSize: 12,
//                   color: Colors.black54,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Text(
//                 value,
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:again/controller/student_issue_controller.dart';
import 'package:again/firebase_service.dart';
import 'package:again/model/create_issue_model.dart';
import 'package:again/model/student_issue_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentIssuesScreen extends StatelessWidget {
  StudentIssuesScreen({Key? key}) : super(key: key);
  final studIsue = Get.put(StudentIssueController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xff5e35b1),
          title: Text(
            'Student Issues',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: StreamBuilder<List<StudentIssue>>(
            stream:
                FirebaseService().listenToStudentIssues(), // Your stream here
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No issues found.'));
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      const Color(0xff5e35b1).withOpacity(0.1),
                                  radius: 24,
                                  child: Text(
                                    '${snapshot.data?[index].user?.firstName}'
                                        .substring(0, 2)
                                        .toUpperCase(),
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff5e35b1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${snapshot.data?[index].user?.firstName} ${snapshot.data?[index].user?.lastName}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Room ${snapshot.data?[index].user?.roomNumber}, Block ${snapshot.data?[index].user?.blockNumber}',
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
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: DetailTile(
                                    icon: Icons.person_outline,
                                    label: 'Username',
                                    value:
                                        '${snapshot.data?[index].user?.username}',
                                  ),
                                ),
                                Expanded(
                                  child: DetailTile(
                                    icon: Icons.email_outlined,
                                    label: 'Email',
                                    value:
                                        '${snapshot.data?[index].user?.email}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 32),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'REPORTED ISSUES',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff5e35b1),
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                StreamBuilder<List<Issue>>(
                                    stream: FirebaseService()
                                        .getIssuesStreamWithID(
                                            snapshot.data?[index].userId ?? ""),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'));
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return Center(
                                            child: Text('No issues found.'));
                                      } else {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data?.length,
                                          itemBuilder: (context, index) {
                                            return IssueCard(
                                              issueData: snapshot.data?[index],
                                              onPressed: (String docId,
                                                  String issueId) async {
                                                Issue? issueClick =
                                                    snapshot.data
                                                        ?.where(
                                                          (element) =>
                                                              element.issueId ==
                                                              issueId,
                                                        )
                                                        .first;
                                                if (issueClick?.issueStatus !=
                                                    'Resolved') {
                                                  String? allId =
                                                      await FirebaseService()
                                                          .getDocumentIdForIssue(
                                                              docId, issueId);

                                                  issueClick =
                                                      issueClick?.copyWith(
                                                          issueStatus:
                                                              'Resolved');
                                                  studIsue.updateStudenIssue(
                                                      issueClick ?? Issue(),
                                                      docId,
                                                      allId ?? '');
                                                }
                                              },
                                            );
                                          },
                                        );
                                      }
                                    })
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }));
  }
}

class IssueCard extends StatelessWidget {
  final Issue? issueData;
  final void Function(String docId, String id)? onPressed;

  const IssueCard({
    Key? key,
    required this.issueData,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff5e35b1).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: DetailTile(
                  icon: Icons.warning_amber_rounded,
                  label: 'Issue Type',
                  value: issueData?.issueType ?? '',
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: issueData?.issueStatus == 'Pending'
                      ? Colors.orange.withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  issueData?.issueStatus ?? '',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: issueData?.issueStatus == 'Pending'
                        ? Colors.orange
                        : Colors.green,
                  ),
                ),
              ),
            ],
          ),
          DetailTile(
            icon: Icons.comment_outlined,
            label: 'Comment',
            value: issueData?.comment ?? '',
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: issueData?.issueStatus == 'Pending'
                    ? const Color(0xff5e35b1)
                    : Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                onPressed!(issueData?.docId ?? '', issueData?.issueId ?? "");
              },
              child: Text(
                issueData?.issueStatus == 'Pending'
                    ? 'Resolve Issue'
                    : 'Issue Resolved',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const DetailTile({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: const Color(0xff5e35b1),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
