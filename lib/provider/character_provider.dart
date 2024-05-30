import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mortyandrickapp/models/character_model.dart';

class CharacterProvider with ChangeNotifier {
  final url = "rickandmortyapi.com";
  List<Character> characters = [];
  Future<void> getCharacters(int page) async {
    final result = await http.get(Uri.https(url, "/api/character", {
      "page": page.toString(),
    }));
    final response = characterResponseFromJson(result.body);
    characters.addAll(response.results!);
    notifyListeners();
  }

  Future<List<Character>> getCharacter(String name) async {
    final result =
        await http.get(Uri.https(url, "/api/character/", {"name": name}));
    final response = characterResponseFromJson(result.body);
    notifyListeners();
    return response.results!;
  }
}
