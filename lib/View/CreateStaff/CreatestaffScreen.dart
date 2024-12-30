import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateStaffScreen extends StatelessWidget {
  const CreateStaffScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        foregroundColor: Colors.white,
        elevation: 0,
        backgroundColor: const Color(0xff5e35b1),
        title: Text(
          'Create Staff',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
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
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Staff Information',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create a new staff member',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomTextField(
                    labelText: 'Username',
                    icon: Icons.person_outline,
                    hint: 'Enter username',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          labelText: 'First Name',
                          icon: Icons.badge_outlined,
                          hint: 'Enter first name',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          labelText: 'Last Name',
                          hint: 'Enter last name',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    labelText: 'Job Role',
                    icon: Icons.work_outline,
                    hint: 'Enter job role',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    labelText: 'Email',
                    icon: Icons.email_outlined,
                    hint: 'Enter email address',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    labelText: 'Password',
                    icon: Icons.lock_outline,
                    hint: 'Enter password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    labelText: 'Phone Number',
                    icon: Icons.phone_outlined,
                    hint: 'Enter phone number',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildCreateButton(),
    );
  }

  Widget _buildCreateButton() {
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
        onPressed: () {},
        child: Text(
          'Create Staff',
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData? icon;
  final String hint;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.icon,
    required this.hint,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xff5e35b1),
          ),
        ),
        const SizedBox(height: 8),
        Container(
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
          child: TextFormField(
            style: GoogleFonts.poppins(fontSize: 14),
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade400,
              ),
              prefixIcon: icon != null
                  ? Icon(
                      icon,
                      color: const Color(0xff5e35b1),
                      size: 20,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}
