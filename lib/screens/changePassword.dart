// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});
//
//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }
//
// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   final TextEditingController _oldPasswordController = TextEditingController();
//   final TextEditingController _newPasswordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isOldPasswordVisible = false;
//   bool _isNewPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;
//
//   void _submit() {
//     if (_formKey.currentState!.validate()) {
//       // TODO: Implement password change logic here
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Password changed successfully')),
//       );
//       Navigator.pop(context);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text(
//           'Change Password',
//           style: GoogleFonts.roboto(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             children: [
//               // Text fields at the top
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 20),
//                         TextFormField(
//                           controller: _oldPasswordController,
//                           obscureText: !_isOldPasswordVisible,
//                           style:GoogleFonts.roboto(color: Colors.white),
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.grey[850],
//                             hintText: 'Old Password',
//                             hintStyle: GoogleFonts.roboto(color: Colors.grey),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide.none,
//                             ),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _isOldPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                                 color: Colors.white,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _isOldPasswordVisible = !_isOldPasswordVisible;
//                                 });
//                               },
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your old password';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 16),
//                         TextFormField(
//                           controller: _newPasswordController,
//                           obscureText: !_isNewPasswordVisible,
//                           style: GoogleFonts.roboto(color: Colors.white),
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.grey[850],
//                             hintText: 'New Password',
//                             hintStyle: GoogleFonts.roboto(color: Colors.grey),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide.none,
//                             ),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                                 color: Colors.white,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _isNewPasswordVisible = !_isNewPasswordVisible;
//                                 });
//                               },
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter a new password';
//                             }
//                             if (value.length < 6) {
//                               return 'Password must be at least 6 characters';
//                             }
//                             if (value == _oldPasswordController.text) {
//                               return 'New password must be different from old password';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 16),
//                         TextFormField(
//                           controller: _confirmPasswordController,
//                           obscureText: !_isConfirmPasswordVisible,
//                           style: GoogleFonts.roboto(color: Colors.white),
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.grey[850],
//                             hintText: 'Confirm New Password',
//                             hintStyle: GoogleFonts.roboto(color: Colors.grey),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide.none,
//                             ),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                                 color: Colors.white,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
//                                 });
//                               },
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value != _newPasswordController.text) {
//                               return 'Passwords do not match';
//                             }
//                             return null;
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//
//               // Button at the bottom
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 30),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFF2196F3), Color(0xFFE91E63)],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//                         shadowColor: Colors.transparent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       onPressed: _submit,
//                       child:  Text(
//                         'Change Password',
//                         style: GoogleFonts.roboto(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../provider/auth_provider.dart';
import '../service/api_methods.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool _isLoading = false;

  // Future<void> _submit() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() => _isLoading = true);
  //
  //     final prefs = await SharedPreferences.getInstance();
  //     final userId = prefs.getString('user_id');
  //
  //     if (userId == null) {
  //       setState(() => _isLoading = false);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('User ID not found')),
  //       );
  //       return;
  //     }
  //
  //     final url = Uri.parse('https://stag.aanandi.in/mlm_ott/my-api/public/api/update-password/$userId');
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({
  //         "current_password": _oldPasswordController.text.trim(),
  //         "update_password": _newPasswordController.text.trim(),
  //         "confirm_password": _confirmPasswordController.text.trim(),
  //       }),
  //     );
  //
  //     setState(() => _isLoading = false);
  //     final data = jsonDecode(response.body);
  //
  //     if (data['status'] == 'success') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(data['message'] ?? 'Password updated successfully')),
  //       );
  //       Navigator.pop(context);
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(data['message'] ?? 'Failed to update password')),
  //       );
  //     }
  //   }
  // }




  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.id;

      if (userId == null || userId.isEmpty) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User ID not found')),
        );
        return;
      }

      final data = await ApiMethods.updatePassword(
        userId: userId,
        currentPassword: _oldPasswordController.text.trim(),
        newPassword: _newPasswordController.text.trim(),
        confirmPassword: _confirmPasswordController.text.trim(),
      );

      setState(() => _isLoading = false);

      if (data['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Password updated successfully')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Failed to update password')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Change Password',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildPasswordField(
                          controller: _oldPasswordController,
                          hint: 'Old Password',
                          isVisible: _isOldPasswordVisible,
                          toggleVisibility: () => setState(() => _isOldPasswordVisible = !_isOldPasswordVisible),
                          validatorMsg: 'Please enter your old password',
                        ),
                        const SizedBox(height: 16),
                        _buildPasswordField(
                          controller: _newPasswordController,
                          hint: 'New Password',
                          isVisible: _isNewPasswordVisible,
                          toggleVisibility: () => setState(() => _isNewPasswordVisible = !_isNewPasswordVisible),
                          validatorMsg: 'Please enter a new password',
                          extraValidation: (val) {
                            if (val == _oldPasswordController.text) {
                              return 'New password must be different from old password';
                            }

                            final hasUppercase = RegExp(r'[A-Z]').hasMatch(val);
                            final hasSpecialChar = RegExp(r'[!@#\$&*~]').hasMatch(val);
                            final isValidCharacters = RegExp(r'^[a-zA-Z0-9!@#\$&*~]+$').hasMatch(val);

                            if (val.length > 8) {
                              return 'Password must not exceed 8 characters';
                            }

                            if (val.length < 6) {
                              return 'Password must be at least 6 characters';
                            }

                            if (!hasUppercase || !hasSpecialChar || !isValidCharacters) {
                              return 'Password must include 1 uppercase, 1 special character, and only valid characters (!@#\$&*~)';
                            }

                            return null;
                          },


                        ),
                        const SizedBox(height: 16),
                        _buildPasswordField(
                          controller: _confirmPasswordController,
                          hint: 'Confirm New Password',
                          isVisible: _isConfirmPasswordVisible,
                          toggleVisibility: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                          validatorMsg: 'Confirm your password',
                          extraValidation: (val) {
                            if (val != _newPasswordController.text) return 'Passwords do not match';
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator(color: Colors.white))
                      : Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2196F3), Color(0xFFE91E63)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _submit,
                      child: Text(
                        'Change Password',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool isVisible,
    required VoidCallback toggleVisibility,
    required String validatorMsg,
    String? Function(String)? extraValidation,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      style: GoogleFonts.roboto(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[850],
        hintText: hint,
        hintStyle: GoogleFonts.roboto(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
          onPressed: toggleVisibility,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return validatorMsg;
        if (extraValidation != null) return extraValidation(value);
        return null;
      },
    );
  }
}
