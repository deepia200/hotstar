import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:io';
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
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();

  File? _documentImage;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false);

    _phoneController.text = user.phone ?? '';
    _streetController.text = user.address?['street'] ?? '';
    _cityController.text = user.address?['city'] ?? '';
    _stateController.text = user.address?['state'] ?? '';
    _zipController.text = user.address?['zip'] ?? '';
  }

  Future<void> _pickDocument() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _documentImage = File(picked.path);
      });

      // Save to AuthProvider
      final user = Provider.of<AuthProvider>(context, listen: false);
      user.setDocumentImage(picked.path);
    }
  }


  void _submit() {
    if (_formKey.currentState!.validate()) {
      final user = Provider.of<AuthProvider>(context, listen: false);

      if (user.phone == null || user.phone!.isEmpty) {
        user.setPhone(_phoneController.text);
      }

      if (user.address == null || user.address!.values.any((v) => v.isEmpty)) {
        user.setAddress({
          'street': _streetController.text,
          'city': _cityController.text,
          'state': _stateController.text,
          'zip': _zipController.text,
        });
      }

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
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: TextStyle(color: isEditable ? Colors.white : Colors.grey[400]),
        readOnly: !isEditable,
        controller: controller,
        keyboardType: keyboardType,
        validator: isEditable ? validator : (_) => null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: isEditable ? Colors.white70 : Colors.grey[400]),
          filled: true,
          fillColor: isEditable ? Colors.transparent : Colors.grey[900],
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: isEditable ? Colors.white30 : Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
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
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(left: 100),
          child: Text(
            'KYC Details',
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Complete your KYC details',
                style: GoogleFonts.roboto(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 16),

              // Display name and email
              Text(
                'Name: ${user.name ?? 'N/A'}',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Email: ${user.email ?? 'N/A'}',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              _buildField(
                label: 'Phone Number',
                controller: _phoneController,
                isEditable: user.phone == null || user.phone!.isEmpty,
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter phone number' : null,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 16),
              Text(
                'Address',
                style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
              ),

              _buildField(
                label: 'Street',
                controller: _streetController,
                isEditable: user.address?['street'] == null || user.address!['street']!.isEmpty,
                validator: (val) =>
                val == null || val.isEmpty ? 'Enter street' : null,
              ),
              _buildField(
                label: 'City',
                controller: _cityController,
                isEditable: user.address?['city'] == null || user.address!['city']!.isEmpty,
                validator: (val) =>
                val == null || val.isEmpty ? 'Enter city' : null,
              ),
              _buildField(
                label: 'State',
                controller: _stateController,
                isEditable: user.address?['state'] == null || user.address!['state']!.isEmpty,
                validator: (val) =>
                val == null || val.isEmpty ? 'Enter state' : null,
              ),
              _buildField(
                label: 'Zip Code',
                controller: _zipController,
                isEditable: user.address?['zip'] == null || user.address!['zip']!.isEmpty,
                validator: (val) =>
                val == null || val.isEmpty ? 'Enter zip code' : null,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 20),
              Text(
                'Please upload a government-issued ID ',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickDocument,
                    child: Text(
                      'Upload Document',
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _documentImage != null
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Text(
                    'No document selected',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              if (_documentImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    height: 120,
                    child: Image.file(_documentImage!),
                  ),
                ),

              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  child: const Text('Submit KYC'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
