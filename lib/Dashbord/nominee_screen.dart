
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Drawer/nomineedetails_screen.dart';
import '../screens/Dashboard_screen.dart';
import '../service/api_methods.dart';

class NomineeScreen extends StatefulWidget {
  const NomineeScreen({super.key});

  @override
  State<NomineeScreen> createState() => _NomineeScreenState();
}

class _NomineeScreenState extends State<NomineeScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  String? _relation;

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_checkFormValidity);
    _ageController.addListener(_checkFormValidity);
    _aadharController.addListener(_checkFormValidity);
    _panController.addListener(_checkFormValidity);
    _mobileController.addListener(_checkFormValidity);
  }

  void _checkFormValidity() {
    final isValid = _nameController.text.trim().isNotEmpty &&
        _relation != null &&
        _ageController.text.trim().isNotEmpty &&
        _aadharController.text.trim().length == 12 &&
        _panController.text.trim().length == 10 &&
        _mobileController.text.trim().length == 10;

    if (_isFormValid != isValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.grey[850],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  void _submitNomineeDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id');

    if (id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User ID not found")),
      );
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      final data = {
        "nominee_name": _nameController.text.trim(),
        "relation": _relation ?? '',
        "age": int.parse(_ageController.text.trim()),
        "aadhar_number": _aadharController.text.trim(),
        "pan_number": _panController.text.trim(),
        "mobile_number": _mobileController.text.trim(),
      };

      try {
        final response = await ApiMethods.updateNomineeDetails(id, data);
        final String status = response['status'] ?? '';
        final String message = response['message'] ?? 'Something went wrong';

        if (status == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => NomineeDetailsScreen(nomineeData: data)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Nominee Details",
            style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Nominee Name"),
                        validator: (val) => val!.isEmpty ? 'Enter name' : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _relation,
                        items: [
                          'Mother',
                          'Father',
                          'Sister',
                          'Brother',
                          'Wife',
                          'Daughter',
                          'Son',
                          'Grandfather',
                          'Grandmother'
                        ]
                            .map((relation) => DropdownMenuItem(
                          value: relation,
                          child: Text(relation),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() => _relation = value);
                          _checkFormValidity();
                        },
                        dropdownColor: Colors.grey[900],
                        decoration: _inputDecoration("Relation"),
                        validator: (val) => val == null ? 'Please select relation' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _ageController,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: _inputDecoration("Age"),
                        validator: (val) => val!.isEmpty ? 'Enter age' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _aadharController,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(12),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: _inputDecoration("Aadhar Number"),
                        validator: (val) => val!.length != 12 ? 'Enter valid Aadhar (12 digits)' : null,
                      ),
                      const SizedBox(height: 16),
                      // TextFormField(
                      //   controller: _panController,
                      //   style: const TextStyle(color: Colors.white),
                      //   inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      //   decoration: _inputDecoration("PAN Number"),
                      //   validator: (val) => val!.length != 10 ? 'Enter valid PAN' : null,
                      // ),
                      TextFormField(
                        controller: _panController,
                        style: const TextStyle(color: Colors.white),
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        onChanged: (val) {
                          _panController.value = TextEditingValue(
                            text: val.toUpperCase(),
                            selection: _panController.selection,
                          );
                          _checkFormValidity();
                        },
                        decoration: _inputDecoration("PAN Number"),
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'Enter PAN number';
                          final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
                          if (!panRegex.hasMatch(val.toUpperCase())) {
                            return 'Enter valid PAN Number';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _mobileController,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: _inputDecoration("Mobile Number"),
                        validator: (val) => val!.length != 10 ? 'Enter valid mobile number' : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: _isFormValid
                      ? const LinearGradient(
                    colors: [Color(0xFF2196F3), Color(0xFFE91E63)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                      : const LinearGradient(
                    colors: [Colors.grey, Colors.grey],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: _isFormValid ? _submitNomineeDetails : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
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
