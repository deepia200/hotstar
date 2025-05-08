import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';

class MyKycScreen extends StatelessWidget {
  const MyKycScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "My KYC",
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("KYC Details"),
            const SizedBox(height: 12),
            _buildInfoCard("Name", user.name ?? 'N/A'),
            _buildInfoCard("Email", user.email ?? 'N/A'),
            _buildInfoCard("Phone", user.phone ?? 'N/A'),

            const SizedBox(height: 24),
            _sectionTitle("Address"),
            const SizedBox(height: 12),
            _buildInfoCard("Street", user.address?['street'] ?? 'N/A'),
            _buildInfoCard("City", user.address?['city'] ?? 'N/A'),
            _buildInfoCard("State", user.address?['state'] ?? 'N/A'),
            _buildInfoCard("Zip Code", user.address?['zip'] ?? 'N/A'),

            const SizedBox(height: 24),
            _sectionTitle("Uploaded Document"),
            const SizedBox(height: 12),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[700]!),
              ),
              child: user.documentImagePath != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(user.documentImagePath!),
                  fit: BoxFit.cover,
                ),
              )
                  : Center(
                child: Text(
                  "No document uploaded",
                  style: GoogleFonts.roboto(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[700]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.roboto(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
