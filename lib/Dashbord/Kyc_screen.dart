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
            _buildInfoCard("Name", user.name ?? 'N/A', isVerified: true),
            _buildInfoCard("Email", user.email ?? 'N/A', isVerified: true), // Marked verified
            _buildInfoCard("Phone", user.phone ?? 'N/A', isVerified: true), // Marked verified

            _sectionTitle("Address"),
            const SizedBox(height: 12),
            _buildInfoCard("Full Address", user.fullAddress ?? 'N/A',isVerified: true),
            _buildInfoCard("City", user.address?['city'] ?? 'N/A',isVerified: true),
            _buildInfoCard("State", user.address?['state'] ?? 'N/A', isVerified: true),
            _buildInfoCard("Zip Code", user.address?['zip'] ?? 'N/A', isVerified: true),
            _buildInfoCard("Country", user.address?['country'] ?? 'N/A',isVerified: true),

            const SizedBox(height: 24),
            _sectionTitle("Uploaded Documents"),
            const SizedBox(height: 12),

            _buildDocumentSection(
              label: 'Aadhaar Card',
              imagePath: user.aadhaarImagePath,
            ),

            const SizedBox(height: 16),
            _buildDocumentSection(
              label: 'Other Document (PAN/DL)',
              imagePath: user.otherDocumentImagePath,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Section title widget
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

  // Info card with optional verified icon
  Widget _buildInfoCard(String label, String value, {bool isVerified = false}) {
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
          if (isVerified)
            const Icon(Icons.verified, color: Colors.greenAccent, size: 20),
        ],
      ),
    );
  }

  // Document display section
  Widget _buildDocumentSection({
    required String label,
    required String? imagePath,
  }) {
    return Container(
      height: 180,
      width: MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[700]!),
      ),
      child: imagePath != null && imagePath.isNotEmpty
          ? ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
        ),
      )
          : Center(
        child: Text(
          "$label not uploaded",
          style: GoogleFonts.roboto(color: Colors.grey),
        ),
      ),
    );
  }
}
