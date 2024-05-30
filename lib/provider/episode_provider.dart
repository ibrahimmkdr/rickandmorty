import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mortyandrickapp/models/character_model.dart';
import 'package:mortyandrickapp/models/episode_model.dart';

class ApiProvider with ChangeNotifier {
  final url = "rickandmortyapi.com";
  List<Episode> episodes = [];
  Future<List<Episode>> getEpisodes(Character character) async {
    episodes = [];
    for (var i = 0; i < character.episode!.length; i++) {
      final result = await http.get(Uri.parse(character.episode![i]));
      final response = episodeFromJson(result.body);
      episodes.add(response);
      notifyListeners();
    }
    return episodes;
  }
}
