import 'package:flutter/material.dart';
import 'package:mortyandrickapp/models/allEpisode_model.dart';

class EpisodeDetailScreen extends StatelessWidget {
  final AllEpisode episode;

  const EpisodeDetailScreen({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(episode.name ?? 'Unknown Episode'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Episode ID: ${episode.id}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Air Date: ${episode.airDate ?? 'Unknown'}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
