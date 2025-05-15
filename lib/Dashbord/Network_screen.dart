import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/member_provider.dart';
import '../models/member_model.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({super.key});

  @override
  _NetworkScreenState createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  double _scale = 1.0; // Initial scale factor

  // Function to handle scale updates
  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = details.scale.clamp(0.5, 3.0); // Limit scale between 0.5 and 3
    });
  }

  // Build a user cell without image, just ID and name
  Widget buildUserCell(String id, String name) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 4),
        Text(id, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        Text(name, style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  // Build an "open" cell placeholder (no image)
  Widget buildOpenCell() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        SizedBox(height: 4),
        Text('OPEN', style: TextStyle(color: Colors.white)),
      ],
    );
  }

  // Helper to build a tree row
  Widget buildTreeRow(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children
            .map((child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: child,
        ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final rootMembers = Provider.of<MemberProvider>(context).members;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "My Network Tree",
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: rootMembers.isEmpty
          ? Center(
        child: Text(
          "No members added",
          style: GoogleFonts.roboto(color: Colors.white),
        ),
      )
          : GestureDetector(
        onScaleUpdate: _onScaleUpdate,
        child: SingleChildScrollView(
          child: Transform(
            transform: Matrix4.identity()..scale(_scale),
            alignment: Alignment.center,
            child: Column(
              children: rootMembers.map((member) {
                return Column(
                  children: [
                    // Root node centered
                    buildTreeRow([
                      buildUserCell(member.userId, member.name),
                    ]),

                    // Second level: Left and Right child nodes
                    buildTreeRow([
                      buildUserCell('ID327087', 'Ayesha'),
                      buildUserCell('ID327087', 'Keshav'),
                    ]),

                    // Third level: Additional child nodes for further depth
                    buildTreeRow([
                      buildUserCell('ID327087', 'Sana'),
                      buildOpenCell(),
                      buildOpenCell(),
                      buildUserCell('ID327087', 'Payal'),
                    ]),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import '../provider/member_provider.dart';  // Import MemberProvider
// import '../models/member_model.dart';     // Import Member model
//
// class MyNetworkScreen extends StatelessWidget {
//   const MyNetworkScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Access the list of members from the provider
//     final members = Provider.of<MemberProvider>(context).members;
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           title:  Text("My Network", style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),),
//           centerTitle: true,
//           backgroundColor: Colors.black,
//         ),
//         body: members.isEmpty
//             ?  Center(child: Text("No members added", style: GoogleFonts.roboto(color: Colors.white)))
//             : ListView.builder(
//           itemCount: members.length,
//           itemBuilder: (context, index) {
//             final member = members[index];
//             return Card(
//               margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               color: Colors.grey[850],
//               child: ListTile(
//                 contentPadding: const EdgeInsets.all(12),
//                 title: Text(member.name, style:  GoogleFonts.roboto(color: Colors.white)),
//                 subtitle: Text('Email: ${member.email}\nUser ID: ${member.userId}',
//                     style:  GoogleFonts.roboto(color: Colors.white70)),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
