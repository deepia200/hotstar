// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'dart:math';
//
// import '../provider/auth_provider.dart';
// import 'auth_Screen.dart';
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   bool _isPasswordVisible = false;
//
//   String userType = 'Member';
//
//   String generateId() {
//     final random = Random();
//     return 'ID${random.nextInt(900000) + 100000}';
//   }
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 const SizedBox(height: 30),
//                 const Text(
//                   'Create your account',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Full Name
//                 TextField(
//                   controller: nameController,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.grey[850],
//                     hintText: 'Full Name',
//                     hintStyle: const TextStyle(color: Colors.grey),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Email
//                 TextField(
//                   controller: emailController,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.grey[850],
//                     hintText: 'Email',
//                     hintStyle: const TextStyle(color: Colors.grey),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Phone Number
//                 TextField(
//                   controller: phoneController,
//                   maxLength: 10,
//                   keyboardType: TextInputType.phone,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.grey[850],
//                     hintText: 'Phone Number',
//                     hintStyle: const TextStyle(color: Colors.grey),
//                     counterText: '',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Password
//                 TextField(
//                   controller: passwordController,
//                   obscureText: !_isPasswordVisible,
//                   maxLength: 10,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.grey[850],
//                     hintText: 'Password',
//                     hintStyle: const TextStyle(color: Colors.grey),
//                     counterText: '',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                         color: Colors.grey,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isPasswordVisible = !_isPasswordVisible;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//                 // User Type Dropdown
//                 DropdownButtonFormField<String>(
//                   value: userType,
//                   dropdownColor: Colors.grey[900],
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.grey[850],
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                   style: const TextStyle(color: Colors.white),
//                   items: ['Member', 'Guest'].map((type) {
//                     return DropdownMenuItem(
//                       value: type,
//                       child: Text(type),
//                     );
//                   }).toList(),
//                   onChanged: (val) {
//                     setState(() {
//                       userType = val!;
//                     });
//
//                     showDialog(
//                       context: context,
//                       builder: (_) => AlertDialog(
//                         backgroundColor: Colors.grey[900],
//                         title: Text(
//                           userType == 'Member' ? 'Why sign up as a Member?' : 'Benefits of Guest Signup',
//                           style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
//                         ),
//                         content: Text(
//                           userType == 'Member'
//                               ? 'Members get full access to features, KYC verification, and personalized recommendations.'
//                               : 'Guest signups are quick and easy, with limited access but no KYC needed.',
//                           style: const TextStyle(color: Colors.white70),
//                         ),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             child: const Text('OK', style: TextStyle(color: Colors.white)),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 30),
//
//                 // Sign Up Button
//                 SizedBox(
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
//                       onPressed: () {
//                         final name = nameController.text.trim();
//                         final email = emailController.text.trim();
//                         final phone = phoneController.text.trim();
//                         final password = passwordController.text.trim();
//
//                         if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Please fill in all fields')),
//                           );
//                           return;
//                         }
//
//                         if (phone.length != 10) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Enter a valid 10-digit phone number')),
//                           );
//                           return;
//                         }
//
//                         final distributedId = generateId();
//                         final authProvider = Provider.of<AuthProvider>(context, listen: false);
//
//                         authProvider.setUser(username: distributedId, password: password);
//                         authProvider.setName(name);
//                         authProvider.setEmail(email);
//
//                         showDialog(
//                           context: context,
//                           builder: (_) => AlertDialog(
//                             backgroundColor: Colors.grey[900],
//                             title: const Text(
//                               "Signup Successful",
//                               style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                             ),
//                             content: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("Signed up as: $userType", style: const TextStyle(color: Colors.white)),
//                                 Text("Name: $name", style: const TextStyle(color: Colors.white70)),
//                                 Text("Email: $email", style: const TextStyle(color: Colors.white70)),
//                                 Text("Phone: $phone", style: const TextStyle(color: Colors.white70)),
//                                 Text("Your ID: $distributedId", style: const TextStyle(color: Colors.blueAccent)),
//                               ],
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                   Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (_) => AuthScreen(
//                                         userId: distributedId,
//                                         password: password,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 child: const Text("OK", style: TextStyle(color: Colors.white)),
//                               )
//                             ],
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//                         shadowColor: Colors.transparent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text(
//                         'Sign Up',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Already have an account?",
//                       style: GoogleFonts.roboto(color: Colors.white),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (_) => const AuthScreen()),
//                         );
//                       },
//                       child: Text(
//                         'Log In',
//                         style: GoogleFonts.roboto(color: Colors.blueAccent),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../service/api_methods.dart';
// import '../service/api_service.dart';
// import 'auth_Screen.dart';
//
// class SignupPage extends StatefulWidget {
//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }
//
// class _SignupPageState extends State<SignupPage> {
//   final _formKey = GlobalKey<FormState>();
//
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   final dobController = TextEditingController();
//   bool _isNewPasswordVisible = false;
//   // bool _isConfirmPasswordVisible = false;
//
//
//   String member_type = '1';
//   bool loading = false;
//   String dateOfBirth = '';
//
//   // Future<void> _selectDate(BuildContext context) async {
//   //   DateTime initialDate = DateTime(1995, 1, 1);
//   //   final DateTime? picked = await showDatePicker(
//   //     context: context,
//   //     initialDate: initialDate,
//   //     firstDate: DateTime(1900),
//   //     lastDate: DateTime.now(),
//   //   );
//   //   if (picked != null) {
//   //     setState(() {
//   //       dateOfBirth = picked.toIso8601String().substring(0, 10);
//   //       dobController.text = dateOfBirth;
//   //     });
//   //   }
//   // }
//
//   InputDecoration buildInputDecoration(String hintText) {
//     return InputDecoration(
//       filled: true,
//       fillColor: Colors.grey[850],
//       hintText: hintText,
//       hintStyle: GoogleFonts.roboto(color: Colors.grey),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }
//
//   Future<void> signup() async {
//     final fname = nameController.text.trim();
//     final email = emailController.text.trim();
//     final pass = passwordController.text.trim();
//     final phone = dobController.text.trim(); // using dobController for phone
//
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() => loading = true);
//
//     try {
//       final response = await ApiMethods.signupUser(
//         fname,
//         email,
//         pass,
//         phone, // pass phone number
//         member_type,
//       );
//
//       setState(() => loading = false);
//
//       if (response != null && response['status'] == 'success') {
//         final data = response['data'];
//         String id = data['id'] ?? 'User';
//         String name = data['name'] ?? fname;
//         String message = response['message'] ?? 'Signup successful!';
//
//         // ✅ Save memberType to SharedPreferences
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.setString('memberType', member_type);
//
//         showDialog(
//           context: context,
//           builder: (_) => AlertDialog(
//             backgroundColor: Colors.grey[900],
//             title: const Text(
//               "Signup Successful",
//               style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Signed up as: ${member_type == '0' ? 'Member' : 'Guest'}", style: const TextStyle(color: Colors.white)),
//                 Text("Name: $name", style: const TextStyle(color: Colors.white70)),
//                 Text("Email: $email", style: const TextStyle(color: Colors.white70)),
//                 Text("Your ID: $id", style: const TextStyle(color: Colors.blueAccent)),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => AuthScreen(
//                         username: id,
//                         password: pass,
//                       ),
//                     ),
//                   );
//                 },
//                 child: const Text("OK", style: TextStyle(color: Colors.white)),
//               )
//             ],
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(response?['message'] ?? 'Signup Failed. Please try again.')),
//         );
//       }
//     } catch (e) {
//       setState(() => loading = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: ${e.toString()}')),
//       );
//     }
//   }
//
//
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     dobController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar( title: ShaderMask(
//         shaderCallback:
//             (bounds) => LinearGradient(
//           colors: [Colors.blue, Colors.pink],
//           tileMode: TileMode.mirror,
//         ).createShader(bounds),
//         child: Text(
//           'ReelLife',
//           style: GoogleFonts.roboto(
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//         elevation: 0,),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               const SizedBox(height: 30),
//               Center(
//                 child: Text(
//                   'Create your account',
//                   style: GoogleFonts.roboto(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 32),
//
//               TextFormField(
//                 controller: nameController,
//                 style: GoogleFonts.roboto(color: Colors.white),
//                 decoration: buildInputDecoration('Full Name'),
//                 validator: (val) => val!.isEmpty ? 'Enter full name' : null,
//               ),
//               const SizedBox(height: 16),
//
//               TextFormField(
//                 controller: emailController,
//                 style: GoogleFonts.roboto(color: Colors.white),
//                 decoration: buildInputDecoration('Email'),
//                 validator: (val) => val!.isEmpty || !val.contains('@') ? 'Enter valid email' : null,
//                 keyboardType: TextInputType.emailAddress,
//               ),
//               const SizedBox(height: 16),
//
//               TextFormField(
//                 controller: passwordController,
//                 style: GoogleFonts.roboto(color: Colors.white),
//                 decoration: buildInputDecoration('Password').copyWith(
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isNewPasswordVisible = !_isNewPasswordVisible;
//                       });
//                     },
//                   ),
//                 ),
//                 validator: (val) => val!.length < 6 ? 'Password too short' : null,
//                 obscureText: !_isNewPasswordVisible, // <-- updated
//               ),
//
//               // const SizedBox(height: 16),
//
//               // TextFormField(
//               //   controller: confirmPasswordController,
//               //   style: GoogleFonts.roboto(color: Colors.white),
//               //   decoration: buildInputDecoration('Confirm Password').copyWith(
//               //     suffixIcon: IconButton(
//               //       icon: Icon(
//               //         _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
//               //         color: Colors.white,
//               //       ),
//               //       onPressed: () {
//               //         setState(() {
//               //           _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
//               //         });
//               //       },
//               //     ),
//               //   ),
//               //   validator: (val) => val!.isEmpty ? 'Confirm your password' : null,
//               //   obscureText: !_isConfirmPasswordVisible, // <-- linked to toggle
//               // ),
//
//               const SizedBox(height: 16),
//
//               TextFormField(
//                 controller: dobController,
//                 keyboardType: TextInputType.phone,
//                 maxLength: 10,
//                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                 style: GoogleFonts.roboto(color: Colors.white),
//                 decoration: buildInputDecoration('Phone number').copyWith(
//                   counterText: '', // hides the counter below the field
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your phone number';
//                   } else if (value.length != 10) {
//                     return 'Phone number must be 10 digits';
//                   }
//                   return null;
//                 },
//               ),
//
//
//               const SizedBox(height: 16),
//
//               DropdownButtonFormField<String>(
//                 dropdownColor: Colors.grey[900],
//                 value: member_type,
//                 items: [
//                   DropdownMenuItem(value: '0', child: Text('Member', style: TextStyle(color: Colors.white))),
//                   DropdownMenuItem(value: '1', child: Text('Guest', style: TextStyle(color: Colors.white))),
//                 ],
//                 onChanged: (val) {
//                   setState(() => member_type = val!);
//
//                   showDialog(
//                     context: context,
//                     builder: (_) => AlertDialog(
//                       backgroundColor: Colors.grey[900],
//                       title: Text(
//                         member_type == '0' ? 'Why sign up as a Member?' : 'Benefits of Guest Signup',
//                         style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
//                       ),
//                       content: Text(
//                         member_type == '0'
//                             ? 'Members get full access to features, KYC verification, and personalized recommendations.'
//                             : 'Guest signups are quick and easy, with limited access but no KYC needed.',
//                         style: const TextStyle(color: Colors.white70),
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: const Text('OK', style: TextStyle(color: Colors.white)),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 decoration: buildInputDecoration('Member Type'),
//                 validator: (val) => val == null || val.isEmpty ? 'Select member type' : null,
//               ),
//               const SizedBox(height: 24),
//
//               loading
//                   ? const Center(child: CircularProgressIndicator())
//                   : Container(
//                 height: 50,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   gradient: const LinearGradient(colors: [Colors.blue, Colors.pink]),
//                 ),
//                 child: ElevatedButton(
//                   onPressed: signup,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.transparent,
//                     shadowColor: Colors.transparent,
//                   ),
//                   child: Text(
//                     'Signup',
//                     style: GoogleFonts.roboto(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
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

// imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/api_methods.dart';
import '../service/api_service.dart'; // or api_methods.dart
import 'auth_Screen.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  bool _isPasswordVisible = false;
  // String member_type = '0'; // default = Member
  bool loading = false;

  InputDecoration buildInputDecoration(String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[850],
      hintText: hintText,
      hintStyle: GoogleFonts.roboto(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  Future<void> signup() async {
    if (!_formKey.currentState!.validate()) return;

    final fname = nameController.text.trim();
    final email = emailController.text.trim();
    final pass = passwordController.text.trim();
    final phone = phoneController.text.trim();

    setState(() => loading = true);

    final response = await ApiMethods.signupUser(
      fname,
      email,
      pass,
      phone,
      // member_type,
    );

    setState(() => loading = false);

    if (response != null && response['status'] == 'success') {
      final data = response['data'];
      final id = data['id'];
      final name = data['name'];
      // final mtype = data['member_type'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('memberType', member_type);

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text("Signup Successful", style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: $name", style: TextStyle(color: Colors.white)),
              Text("Email: $email", style: TextStyle(color: Colors.white70)),
              Text("Your ID: $id", style: TextStyle(color: Colors.blueAccent)),
              // Text("Signed up as: ${member_type == '0' ? 'Member' : 'Guest'}",
              //     style: TextStyle(color: Colors.white70)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AuthScreen(username: id, password: pass),
                  ),
                );
              },
              child: const Text("OK", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      );
    } else {
      final message = response?['message'] ?? 'Signup failed. Try again.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        // title: // Important to apply gradient to image
        // Image.asset(
        //   'assets/images/logo.png', // Make sure this is added in pubspec.yaml
        //   height: 50,
        //   fit: BoxFit.contain,
        // ),

        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.blue, Colors.pink],
          ).createShader(bounds),
          child: Text(
            'ReelLife',
            style: GoogleFonts.roboto(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Create your account',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Name
              TextFormField(
                controller: nameController,
                style: GoogleFonts.roboto(color: Colors.white),
                decoration: buildInputDecoration('Full Name'),
                validator: (val) => val!.isEmpty ? 'Enter full name' : null,
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: emailController,
                style: GoogleFonts.roboto(color: Colors.white),
                decoration: buildInputDecoration('Email'),
                validator: (val) => val!.isEmpty || !val.contains('@')
                    ? 'Enter valid email'
                    : null,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: passwordController,
                style: GoogleFonts.roboto(color: Colors.white),
                decoration: buildInputDecoration('Password').copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() => _isPasswordVisible = !_isPasswordVisible);
                    },
                  ),
                ),
                validator: (val) =>
                val!.length < 6 ? 'Password too short' : null,
                obscureText: !_isPasswordVisible,
              ),
              const SizedBox(height: 16),

              // Phone Number
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: GoogleFonts.roboto(color: Colors.white),
                decoration: buildInputDecoration('Phone number').copyWith(
                  counterText: '',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter phone number';
                  if (value.length != 10) return 'Must be 10 digits';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Member Type Dropdown
             //  DropdownButtonFormField<String>(
             //    dropdownColor: Colors.grey[900],
             //    value: member_type,
             //    decoration: buildInputDecoration('Member Type'),
             //    items: [
             //      DropdownMenuItem(
             //        value: '0',
             //        child: Text('Member', style: TextStyle(color: Colors.white)),
             //      ),
             //      DropdownMenuItem(
             //        value: '1',
             //        child: Text('Guest', style: TextStyle(color: Colors.white)),
             //      ),
             //    ],
             // onChanged: (val) {
             //      setState(() => member_type = val!);
             //
             //      showDialog(
             //        context: context,
             //        builder: (_) => AlertDialog(
             //          backgroundColor: Colors.grey[900],
             //          title: Text(
             //            member_type == '0' ? 'Why sign up as a Member?' : 'Benefits of Guest Signup',
             //            style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
             //          ),
             //          content: Text(
             //            member_type == '0'
             //                ? 'Members get full access to features, KYC verification, and personalized recommendations.'
             //                : 'Guest signups are quick and easy, with limited access but no KYC needed.',
             //            style: const TextStyle(color: Colors.white70),
             //          ),
             //          actions: [
             //            TextButton(
             //              onPressed: () => Navigator.pop(context),
             //              child: const Text('OK', style: TextStyle(color: Colors.white)),
             //            ),
             //          ],
             //        ),
             //      );
             //    },
             //  ),

              const SizedBox(height: 24),

              // Signup Button
              loading
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(colors: [Colors.blue, Colors.pink]),
                ),
                child: ElevatedButton(
                  onPressed: signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    'Signup',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
}
