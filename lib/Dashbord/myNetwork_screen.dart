import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/api_methods.dart';

class MyNetworkScreen extends StatefulWidget {
  const MyNetworkScreen({super.key});

  @override
  State<MyNetworkScreen> createState() => _MyNetworkScreenState();
}

class _MyNetworkScreenState extends State<MyNetworkScreen> {
  List<dynamic> _networkMembers = [];
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchNetworkData();
  }

  Future<void> _fetchNetworkData() async {
    final prefs = await SharedPreferences.getInstance();
    final id =  await prefs.getString('id');
    try {
      final data = await ApiMethods.fetchdownReferrals(id as String);
      setState(() {
        _networkMembers = data;
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
            "My Network",
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
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
            : _networkMembers.isEmpty
            ? Center(
          child: Text(
            "No network members found",
            style: GoogleFonts.roboto(color: Colors.white),
          ),
        )
            : ListView.builder(
          itemCount: _networkMembers.length,
          itemBuilder: (context, index) {
            final member = _networkMembers[index];
            final isActive = member['active'] == 'yes'; // Check active status

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              color: isActive ? Colors.green[700] : Colors.red[700], // Active → green, Inactive → red
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                title: Text(
                  "ID: ${member['memberid'] ?? 'N/A'}",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Name: ${member['name']}\n'
                      'Phone: ${member['phone_number']}\n'
                      'Join Date: ${member['join_date'] ?? 'N/A'}',
                  style: GoogleFonts.roboto(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          },
        ),

      ),
    );
  }
}
