import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotstar/service/api_methods.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../provider/auth_provider.dart';

class KycIdCardScreen extends StatelessWidget {
  const KycIdCardScreen({super.key});

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
          child: Card(
            color: Colors.grey[900],
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              width: 330,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // const CircleAvatar(
                  //   radius: 50,
                  //   backgroundImage: NetworkImage("https://via.placeholder.com/150"),
                  // ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[800],
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
                    style: GoogleFonts.roboto(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ID: ${user.id}',
                    style: TextStyle(color: Colors.white70, fontSize: 12,fontWeight: FontWeight.bold),
                  ),
                  const Divider(color: Colors.white24),
                  _buildInfoRow("Email", user.email ?? 'N/A'),
                  _buildInfoRow("Phone", user.phone ?? 'N/A'),
                  _buildInfoRow("Full Address", user.fullAddress ?? 'N/A'),
                  _buildInfoRow("City", user.address?['city'] ?? 'N/A'),
                  _buildInfoRow("State", user.address?['state'] ?? 'N/A'),
                  _buildInfoRow("Country", user.country ?? 'N/A',),
                  // if ((user.distributorId ?? '').isNotEmpty)
                  //   _buildInfoRow("Distributor ID", user.distributorId!),
                ],
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

  void _shareKycInfo(AuthProvider user) {
    final text = '''
🪪 *Distributor ID Card*

Name: ${user.fname ?? 'N/A'}
Id: ${user.id ?? 'N/A'}
Email: ${user.email ?? 'N/A'}
Phone: ${user.phone ?? 'N/A'}
Full Address: ${user.fullAddress ?? 'N/A'}
City: ${user.address?['city'] ?? 'N/A'}
State: ${user.address?['state'] ?? 'N/A'}
Country: ${user.country ?? 'N/A'}

''';
    Share.share(text);
  }
}
