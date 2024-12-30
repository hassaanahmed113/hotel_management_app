import 'package:again/controller/create_issue_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

String? selectedValue;

class CreateIssueScreen extends StatefulWidget {
  CreateIssueScreen({Key? key}) : super(key: key);

  @override
  State<CreateIssueScreen> createState() => _CreateIssueScreenState();
}

class _CreateIssueScreenState extends State<CreateIssueScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateIssueController>(
      init: CreateIssueController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xff5e35b1),
            elevation: 0,
            title: Text(
              'Create Issue',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
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
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                        ),
                        child: Icon(
                          Icons.report_problem_outlined,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Report an Issue',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ModernTextField(
                              controller: controller.roomNumber,
                              label: 'Room Number',
                              keyboardType: TextInputType.number,
                              icon: Icons.room_outlined,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: ModernTextField(
                              keyboardType: TextInputType.text,
                              controller: controller.blockNumber,
                              label: 'Block Number',
                              icon: Icons.apartment_outlined,
                            ),
                          ),
                        ],
                      ),
                      ModernTextField(
                        controller: controller.email,
                        keyboardType: TextInputType.text,
                        label: 'Email ID',
                        icon: Icons.email_outlined,
                      ),
                      ModernTextField(
                        controller: controller.phoneNumber,
                        keyboardType: TextInputType.phone,
                        label: 'Phone Number',
                        icon: Icons.phone_outlined,
                      ),
                      ModernDropdown(
                        label: 'Issue Type',
                        icon: Icons.help_outline,
                        onChanged: (value) {
                          controller.issueType = value!;
                          controller.update();
                        },
                        items: [
                          'Plumbing',
                          'Electricity',
                          'Internet',
                          'Others'
                        ],
                      ),
                      ModernTextField(
                        controller: controller.comment,
                        keyboardType: TextInputType.text,
                        label: 'Comment',
                        icon: Icons.comment_outlined,
                        maxLines: 4,
                      ),
                      SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            if (controller.roomNumber.text.isEmpty ||
                                controller.blockNumber.text.isEmpty ||
                                controller.email.text.isEmpty ||
                                controller.phoneNumber.text.isEmpty ||
                                controller.comment.text.isEmpty ||
                                controller.issueType == null) {
                              // Show snackbar with a message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please fill out all fields.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              // Proceed with the issue submission
                              controller.createIssueUser();
                              controller.clearText();
                              selectedValue =
                                  null; // Reset selected value for the issue type
                              setState(() {}); // Update the UI
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff5e35b1),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Submit Issue',
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
      },
    );
  }
}

class ModernTextField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final int maxLines;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  const ModernTextField({
    Key? key,
    required this.label,
    this.icon,
    this.maxLines = 1,
    this.controller,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        maxLines: maxLines,
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

class ModernDropdown extends StatefulWidget {
  final String label;
  final IconData? icon;
  final List<String> items;
  final Function(String?)? onChanged;
  const ModernDropdown({
    Key? key,
    required this.label,
    this.icon,
    required this.items,
    this.onChanged,
  }) : super(key: key);

  @override
  State<ModernDropdown> createState() => _ModernDropdownState();
}

class _ModernDropdownState extends State<ModernDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: GoogleFonts.poppins(
            color: Colors.grey[600],
            fontSize: 14,
          ),
          prefixIcon: widget.icon != null
              ? Icon(
                  widget.icon,
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
        items: widget.items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: GoogleFonts.poppins(),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedValue = value;
            widget.onChanged!(value);
          });
        },
      ),
    );
  }
}
