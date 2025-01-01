import 'dart:math';

import 'package:again/View/Auth/Login/LoginScreen.dart';
import 'package:again/View/Dashboard/DashboardScreen.dart';
import 'package:again/firebase_service.dart';
import 'package:again/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _degreeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? selectedBlock;
  String? selectedRoom;
  final List<String> blocks = ['A', 'B', 'C', 'D', 'E'];
  final List<String> rooms = ['101', '102', '103', '104', '105'];
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Color(0xFF5E35B1).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/signup.png',
                        scale: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Sign Up',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Let\'s know about yourself',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildTextField(
                    controller: _userNameController,
                    hintText: 'Username',
                    prefixIcon: Icons.person_outline,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Username is required' : null,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _firstNameController,
                          hintText: 'First Name',
                          prefixIcon: Icons.person_outline,
                          validator: (value) => value?.isEmpty ?? true
                              ? 'First name is required'
                              : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          controller: _lastNameController,
                          hintText: 'Last Name',
                          prefixIcon: Icons.person_outline,
                          validator: (value) => value?.isEmpty ?? true
                              ? 'Last name is required'
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _emailController,
                    hintText: 'Email address',
                    prefixIcon: Icons.email_outlined,
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Email is required';
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _degreeController,
                    hintText: 'Degree',
                    prefixIcon: Icons.school_outlined,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Degree is required' : null,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Password is required';
                      if (value!.length < 6)
                        return 'Password must be at least 6 characters';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: _obscureConfirmPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onPressed: () => setState(() =>
                          _obscureConfirmPassword = !_obscureConfirmPassword),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true)
                        return 'Confirm password is required';
                      if (value != _passwordController.text)
                        return 'Passwords do not match';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdown(
                          value: selectedBlock,
                          items: blocks,
                          hintText: 'Block',
                          prefixIcon: Icons.apartment,
                          onChanged: (value) =>
                              setState(() => selectedBlock = value),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDropdown(
                          value: selectedRoom,
                          items: rooms,
                          hintText: 'Room',
                          prefixIcon: Icons.meeting_room_outlined,
                          onChanged: (value) =>
                              setState(() => selectedRoom = value),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF5E35B1),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          User? user = await FirebaseService().signUpUser(
                              _emailController.text, _passwordController.text);
                          await FirebaseService().addUser(UserProfile(
                              blockNumber: selectedBlock,
                              roomNumber: int.parse(selectedRoom ?? ''),
                              degree: _degreeController.text,
                              email: _emailController.text,
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              isAdmin: false,
                              userId: user?.uid,
                              username: _userNameController.text,
                              charges: Charges(
                                  maintenance: 1000.0,
                                  parking: 1000.0,
                                  roomCharge: num.parse(
                                      '${generateRandomNumber()}00.0'),
                                  water: 500.0)));
                          _degreeController.clear();
                          _emailController.clear();
                          _firstNameController.clear();
                          _lastNameController.clear();
                          _userNameController.clear();
                          _passwordController.clear();
                          _confirmPasswordController.clear();
                          selectedBlock = null;
                          selectedRoom = null;
                          setState(() {});
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: GoogleFonts.poppins(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign In',
                              style: GoogleFonts.poppins(
                                color: Color(0xFF5E35B1),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  int generateRandomNumber() {
    final random = Random();
    return random.nextInt(9) + 1; // Generates a random number between 1 and 9
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: GoogleFonts.poppins(fontSize: 15),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: 15,
          color: Colors.black38,
        ),
        prefixIcon: Icon(
          prefixIcon,
          size: 20,
          color: Colors.black54,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xFF5E35B1), width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required String hintText,
    required IconData prefixIcon,
    required void Function(String?)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            size: 20,
            color: Colors.black54,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color(0xFF5E35B1), width: 1),
          ),
        ),
        hint: Text(
          hintText,
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.black38,
          ),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? '$hintText is required' : null,
      ),
    );
  }
}
