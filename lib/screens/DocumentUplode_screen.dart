// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hotstar/service/api_methods.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
//
// import '../bottamnavbar/bottamNav_Bar.dart';
// import '../provider/auth_provider.dart';
// import '../service/api_service.dart';
//
// class DocumentUploadScreen extends StatefulWidget {
//   const DocumentUploadScreen({super.key});
//
//   @override
//   State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
// }
//
// class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
//   File? _aadhaarImage;
//   File? _panCardImage;
//   File? _bankPassbookImage;
//   bool isUploading = false;
//
//   Future<void> _pickImage(String type) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         switch (type) {
//           case 'aadhaar':
//             _aadhaarImage = File(pickedFile.path);
//             break;
//           case 'pan':
//             _panCardImage = File(pickedFile.path);
//             break;
//           case 'bank':
//             _bankPassbookImage = File(pickedFile.path);
//             break;
//         }
//       });
//     }
//   }
//
//   Widget _buildDocumentUpload(String label, File? image, VoidCallback onPressed) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: GoogleFonts.roboto(color: Colors.white, fontSize: 16)),
//         const SizedBox(height: 8),
//         GestureDetector(
//           onTap: onPressed,
//           child: Container(
//             height: 180,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.white70),
//               borderRadius: BorderRadius.circular(12),
//               color: Colors.grey[900],
//             ),
//             child: image != null
//                 ? ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.file(image, fit: BoxFit.cover),
//             )
//                 : const Center(
//               child: Icon(Icons.upload_rounded, color: Colors.white70, size: 40),
//             ),
//           ),
//         ),
//         const SizedBox(height: 24),
//       ],
//     );
//   }
//
//   Future<void> _submitDocuments(BuildContext context) async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final userId = authProvider.id;
//
//     if (_aadhaarImage == null || _panCardImage == null || _bankPassbookImage == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please upload all documents")),
//       );
//       return;
//     }
//
//     setState(() => isUploading = true);
//
//     final success = await ApiMethods.uploadKycDocuments(
//       userId: userId ?? '',
//       aadhaarFile: _aadhaarImage!,
//       panFile: _panCardImage!,
//       bankFile: _bankPassbookImage!,
//     );
//
//     setState(() => isUploading = false);
//
//     if (success) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const BottomNavBarScreen()),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Documents submitted successfully")),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Failed to upload documents")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           title: Text('Upload Documents', style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
//           centerTitle: true,
//           backgroundColor: Colors.black,
//           elevation: 0,
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildDocumentUpload('Aadhaar Card', _aadhaarImage, () => _pickImage('aadhaar')),
//                     _buildDocumentUpload('PAN Card', _panCardImage, () => _pickImage('pan')),
//                     _buildDocumentUpload('Bank Passbook', _bankPassbookImage, () => _pickImage('bank')),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Container(
//                 width: double.infinity,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Colors.blueAccent, Colors.pinkAccent],
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: ElevatedButton(
//                   onPressed: isUploading ? null : () => _submitDocuments(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.transparent,
//                     shadowColor: Colors.transparent,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   ),
//                   child: isUploading
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : Text(
//                     'Submit Documents',
//                     style: GoogleFonts.roboto(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 20,)
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../bottamnavbar/bottamNav_Bar.dart';
import '../provider/auth_provider.dart';
import '../service/api_methods.dart';
import 'Dashboard_screen.dart';

class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({super.key});

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  File? _aadhaarImage;
  File? _panCardImage;
  File? _bankPassbookImage;
  bool isUploading = false;

  // Pick image from camera or gallery
  Future<void> _pickImage(String type, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80); // compress for stability

    if (pickedFile != null) {
      final file = File(pickedFile.path); // works for both camera and gallery

      setState(() {
        switch (type) {
          case 'aadhaar':
            _aadhaarImage = file;
            break;
          case 'pan':
            _panCardImage = file;
            break;
          case 'bank':
            _bankPassbookImage = file;
            break;
        }
      });
    }
  }


  // Show bottom sheet to choose source
  void _showImageSourceActionSheet(BuildContext context, String type) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Container(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(type, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(type, ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build upload container
  Widget _buildDocumentUpload(String label, File? image, VoidCallback onPressed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.roboto(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onPressed,
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white70),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[900],
            ),
            child: image != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(image, fit: BoxFit.cover),
            )
                : const Center(
              child: Icon(Icons.upload_rounded, color: Colors.white70, size: 40),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  // Submit documents to API
  Future<void> _submitDocuments(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.id;

    if (_aadhaarImage == null || _panCardImage == null || _bankPassbookImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload all documents")),
      );
      return;
    }

    setState(() => isUploading = true);

    final success = await ApiMethods.uploadKycDocuments(
      userId: userId ?? '',
      aadhaarFile: _aadhaarImage!,
      panFile: _panCardImage!,
      bankFile: _bankPassbookImage!,
    );

    setState(() => isUploading = false);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Documents submitted successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to upload documents")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Upload Documents', style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDocumentUpload('Aadhaar Card', _aadhaarImage, () => _showImageSourceActionSheet(context, 'aadhaar')),
                    _buildDocumentUpload('PAN Card', _panCardImage, () => _showImageSourceActionSheet(context, 'pan')),
                    _buildDocumentUpload('Bank Passbook', _bankPassbookImage, () => _showImageSourceActionSheet(context, 'bank')),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blueAccent, Colors.pinkAccent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: isUploading ? null : () => _submitDocuments(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: isUploading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                    'Submit Documents',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
