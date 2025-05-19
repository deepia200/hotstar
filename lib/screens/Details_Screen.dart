import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../provider/episode_provider.dart';

class EpisodeDetailsScreen extends StatefulWidget {
  final String title;

  const EpisodeDetailsScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<EpisodeDetailsScreen> createState() => _EpisodeDetailsScreenState();
}

class _EpisodeDetailsScreenState extends State<EpisodeDetailsScreen> {
  Widget buildEpisodeTile(Episode episode) {
    return ListTile(
      leading: Image.network(
        'https://i.ytimg.com/vi/Ei8oBTxHZcU/hq720.jpg',
        width: 100,
        fit: BoxFit.cover,
      ),
      title: Text(
        episode.title,
        style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '${episode.subtitle} • ${episode.duration}',
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final episodeProvider = Provider.of<EpisodeProvider>(context);
    final episodes = episodeProvider.episodes;

    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(backgroundColor: Colors.black),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
               children: [
                 SizedBox(
                   width: double.infinity,
                   height: MediaQuery.of(context).size.height / 4,
                   child: WebViewWidget(
                     controller: WebViewController()
                       ..setJavaScriptMode(JavaScriptMode.unrestricted)
                       ..loadRequest(Uri.parse('https://player.vimeo.com/video/1077793352?autoplay=1&muted=1')),
                   ),
                 ),
                 IconButton(
                     padding: EdgeInsets.only(left: 20),
                     onPressed: (){},
                     icon:Icon( Icons.arrow_back,
                       color: Colors.white,
                       size: 30,)),

               ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Ramayan is an iconic Indian television series based on the ancient Sanskrit epic. '
                      'Created by Ramanand Sagar, it originally aired in 1987 and depicts the life of Lord Rama.',
                  style: GoogleFonts.roboto(color: Colors.white70, fontSize: 14, height: 1.5),
                ),
              ),
              const SizedBox(height: 20),
              ...episodes.map(buildEpisodeTile).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
