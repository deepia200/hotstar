import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NomineeDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> nomineeData;

  const NomineeDetailsScreen({super.key, required this.nomineeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Nominee Information",
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildReadOnlyField("Name", nomineeData["nominee_name"]),
              _buildReadOnlyField("Relation", nomineeData["relation"]),
              _buildReadOnlyField("Age", nomineeData["age"].toString()),
              _buildReadOnlyField("Aadhar", nomineeData["aadhar_number"]),
              _buildReadOnlyField("PAN", nomineeData["pan_number"]),
              _buildReadOnlyField("Mobile", nomineeData["mobile_number"]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        readOnly: true,
        initialValue: value,
        style: GoogleFonts.roboto(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.roboto(color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[900],
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
