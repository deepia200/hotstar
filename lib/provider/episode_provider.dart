import 'package:flutter/material.dart';

class Episode {
  final String title;
  final String subtitle;
  final String duration;

  Episode({
    required this.title,
    required this.subtitle,
    required this.duration,
  });
}

class EpisodeProvider with ChangeNotifier {
  final List<Episode> _episodes = [
    Episode(title: 'S1 E1 - The Beginning', subtitle: '6 Apr 2025', duration: '10m'),
    Episode(title: 'S1 E2 - The Journey', subtitle: '13 Apr 2025', duration: '12m'),
    Episode(title: 'S1 E3 - The Challenge', subtitle: '20 Apr 2025', duration: '15m'),
    Episode(title: 'S2 E1 - The Return', subtitle: '27 Apr 2025', duration: '11m'),
    Episode(title: 'S2 E2 - The Battle', subtitle: '4 May 2025', duration: '15m'),
    Episode(title: 'S2 E3 - The Victory', subtitle: '11 May 2025', duration: '13m'),
    Episode(title: 'S2 E3 - The Victory', subtitle: '11 May 2025', duration: '13m'),
    Episode(title: 'S2 E3 - The Victory', subtitle: '11 May 2025', duration: '13m'),
  ];

  List<Episode> get episodes => _episodes;
}
