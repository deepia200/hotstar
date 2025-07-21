// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class UpdateMobileNumberScreen extends StatefulWidget {
//   const UpdateMobileNumberScreen({super.key});
//
//   @override
//   _UpdateMobileNumberScreenState createState() => _UpdateMobileNumberScreenState();
// }
//
// class _UpdateMobileNumberScreenState extends State<UpdateMobileNumberScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _mobileController = TextEditingController();
//
//   String? _validateMobileNumber(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your mobile number';
//     } else if (value.length != 10) {
//       return 'Mobile number should be 10 digits';
//     }
//     return null;
//   }
//
//   void _updateMobileNumber() {
//     if (_formKey.currentState?.validate() ?? false) {
//       final newMobileNumber = _mobileController.text;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Mobile number updated to $newMobileNumber')),
//       );
//       Navigator.pop(context);
//     }
//   }
//
//   InputDecoration _inputDecoration(String hint) {
//     return InputDecoration(
//       filled: true,
//       fillColor: Colors.grey[850],
//       hintText: hint,
//       hintStyle: const TextStyle(color: Colors.grey),
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
//             'Update Mobile Number',
//             style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           backgroundColor: Colors.black,
//           centerTitle: true,
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(24),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         controller: _mobileController,
//                         style: const TextStyle(color: Colors.white),
//                         keyboardType: TextInputType.phone,
//                         inputFormatters: [
//                           LengthLimitingTextInputFormatter(10),
//                           FilteringTextInputFormatter.digitsOnly,
//                         ],
//                         decoration: _inputDecoration('Mobile Number'),
//                         validator: _validateMobileNumber,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               width: double.infinity,
//               height: 50,
//               margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Color(0xFF2196F3), Color(0xFFE91E63)],
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: ElevatedButton(
//                 onPressed: _updateMobileNumber,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.transparent,
//                   shadowColor: Colors.transparent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: Text(
//                   'Update Mobile Number',
//                   style: GoogleFonts.roboto(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20,)
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/auth_provider.dart';

class UpdateMobileNumberScreen extends StatefulWidget {
  const UpdateMobileNumberScreen({super.key});

  @override
  _UpdateMobileNumberScreenState createState() => _UpdateMobileNumberScreenState();
}

class _UpdateMobileNumberScreenState extends State<UpdateMobileNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPhoneController = TextEditingController();
  final TextEditingController _newPhoneController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserPhone();
  }

  Future<void> _loadUserPhone() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('id');

    if (userId != null) {
      await authProvider.fetchUserDetailsById(userId);
    }

    setState(() {
      _currentPhoneController.text = authProvider.phone ?? '';
      isLoading = false;
    });
  }

  String? _validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter mobile number';
    } else if (value.length != 10) {
      return 'Mobile number should be 10 digits';
    }
    return null;
  }

  void _updateMobileNumber() async {
    if (_formKey.currentState?.validate() ?? false) {
      final currentPhone = _currentPhoneController.text.trim();
      final newPhone = _newPhoneController.text.trim();
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      setState(() {
        isLoading = true;
      });

      final error = await authProvider.updatePhoneNumber(newPhone);

      setState(() {
        isLoading = false;
      });

      if (error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mobile number updated successfully')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    }
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[850],
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'Update Mobile Number',
            style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Current Phone Number", style:  GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _currentPhoneController,
                        enabled: false,
                        style:  GoogleFonts.roboto(color: Colors.white),
                        decoration: _inputDecoration('Current Phone'),
                      ),
                      const SizedBox(height: 24),
                     Text("New Phone Number", style:  GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _newPhoneController,
                        style:  GoogleFonts.roboto(color: Colors.white),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: _inputDecoration('Enter New Phone Number'),
                        validator: _validateMobileNumber,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFFE91E63)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                onPressed: _updateMobileNumber,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Update Mobile Number',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
