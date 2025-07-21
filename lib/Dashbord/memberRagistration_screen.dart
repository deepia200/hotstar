import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/api_methods.dart'; // Corrected API import
import '../provider/member_provider.dart';
import '../models/member_model.dart';
import '../screens/Dashboard_screen.dart';
import 'nominee_screen.dart';

class NewMemberRegistrationScreen extends StatefulWidget {
  const NewMemberRegistrationScreen({super.key});

  @override
  State<NewMemberRegistrationScreen> createState() => _NewMemberRegistrationScreenState();
}

class _NewMemberRegistrationScreenState extends State<NewMemberRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userIdController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _addressController = TextEditingController();

  String? _gender;
  bool _termsAccepted = false;
  String? _fetchedUserName;
  bool _userFound = false;

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.grey[850],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  Future<void> _fetchUserDetails() async {
    final id = _userIdController.text.trim();
    if (id.isEmpty) {
      setState(() {
        _fetchedUserName = null;
        _userFound = false;
      });
      return;
    }

    try {
      final name = await ApiMethods.fetchUserNameById(id);
      if (name != null) {
        setState(() {
          _fetchedUserName = name;
          _userFound = true;
        });
      } else {
        setState(() {
          _fetchedUserName = "No user found";
          _userFound = false;
        });
      }
    } catch (e) {
      setState(() {
        _fetchedUserName = "No user found";
        _userFound = false;
      });
    }
  }

  Future<void> _registerMember() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id');

    if (!_formKey.currentState!.validate()) return;

    if (id == null || id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User ID not found. Please login again.")),
      );
      return;
    }

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final fatherName = _fatherNameController.text.trim();
    final gender = _gender;
    final address = _addressController.text.trim();
    final reff = id;
    final sponsor = id;

    try {
      final response = await ApiMethods.registerMember(
        name: name,
        email: email,
        fatherName: fatherName,
        gender: gender ?? '',
        address: address,
        reff: reff,
        sponsor: sponsor,
        phone: phone,
      );

      print("API response: $response");

      if (response['status'] == 'success') {
        final data = response['data'];
        final message = response['message'];

        final newMember = Member(
          name: name,
          email: email,
          userId: data['new_user_id'] ?? '',
        );
        Provider.of<MemberProvider>(context, listen: false).addMember(newMember);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message ?? "Registration successful")),
        );

        // Clear form
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _fatherNameController.clear();
        _addressController.clear();
        setState(() {
          _gender = null;
          _termsAccepted = false;
        });

        // Navigate to dashboard
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? 'Failed to register')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'New Member Registration',
            style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // User ID
                      TextFormField(
                        controller: _userIdController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("User ID").copyWith(
                          suffixIcon: _fetchedUserName == null
                              ? TextButton(
                            onPressed: _fetchUserDetails,
                            child: const Text(
                              "Verify",
                              style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                            ),
                          )
                              : IconButton(
                            onPressed: _fetchUserDetails,
                            icon: Icon(
                              _userFound ? Icons.verified_outlined : Icons.error_outline,
                              color: _userFound ? Colors.greenAccent : Colors.redAccent,
                            ),
                          ),
                        ),
                        validator: (val) => val!.isEmpty ? 'Enter user ID' : null,
                      ),

                      const SizedBox(height: 8),

                      if (_fetchedUserName != null)
                        Text(
                          _userFound ? "Name: $_fetchedUserName" : _fetchedUserName!,
                          style: TextStyle(
                            color: _userFound ? Colors.white : Colors.redAccent,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      const SizedBox(height: 16),

                      // Name
                      TextFormField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Name"),
                        validator: (val) => val!.isEmpty ? 'Enter name' : null,
                      ),
                      const SizedBox(height: 16),

                      // Email
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Email"),
                        validator: (val) => val!.isEmpty ? 'Enter email' : null,
                      ),
                      const SizedBox(height: 16),

                      // Phone
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,         // Only digits
                          LengthLimitingTextInputFormatter(10),           // Max 10 digits
                        ],
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Phone Number"),
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'Enter phone number';
                          if (!RegExp(r'^\d{10}$').hasMatch(val)) return 'Phone number must be 10 digits';
                          return null;
                        },
                      ),

                      // TextFormField(
                      //   controller: _phoneController,
                      //   keyboardType: TextInputType.phone,
                      //   style: const TextStyle(color: Colors.white),
                      //   decoration: _inputDecoration("Phone Number"),
                      //   validator: (val) {
                      //     if (val == null || val.isEmpty) return 'Enter phone number';
                      //     if (!RegExp(r'^\d{10}$').hasMatch(val)) return 'Phone number must be 10 digits';
                      //     return null;
                      //   },
                      // ),
                      const SizedBox(height: 16),

                      // Father's Name
                      TextFormField(
                        controller: _fatherNameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Father's Name"),
                        validator: (val) => val!.isEmpty ? 'Enter father\'s name' : null,
                      ),
                      const SizedBox(height: 16),

                      // Gender
                      DropdownButtonFormField<String>(
                        value: _gender,
                        items: ['Male', 'Female', 'Other']
                            .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                            .toList(),
                        onChanged: (value) => setState(() => _gender = value),
                        dropdownColor: Colors.grey[900],
                        decoration: _inputDecoration("Select Gender"),
                        validator: (val) => val == null ? 'Please select gender' : null,
                      ),
                      const SizedBox(height: 16),

                      // Address
                      TextFormField(
                        controller: _addressController,
                        maxLines: 2,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Address"),
                        validator: (val) => val!.isEmpty ? 'Enter address' : null,
                      ),
                      const SizedBox(height: 16),

                      // Terms
                      CheckboxListTile(
                        value: _termsAccepted,
                        onChanged: (val) => setState(() => _termsAccepted = val!),
                        title: const Text("I agree to the Terms & Conditions",
                            style: TextStyle(color: Colors.white)),
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Gradient Button
            // Gradient Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: (_userFound && _termsAccepted)
                      ? const LinearGradient(
                    colors: [Colors.blueAccent, Colors.pinkAccent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                      : const LinearGradient(
                    colors: [Colors.grey, Colors.grey],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: (_userFound && _termsAccepted)
                      ? () {
                    if (_formKey.currentState!.validate()) {
                      _registerMember();
                    }
                  }
                      : null,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      "Register Member",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            //   child: Ink(
            //     decoration: BoxDecoration(
            //       gradient: const LinearGradient(
            //         colors: [Colors.blueAccent, Colors.pinkAccent],
            //         begin: Alignment.centerLeft,
            //         end: Alignment.centerRight,
            //       ),
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: InkWell(
            //       onTap: (_userFound && _termsAccepted)
            //           ? () {
            //         if (_formKey.currentState!.validate()) {
            //           _registerMember();
            //         }
            //       }
            //           : null,
            //
            //       borderRadius: BorderRadius.circular(12),
            //       child: Container(
            //         height: 50,
            //         alignment: Alignment.center,
            //         child: Text(
            //           "Register Member",
            //           style: GoogleFonts.roboto(
            //             color: Colors.white,
            //             fontWeight: FontWeight.bold,
            //             fontSize: 16,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
