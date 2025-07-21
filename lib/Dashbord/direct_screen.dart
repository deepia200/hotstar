// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import '../provider/member_provider.dart';  // Import MemberProvider
// import '../models/member_model.dart';     // Import Member model
//
// class DirectScreen extends StatelessWidget {
//   const DirectScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final members = Provider.of<MemberProvider>(context).members;
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           title: Text(
//             "My Referrals",
//             style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.black,
//         ),
//         body: members.isEmpty
//             ? Center(
//           child: Text(
//             "No members added",
//             style: GoogleFonts.roboto(color: Colors.white),
//           ),
//         )
//             : ListView.builder(
//           itemCount: members.length,
//           itemBuilder: (context, index) {
//             final member = members[index];
//             return Card(
//               margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               color: Colors.grey[850],
//               child: ListTile(
//                 contentPadding: const EdgeInsets.all(12),
//                 title: Text(member.name, style: GoogleFonts.roboto(color: Colors.white)),
//                 subtitle: Text(
//                   'Email: ${member.email}\nUser ID: ${member.userId}',
//                   style: GoogleFonts.roboto(color: Colors.white70),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/api_methods.dart';  // make sure this path is correct

class DirectScreen extends StatefulWidget {
  const DirectScreen({super.key});

  @override
  State<DirectScreen> createState() => _DirectScreenState();
}

class _DirectScreenState extends State<DirectScreen> {
  List<dynamic> _members = [];
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadReferrals();
  }

  Future<void> _loadReferrals() async {
    final prefs = await SharedPreferences.getInstance();
    final id =  await prefs.getString('id');
    try {
      final data = await ApiMethods.fetchReferrals(id as String);
      setState(() {
        _members = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error.isNotEmpty
            ? Center(
          child: Text(
            _error,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        )
            : _members.isEmpty
            ? Center(
          child: Text(
            "No members added",
            style: GoogleFonts.roboto(color: Colors.white),
          ),
        )
            :ListView.builder(
          itemCount: _members.length,
          itemBuilder: (context, index) {
            final member = _members[index];
            final isActive = member['active'] == 'yes';

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              color: isActive ? Colors.green[700] : Colors.red[700],
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                title: Text(
                  "ID: ${member['memberid']}",
                  style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Name: ${member['name']}\n'
                      'Phone: ${member['phone_number']}\n'
                      'Join Date: ${member['join_date']}',
                  style: GoogleFonts.roboto(color: Colors.white70, fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),

      ),
    );
  }
}
