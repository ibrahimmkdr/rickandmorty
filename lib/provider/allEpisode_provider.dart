import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mortyandrickapp/models/allEpisode_model.dart';
import 'package:mortyandrickapp/models/character_model.dart';

class AllApisodeProvider with ChangeNotifier {
  final url = "rickandmortyapi.com";
  List<AllEpisode>? allEposidesList = [];
  Future<List<AllEpisode>?> getAllEposides() async {
    final result = await http.get(Uri.https(url, "/api/episode/"));
    final response = AllEpisodeResponse.fromJson(jsonDecode(result.body));
    allEposidesList = response.results;
    return allEposidesList;
  }

  Future<List<Character>> getCharacter(String name) async {
    final result =
        await http.get(Uri.https(url, "/api/character/", {"name": name}));
    final response = characterResponseFromJson(result.body);
    return response.results!;
  }
}
