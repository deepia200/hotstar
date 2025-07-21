// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hotstar/service/api_methods.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
// import '../provider/auth_provider.dart';
//
// class KycIdCardScreen extends StatelessWidget {
//   const KycIdCardScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<AuthProvider>(context);
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           title: Text(
//             'Distributor ID Card',
//             style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.black,
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.share),
//               onPressed: () => _shareKycInfo(user),
//             ),
//           ],
//         ),
//         body: Center(
//           child: Card(
//             color: Colors.grey[900],
//             elevation: 10,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             child: Container(
//               width: 330,
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // const CircleAvatar(
//                   //   radius: 50,
//                   //   backgroundImage: NetworkImage("https://via.placeholder.com/150"),
//                   // ),
//                   CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.grey[800],
//                     backgroundImage: (user.profileImage != null && user.profileImage!.isNotEmpty)
//                         ? NetworkImage(ApiMethods.getImageUrl(user.profileImage))
//                         : null,
//                     child: (user.profileImage == null || user.profileImage!.isEmpty)
//                         ? const Icon(Icons.person, size: 50, color: Colors.white70)
//                         : null,
//                   ),
//
//                   const SizedBox(height: 16),
//                   Text(
//                     user.fname ?? 'N/A',
//                     style: GoogleFonts.roboto(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     'ID: ${user.id}',
//                     style: TextStyle(color: Colors.white70, fontSize: 12,fontWeight: FontWeight.bold),
//                   ),
//                   const Divider(color: Colors.white24),
//                   _buildInfoRow("Email", user.email ?? 'N/A'),
//                   _buildInfoRow("Phone", user.phone ?? 'N/A'),
//                   _buildInfoRow("Full Address", user.fullAddress ?? 'N/A'),
//                   _buildInfoRow("City", user.address?['city'] ?? 'N/A'),
//                   _buildInfoRow("State", user.address?['state'] ?? 'N/A'),
//                   _buildInfoRow("Country", user.country ?? 'N/A',),
//                   // if ((user.distributorId ?? '').isNotEmpty)
//                   //   _buildInfoRow("Distributor ID", user.distributorId!),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 3,
//             child: Text(
//               "$label:",
//               style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             flex: 5,
//             child: Text(value, style: GoogleFonts.roboto(color: Colors.white70)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _shareKycInfo(AuthProvider user) {
//     final text = '''
// 🪪 *Distributor ID Card*
//
// Name: ${user.fname ?? 'N/A'}
// Id: ${user.id ?? 'N/A'}
// Email: ${user.email ?? 'N/A'}
// Phone: ${user.phone ?? 'N/A'}
// Full Address: ${user.fullAddress ?? 'N/A'}
// City: ${user.address?['city'] ?? 'N/A'}
// State: ${user.address?['state'] ?? 'N/A'}
// Country: ${user.country ?? 'N/A'}
//
// ''';
//     Share.share(text);
//   }
// }
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotstar/service/api_methods.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../provider/auth_provider.dart';

class KycIdCardScreen extends StatefulWidget {
  const KycIdCardScreen({super.key});

  @override
  State<KycIdCardScreen> createState() => _KycIdCardScreenState();
}

class _KycIdCardScreenState extends State<KycIdCardScreen> {
  final GlobalKey _cardKey = GlobalKey(); // RepaintBoundary key

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'Distributor ID Card',
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () => _shareKycInfo(user),
            ),
          ],
        ),
        body: Center(
          child: RepaintBoundary(
            key: _cardKey,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3A3A98), Color(0xFF6D83F2)], // Blueish gradient
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Card(
                color: Colors.transparent, // Make Card background transparent to show gradient
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  width: 330,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white24,
                        backgroundImage: (user.profileImage != null && user.profileImage!.isNotEmpty)
                            ? NetworkImage(ApiMethods.getImageUrl(user.profileImage))
                            : null,
                        child: (user.profileImage == null || user.profileImage!.isEmpty)
                            ? const Icon(Icons.person, size: 50, color: Colors.white70)
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user.fname ?? 'N/A',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'ID: ${user.id}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(color: Colors.white24, height: 25),
                      _buildInfoRow("Email", user.email ?? 'N/A'),
                      _buildInfoRow("Phone", user.phone ?? 'N/A'),
                      _buildInfoRow("Full Address", user.fullAddress ?? 'N/A'),
                      _buildInfoRow("City", user.address?['city'] ?? 'N/A'),
                      _buildInfoRow("State", user.address?['state'] ?? 'N/A'),
                      _buildInfoRow("Country", user.country ?? 'N/A'),
                    ],
                  ),
                ),
              ),
            ),

          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$label:",
              style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(value, style: GoogleFonts.roboto(color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  Future<void> _shareKycInfo(AuthProvider user) async {
    try {
      RenderRepaintBoundary boundary =
      _cardKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/kyc_card.png').create();
      await file.writeAsBytes(pngBytes);

//       final text = '''
// 🪪 *Distributor ID Card*
//
// Name: ${user.fname ?? 'N/A'}
// Id: ${user.id ?? 'N/A'}
// Email: ${user.email ?? 'N/A'}
// Phone: ${user.phone ?? 'N/A'}
// Full Address: ${user.fullAddress ?? 'N/A'}
// City: ${user.address?['city'] ?? 'N/A'}
// State: ${user.address?['state'] ?? 'N/A'}
// Country: ${user.country ?? 'N/A'}
// ''';

      // await Share.shareXFiles([XFile(file.path)], text: text);
      await Share.shareXFiles([XFile(file.path)],);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to share ID card: $e")),
      );
    }
  }
}

