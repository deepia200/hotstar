// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
//
// class VoiceSearchScreen extends StatefulWidget {
//   @override
//   _VoiceSearchScreenState createState() => _VoiceSearchScreenState();
// }
//
// class _VoiceSearchScreenState extends State<VoiceSearchScreen> {
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   String _text = '';
//   TextEditingController _searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }
//
//   void _listen() async {
//     if (!_isListening) {
//       bool available = await _speech.initialize(
//         onStatus: (val) => print('Status: $val'),
//         onError: (val) => print('Error: $val'),
//       );
//       if (available) {
//         setState(() => _isListening = true);
//         _speech.listen(
//           onResult: (val) {
//             setState(() {
//               _text = val.recognizedWords;
//               _searchController.text = _text;
//             });
//           },
//         );
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech.stop();
//     }
//   }
//
//   @override
//   void dispose() {
//     _speech.stop();
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Voice Search"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: "Search...",
//                 suffixIcon: IconButton(
//                   icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
//                   onPressed: _listen,
//                 ),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               "You said: $_text",
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }