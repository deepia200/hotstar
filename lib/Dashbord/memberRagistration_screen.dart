// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import '../provider/member_provider.dart';
// import '../models/member_model.dart';
//
// class NewMemberRegistrationScreen extends StatefulWidget {
//   const NewMemberRegistrationScreen({super.key});
//
//   @override
//   _NewMemberRegistrationScreenState createState() => _NewMemberRegistrationScreenState();
// }
//
// class _NewMemberRegistrationScreenState extends State<NewMemberRegistrationScreen> {
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _userIdController = TextEditingController();
//
//   void _registerNewMember() {
//     final name = _nameController.text;
//     final email = _emailController.text;
//     final userId = _userIdController.text;
//
//     if (name.isEmpty || email.isEmpty || userId.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please fill all the fields")),
//       );
//       return;
//     }
//
//     final newMember = Member(name: name, email: email, userId: userId);
//     Provider.of<MemberProvider>(context, listen: false).addMember(newMember);
//     Navigator.pop(context);
//   }
//
//   InputDecoration _inputDecoration(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: const TextStyle(color: Colors.grey),
//       filled: true,
//       fillColor: Colors.grey[850],
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           title: Text(
//             "New Member Registration",
//             style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           backgroundColor: Colors.black,
//           centerTitle: true,
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _nameController,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: _inputDecoration("Name"),
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _emailController,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: _inputDecoration("Email"),
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _userIdController,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: _inputDecoration("User ID"),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               width: double.infinity,
//               height: 50,
//               margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Colors.blueAccent, Colors.pinkAccent],
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: ElevatedButton(
//                 onPressed: _registerNewMember,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.transparent,
//                   shadowColor: Colors.transparent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: Text(
//                   "Register Member",
//                   style: GoogleFonts.roboto(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotstar/service/api_methods.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/member_provider.dart';
import '../models/member_model.dart';
import '../screens/Dashboard_screen.dart';

class NewMemberRegistrationScreen extends StatefulWidget {
  const NewMemberRegistrationScreen({super.key});

  @override
  State<NewMemberRegistrationScreen> createState() => _NewMemberRegistrationScreenState();
}

class _NewMemberRegistrationScreenState extends State<NewMemberRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

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

  // Future<void> _registerMember() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final id =  await prefs.getString('id');
  //   if (!_formKey.currentState!.validate()) return;
  //
  //   final name = _nameController.text.trim();
  //   final email = _emailController.text.trim();
  //   final phone = _phoneController.text.trim();
  //
  //   final currentUserId = 'RLID000009'; // Replace with actual user ID logic
  //
  //   try {
  //     final response = await ApiMethods.registerMember(
  //       name: name,
  //       email: email,
  //       phone: phone,
  //       reff: currentUserId,
  //     );
  //
  //     print("API response: $response");
  //
  //     if (response['status'] == 'success') {
  //       final data = response['data'];
  //       final message = response['message'];
  //
  //       final newMember = Member(
  //         name: name,
  //         email: email,
  //         userId: data['new_user_id'],
  //       );
  //       Provider.of<MemberProvider>(context, listen: false).addMember(newMember);
  //
  //       // Show success dialog
  //       showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           backgroundColor: Colors.grey[900],
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //           title: Text("Success", style: TextStyle(color: Colors.greenAccent, fontSize: 18)),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Text(message, style: const TextStyle(color: Colors.white)),
  //               const SizedBox(height: 10),
  //               Text("User ID: ${data['new_user_id']}", style: const TextStyle(color: Colors.white)),
  //               const SizedBox(height: 5),
  //               Text("Default Password: ${data['default_password']}", style: const TextStyle(color: Colors.white)),
  //             ],
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop(); // close dialog
  //                 Navigator.of(context).pushReplacement(
  //                   MaterialPageRoute(builder: (context) => const DashboardScreen()),
  //                 ); // go to Dashboard screen
  //               },
  //               child: const Text("OK", style: TextStyle(color: Colors.blueAccent)),
  //             ),
  //           ],
  //         ),
  //       );
  //
  //       _nameController.clear();
  //       _emailController.clear();
  //       _phoneController.clear();
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(response['message'] ?? 'Failed to register')),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: $e')),
  //     );
  //   }
  // }
  Future<void> _registerMember() async {
    final prefs = await SharedPreferences.getInstance();
    final id = await prefs.getString('id');

    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();

    if (id == null || id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User ID not found. Please login again.")),
      );
      return;
    }

    final currentUserId = id;

    try {
      final response = await ApiMethods.registerMember(
        name: name,
        email: email,
        phone: phone,
        reff: currentUserId,
      );

      print("API response: $response");

      if (response['status'] == 'success') {
        final data = response['data'];
        final message = response['message'];

        final newMember = Member(
          name: name,
          email: email,
          userId: data['new_user_id'],
        );
        Provider.of<MemberProvider>(context, listen: false).addMember(newMember);

        // ✅ Show success SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message ?? "Registration successful")),
        );

        // ✅ Clear form
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();

        // ✅ Redirect to Dashboard
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
                      TextFormField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Name"),
                        validator: (val) => val!.isEmpty ? 'Enter name' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Email"),
                        validator: (val) => val!.isEmpty ? 'Enter email' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Phone Number"),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter phone number';
                          } else if (!RegExp(r'^\d{10}$').hasMatch(val)) {
                            return 'Phone number must be 10 digits';
                          }
                          return null;
                        },
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blueAccent, Colors.pinkAccent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                onPressed: _registerMember,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
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
          ],
        ),
      ),
    );
  }
}
