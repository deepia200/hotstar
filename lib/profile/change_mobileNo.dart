import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateMobileNumberScreen extends StatefulWidget {
  const UpdateMobileNumberScreen({super.key});

  @override
  _UpdateMobileNumberScreenState createState() => _UpdateMobileNumberScreenState();
}

class _UpdateMobileNumberScreenState extends State<UpdateMobileNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileController = TextEditingController();

  // Validation for mobile number
  String? _validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    } else if (value.length != 10) {
      return 'Mobile number should be 10 digits';
    }
    return null;
  }

  // Method to update mobile number
  void _updateMobileNumber() {
    if (_formKey.currentState?.validate() ?? false) {
      // Perform the update operation (e.g., call an API, save locally)
      final newMobileNumber = _mobileController.text;
      // Show a success message and go back to previous screen (or update state accordingly)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mobile number updated to $newMobileNumber')),
      );
      Navigator.pop(context); // Go back to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Update Mobile Number', style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _mobileController,
                    decoration:  InputDecoration(
                      labelText: 'Mobile Number',
                      labelStyle: GoogleFonts.roboto(color: Colors.white),
                      hintText: 'Enter your mobile number',
                      hintStyle: GoogleFonts.roboto(color: Colors.white54),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.phone,
                    validator: _validateMobileNumber,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _updateMobileNumber,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
                    child:  Text('Update Mobile Number', style: GoogleFonts.roboto(fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
