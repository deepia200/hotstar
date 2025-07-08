// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import '../provider/auth_provider.dart';
//
// class MyKycScreen extends StatelessWidget {
//   const MyKycScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<AuthProvider>(context);
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text(
//           "My KYC",
//           style: GoogleFonts.roboto(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _sectionTitle("KYC Details"),
//             const SizedBox(height: 12),
//             _buildInfoCard("Name", user.name ?? 'N/A', isVerified: true),
//             _buildInfoCard("Email", user.email ?? 'N/A', isVerified: true), // Marked verified
//             _buildInfoCard("Phone", user.phone ?? 'N/A', isVerified: true), // Marked verified
//
//             _sectionTitle("Address"),
//             const SizedBox(height: 12),
//             _buildInfoCard("Full Address", user.fullAddress ?? 'N/A',isVerified: true),
//             _buildInfoCard("City", user.address?['city'] ?? 'N/A',isVerified: true),
//             _buildInfoCard("State", user.address?['state'] ?? 'N/A', isVerified: true),
//             _buildInfoCard("Zip Code", user.address?['zip'] ?? 'N/A', isVerified: true),
//             _buildInfoCard("Country", user.address?['country'] ?? 'N/A',isVerified: true),
//
//             const SizedBox(height: 24),
//             _sectionTitle("Uploaded Documents"),
//             const SizedBox(height: 12),
//
//             _buildDocumentSection(
//               label: 'Aadhaar Card',
//               imagePath: user.aadhaarImagePath,
//             ),
//
//             const SizedBox(height: 16),
//             _buildDocumentSection(
//               label: 'Other Document (PAN/DL)',
//               imagePath: user.otherDocumentImagePath,
//             ),
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Section title widget
//   Widget _sectionTitle(String title) {
//     return Text(
//       title,
//       style: GoogleFonts.roboto(
//         color: Colors.white,
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
//
//   // Info card with optional verified icon
//   Widget _buildInfoCard(String label, String value, {bool isVerified = false}) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey[700]!),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "$label: ",
//             style: GoogleFonts.roboto(
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: GoogleFonts.roboto(color: Colors.white),
//             ),
//           ),
//           if (isVerified)
//             const Icon(Icons.verified, color: Colors.greenAccent, size: 20),
//         ],
//       ),
//     );
//   }
//
//   // Document display section
//   Widget _buildDocumentSection({
//     required String label,
//     required String? imagePath,
//   }) {
//     return Container(
//       height: 180,
//       width: MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width,
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[700]!),
//       ),
//       child: imagePath != null && imagePath.isNotEmpty
//           ? ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: Image.file(
//           File(imagePath),
//           fit: BoxFit.cover,
//         ),
//       )
//           : Center(
//         child: Text(
//           "$label not uploaded",
//           style: GoogleFonts.roboto(color: Colors.grey),
//         ),
//       ),
//     );
//   }
// }
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import '../provider/auth_provider.dart';
// import '../service/api_service.dart';
//
// class MyKycScreen extends StatefulWidget {
//   const MyKycScreen({super.key});
//
//   @override
//   State<MyKycScreen> createState() => _MyKycScreenState();
// }
//
// class _MyKycScreenState extends State<MyKycScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch user details when the screen loads
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     if (	authProvider.id != null) {
//       // Assuming username is in format "RLID00014" where 14 is the ID
//       final userId = 	authProvider.id?.replaceAll('RLID', '') ?? '';
//       authProvider.fetchUserDetailsById(userId);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<AuthProvider>(context);
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           backgroundColor: Colors.black,
//           title: Text(
//             "My KYC",
//             style: GoogleFonts.roboto(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _sectionTitle("Personal Information"),
//               const SizedBox(height: 12),
//               _buildInfoCard("Name", user.fname ?? 'N/A', isVerified: user.isKycVerified),
//               _buildInfoCard("Email", user.email ?? 'N/A', isVerified: user.isKycVerified),
//               _buildInfoCard("Phone", user.phone ?? 'N/A', isVerified: user.isKycVerified),
//               // _buildInfoCard("Date of Birth", user.birthdate ?? 'N/A', isVerified: user.isKycVerified),
//
//               _sectionTitle("Address Information"),
//               const SizedBox(height: 12),
//               _buildInfoCard("Full Address", user.fullAddress ?? 'N/A', isVerified: user.isKycVerified),
//               _buildInfoCard("City", user.address?['city'] ?? 'N/A', isVerified: user.isKycVerified),
//               _buildInfoCard("State", user.address?['state'] ?? 'N/A', isVerified: user.isKycVerified),
//               _buildInfoCard("Pincode", user.address?['zip'] ?? 'N/A', isVerified: user.isKycVerified),
//               _buildInfoCard("Country", user.country ?? 'N/A', isVerified: user.isKycVerified),
//
//               const SizedBox(height: 24),
//               _sectionTitle("Uploaded Documents"),
//               const SizedBox(height: 12),
//
//               _buildDocumentSection(
//                 label: 'Aadhaar Card',
//                 imagePath: user.aadhaarImagePath,
//                 isVerified: user.isKycVerified,
//               ),
//
//               const SizedBox(height: 16),
//               _buildDocumentSection(
//                 label: 'PAN Card',
//                 imagePath: user.otherDocumentImagePath,
//                 isVerified: user.isKycVerified,
//               ),
//
//               const SizedBox(height: 20),
//               _buildKycStatus(user.isKycVerified),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _sectionTitle(String title) {
//     return Text(
//       title,
//       style: GoogleFonts.roboto(
//         color: Colors.white,
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
//
//   Widget _buildInfoCard(String label, String value, {required bool isVerified}) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey[700]!),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "$label: ",
//             style: GoogleFonts.roboto(
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: GoogleFonts.roboto(color: Colors.white),
//             ),
//           ),
//           if (isVerified)
//             const Icon(Icons.verified, color: Colors.greenAccent, size: 20),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDocumentSection({
//     required String label,
//     required String? imagePath,
//     required bool isVerified,
//   }) {
//     final fullImageUrl = ApiService.getImageUrl(imagePath);
//     // print("Aryan");
//     // print('Image URL: $fullImageUrl'); // <--- Add this
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.roboto(
//             color: Colors.white,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           height: 180,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.grey[900],
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: isVerified ? Colors.green : Colors.grey[700]!,
//             ),
//           ),
//           child: fullImageUrl.isNotEmpty
//               ? ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Image.network(
//               fullImageUrl,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return Center(
//                   child: Text(
//                     'Failed to load image',
//                     style: GoogleFonts.roboto(color: Colors.white),
//                   ),
//                 );
//               },
//             ),
//           )
//               : Center(
//             child: Text(
//               "No $label uploaded",
//               style: GoogleFonts.roboto(color: Colors.grey),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildKycStatus(bool isVerified) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: isVerified ? Colors.green.withOpacity(0.2) : Colors.orange.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             isVerified ? Icons.verified : Icons.pending,
//             color: isVerified ? Colors.green : Colors.orange,
//           ),
//           const SizedBox(width: 10),
//           Text(
//             isVerified ? 'KYC Verified' : 'KYC Pending',
//             style: GoogleFonts.roboto(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           SizedBox(height: 20,),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotstar/service/api_methods.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';


class MyKycScreen extends StatefulWidget {
  const MyKycScreen({super.key});

  @override
  State<MyKycScreen> createState() => _MyKycScreenState();
}

class _MyKycScreenState extends State<MyKycScreen> {
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.id != null) {
      authProvider.fetchUserDetailsById(authProvider.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("My KYC", style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Personal Information"),
              _buildInfoCard("Name", user.fname ?? 'N/A'),
              _buildInfoCard("Email", user.email ?? 'N/A'),
              _buildInfoCard("Phone", user.phone ?? 'N/A'),
              _buildInfoCard("PAN", user.pan ?? 'N/A'),

              _sectionTitle("Address Information"),
              _buildInfoCard("Address", user.fullAddress ?? 'N/A'),
              _buildInfoCard("City", user.address?['city'] ?? 'N/A'),
              _buildInfoCard("State", user.address?['state'] ?? 'N/A'),
              _buildInfoCard("Pincode", user.address?['zip'] ?? 'N/A'),
              _buildInfoCard("Country", user.country ?? 'N/A'),

              _sectionTitle("Bank Information"),
              _buildInfoCard("Bank Name", user.bank ?? 'N/A'),
              _buildInfoCard("IFSC", user.ifsc ?? 'N/A'),
              _buildInfoCard("Account No", user.acno ?? 'N/A'),

              _sectionTitle("Uploaded Documents"),
              _buildImageCard("Aadhaar Scan", user.aadhaarImagePath),
              _buildImageCard("PAN Scan", user.otherDocumentImagePath),
              _buildImageCard("Bank Passbook Scan", user.bankScanImagePath),

              const SizedBox(height: 20),
              _buildKycStatus(user.isKycVerified),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: GoogleFonts.roboto(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
          Text("$label: ", style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.w600)),
          Expanded(child: Text(value, style: GoogleFonts.roboto(color: Colors.white))),
        ],
      ),
    );
  }

  Widget _buildImageCard(String label, String? imagePath) {
    final fullImageUrl = "${ApiMethods.imgUrl}$imagePath";
    print("jaya");
    print(fullImageUrl);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[700]!),
          ),
          child: fullImageUrl.isNotEmpty
              ? ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              fullImageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Center(
                child: Text('Failed to load image', style: GoogleFonts.roboto(color: Colors.white)),
              ),
            ),
          )
              : Center(child: Text("No $label uploaded", style: GoogleFonts.roboto(color: Colors.grey))),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildKycStatus(bool isVerified) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isVerified ? Colors.green.withOpacity(0.2) : Colors.orange.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            isVerified ? Icons.verified : Icons.pending,
            color: isVerified ? Colors.green : Colors.orange,
          ),
          const SizedBox(width: 10),
          Text(
            isVerified ? 'KYC Verified' : 'KYC Pending',
            style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
