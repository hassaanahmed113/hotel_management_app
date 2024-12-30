import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HostelFeeManagementScreen extends StatefulWidget {
  const HostelFeeManagementScreen({Key? key}) : super(key: key);

  @override
  State<HostelFeeManagementScreen> createState() =>
      _HostelFeeManagementScreenState();
}

class _HostelFeeManagementScreenState extends State<HostelFeeManagementScreen> {
  final List<Map<String, dynamic>> students = [
    {
      'name': 'Uzair Arshad',
      'rollNo': '19-NTU-CS-1137',
      'room': 'Room 201',
      'fee': 25000,
      'status': 'Pending',
      'lastPaid': '-',
    },
    {
      'name': 'Ali Ahmed',
      'rollNo': '19-NTU-CS-1138',
      'room': 'Room 202',
      'fee': 25000,
      'status': 'Pending',
      'lastPaid': '-',
    },
    {
      'name': 'Hassan Khan',
      'rollNo': '19-NTU-CS-1139',
      'room': 'Room 203',
      'fee': 25000,
      'status': 'Paid',
      'lastPaid': '2024-03-20',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: students.length,
              itemBuilder: (context, index) {
                return StudentFeeCard(
                  studentData: students[index],
                  onCollectFee: () => _collectFee(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _collectFee(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Collect Fee',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student: ${students[index]['name']}',
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(height: 8),
            Text(
              'Amount: Rs. ${students[index]['fee']}',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff5e35b1),
            ),
            onPressed: () {
              setState(() {
                students[index]['status'] = 'Paid';
                students[index]['lastPaid'] =
                    DateTime.now().toString().split(' ')[0];
              });
              Navigator.pop(context);
            },
            child: Text(
              'Confirm Payment',
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class StudentFeeCard extends StatelessWidget {
  final Map<String, dynamic> studentData;
  final VoidCallback onCollectFee;

  const StudentFeeCard({
    Key? key,
    required this.studentData,
    required this.onCollectFee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPaid = studentData['status'] == 'Paid';

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
                    studentData['name'][0],
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        studentData['name'],
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${studentData['rollNo']} | ${studentData['room']}',
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 14,
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
                    studentData['status'],
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
                  'Rs. ${studentData['fee']}',
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
                    'Last Paid:',
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                  Text(
                    studentData['lastPaid'],
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
                  onPressed: onCollectFee,
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
