import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllStaffScreen extends StatelessWidget {
  const AllStaffScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> staffData = [
      {
        'name': 'John Doe',
        'designation': 'Manager',
        'email': 'john.doe@example.com',
        'phone': '9001234567',
        'block': 'A'
      },
      {
        'name': 'Jane Smith',
        'designation': 'Cleaner',
        'email': 'jane.smith@example.com',
        'phone': '9009876543',
        'block': 'B'
      },
      {
        'name': 'Michael Brown',
        'designation': 'Electrician',
        'email': 'michael.brown@example.com',
        'phone': '9005678901',
        'block': 'C'
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF5E35B1),
        title: Text(
          'All Staff',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Color(0xFF5E35B1)),
                hintText: 'Search Staff...',
                hintStyle: GoogleFonts.poppins(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFFF3E5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: staffData.length,
                itemBuilder: (context, index) {
                  final staff = staffData[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: const Color(0xFFD1C4E9),
                                child: const Icon(
                                  Icons.person,
                                  size: 28,
                                  color: Color(0xFF5E35B1),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    staff['name']!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF4527A0),
                                    ),
                                  ),
                                  Text(
                                    staff['designation']!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Divider(color: Colors.grey, height: 1),
                          const SizedBox(height: 8),
                          _buildDetailRow('Email', staff['email']!),
                          _buildDetailRow('Phone', staff['phone']!),
                          _buildDetailRow('Block', staff['block']!),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      'Delete ${staff['name']}?',
                                      style: GoogleFonts.poppins(),
                                    ),
                                    content: Text(
                                      'Are you sure you want to delete this staff member?',
                                      style: GoogleFonts.poppins(),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Cancel',
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey)),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Delete',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500)),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                          )),
                                    ],
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0XFF5E35B1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Delete',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
