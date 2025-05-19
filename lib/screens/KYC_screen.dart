import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../bottamnavbar/bottamNav_Bar.dart';
import '../provider/auth_provider.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _fullAddressController = TextEditingController();

  String city = '';
  String state = '';
  String country = 'India';

  File? _aadhaarImage;
  File? _otherDocImage;

  Future<void> _pickImage(String type) async {
    final user = Provider.of<AuthProvider>(context, listen: false);
    if (user.isKycVerified) return;

    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final file = File(picked.path);
      setState(() {
        if (type == 'aadhaar') {
          _aadhaarImage = file;
          user.setAadhaarImage(picked.path);
        } else {
          _otherDocImage = file;
          user.setOtherDocumentImage(picked.path);
        }
      });
    }
  }

  Future<void> _fetchLocationFromZip(String zip) async {
    if (zip.length != 6) return;

    try {
      final url = Uri.parse('https://api.postalpincode.in/pincode/$zip');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data[0]['Status'] == 'Success' && data[0]['PostOffice'] != null) {
          final postOffice = data[0]['PostOffice'][0];
          setState(() {
            city = postOffice['District'] ?? '';
            state = postOffice['State'] ?? '';
            country = postOffice['Country'] ?? 'India';
          });
        } else {
          setState(() {
            city = '';
            state = '';
            country = '';
          });
        }
      }
    } catch (e) {
      setState(() {
        city = '';
        state = '';
        country = '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false);
    _phoneController.text = user.phone ?? '';
    _zipController.text = user.address?['zip'] ?? '';
    _fullAddressController.text = user.fullAddress ?? '';
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final user = Provider.of<AuthProvider>(context, listen: false);
      user.setPhone(_phoneController.text);
      user.setAddress({
        'zip': _zipController.text,
        'city': city,
        'state': state,
        'country': country,
      });
      user.setFullAddress(_fullAddressController.text);
      user.completeKyc();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavBarScreen()),
            (route) => false,
      );
    }
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required bool isEditable,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    Function(String)? onChanged,
    int? maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: TextStyle(
          color: isEditable ? Colors.white : Colors.grey[400],
        ),
        readOnly: !isEditable,
        controller: controller,
        keyboardType: keyboardType,
        validator: isEditable ? validator : (_) => null,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        maxLength: maxLength,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(
            color: isEditable ? Colors.grey : Colors.grey[600],
          ),
          filled: true,
          fillColor: Colors.grey[850],
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildGradientLabel(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
          width: 1.5,
        ),
      ),
      child: Text(
        '$title: $value',
        style: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'KYC Details',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Complete your KYC details',
                    style: GoogleFonts.roboto(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 16),
                Text('Name: ${user.name ?? 'N/A'}',
                    style: GoogleFonts.roboto(color: Colors.white, fontSize: 16)),
                Text('Email: ${user.email ?? 'N/A'}',
                    style: GoogleFonts.roboto(color: Colors.white, fontSize: 16)),
                const SizedBox(height: 20),

                _buildField(
                  label: 'Phone Number',
                  controller: _phoneController,
                  isEditable: user.phone == null || user.phone!.isEmpty,
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Enter phone number' : null,
                  keyboardType: TextInputType.number,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                ),

                _buildField(
                  label: 'Full Address',
                  controller: _fullAddressController,
                  isEditable: true,
                  validator: (v) => v!.isEmpty ? 'Enter full address' : null,
                ),

                _buildField(
                  label: 'Zip Code',
                  controller: _zipController,
                  isEditable: true,
                  validator: (v) => v!.isEmpty ? 'Enter zip code' : null,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  onChanged: (value) {
                    if (value.length == 6) {
                      _fetchLocationFromZip(value);
                    }
                  },
                ),

                if (city.isNotEmpty) _buildGradientLabel('City', city),
                if (state.isNotEmpty) _buildGradientLabel('State', state),
                if (country.isNotEmpty) _buildGradientLabel('Country', country),

                const SizedBox(height: 20),
                Text('Upload Aadhaar Card (mandatory)',
                    style: GoogleFonts.roboto(color: Colors.white, fontSize: 16)),
                if (!user.isKycVerified)
                  ElevatedButton(
                    onPressed: () => _pickImage('aadhaar'),
                    child: const Text('Upload Aadhaar'),
                  ),
                if (_aadhaarImage != null)
                  Image.file(_aadhaarImage!, height: 100),

                const SizedBox(height: 20),
                Text('Upload PAN Card or Driving License (optional)',
                    style: GoogleFonts.roboto(color: Colors.white, fontSize: 16)),
                if (!user.isKycVerified)
                  ElevatedButton(
                    onPressed: () => _pickImage('other'),
                    child: const Text('Upload PAN / DL'),
                  ),
                if (_otherDocImage != null)
                  Image.file(_otherDocImage!, height: 100),

                const SizedBox(height: 30),
                Center(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.blueAccent, Colors.pinkAccent],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Submit KYC',
                          style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
