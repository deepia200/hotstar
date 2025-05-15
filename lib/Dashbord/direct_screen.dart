import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/member_provider.dart';  // Import MemberProvider
import '../models/member_model.dart';     // Import Member model

class DirectScreen extends StatelessWidget {
  const DirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final members = Provider.of<MemberProvider>(context).members;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "My Referrals",
            style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: members.isEmpty
            ? Center(
          child: Text(
            "No members added",
            style: GoogleFonts.roboto(color: Colors.white),
          ),
        )
            : ListView.builder(
          itemCount: members.length,
          itemBuilder: (context, index) {
            final member = members[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              color: Colors.grey[850],
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                title: Text(member.name, style: GoogleFonts.roboto(color: Colors.white)),
                subtitle: Text(
                  'Email: ${member.email}\nUser ID: ${member.userId}',
                  style: GoogleFonts.roboto(color: Colors.white70),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class MyDirectScreen extends StatelessWidget {
//   const MyDirectScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Dummy referral data
//     final List<Map<String, String>> referredUsers = [
//       {'name': 'User A', 'joinedOn': 'May 1, 2025'},
//       {'name': 'User B', 'joinedOn': 'May 3, 2025'},
//       {'name': 'User C', 'joinedOn': 'May 6, 2025'},
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "My Referrals",
//           style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: referredUsers.isEmpty
//             ? Center(child: Text("No referrals yet."))
//             : ListView.builder(
//           itemCount: referredUsers.length,
//           itemBuilder: (context, index) {
//             final user = referredUsers[index];
//             return Card(
//               margin: const EdgeInsets.symmetric(vertical: 8),
//               elevation: 3,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: ListTile(
//                 leading: CircleAvatar(child: Text(user['name']![0])),
//                 title: Text(user['name']!),
//                 subtitle: Text('Joined on: ${user['joinedOn']}'),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
