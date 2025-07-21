import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../service/api_methods.dart'; // adjust path as per your folder

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({Key? key}) : super(key: key);

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  List<dynamic> trainings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTrainings();
  }

  Future<void> loadTrainings() async {
    final result = await ApiMethods.fetchTrainings();
    setState(() {
      trainings = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:  Text("Trainings", style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
        backgroundColor: Colors.black,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : trainings.isEmpty
          ? const Center(
        child: Text(
          "No Training Yet",
          style: TextStyle(color: Colors.white),
        ),
      )
          : ListView.builder(
        itemCount: trainings.length,
        itemBuilder: (context, index) {
          final item = trainings[index];
          return Card(
            color: Colors.white10,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(
                item['title'] ?? '',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item['date']} | ${item['time']}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['location'] ?? '',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              trailing: Text(
                item['status'] ?? '',
                style: TextStyle(
                  color: item['status'] == 'completed' ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
