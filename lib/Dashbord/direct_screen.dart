import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDirectScreen extends StatelessWidget {
  const MyDirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example event data
    final String eventTitle = "Next Big Event";
    final String eventDate = "May 25, 2025";
    final String eventTime = "3:00 PM";
    final String eventPlace = "Main Hall, City Center";

    return Scaffold(
      appBar: AppBar(
        title:  Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Text("Upcoming Event", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20),),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventTitle,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 20),
                    const SizedBox(width: 10),
                    Text(eventDate),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 20),
                    const SizedBox(width: 10),
                    Text(eventTime),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 20),
                    const SizedBox(width: 10),
                    Flexible(child: Text(eventPlace)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
