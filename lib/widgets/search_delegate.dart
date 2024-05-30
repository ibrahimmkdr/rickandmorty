import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mortyandrickapp/models/character_model.dart';
import 'package:mortyandrickapp/provider/character_provider.dart';
import 'package:provider/provider.dart';

class SearchCharacter extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final characterProvider = Provider.of<CharacterProvider>(context);

    return FutureBuilder(
        future: characterProvider.getCharacter(query),
        builder: (context, AsyncSnapshot<List<Character>> snapshot) {
          if (!snapshot.hasData) {
            return const Text("yükleniyor");
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final character = snapshot.data![index];
                return ListTile(
                    onTap: () {
                      context.go("/character", extra: character);
                    },
                    title: Text(character.name!),
                    leading: Hero(
                      tag: character.id!,
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(character.image!)),
                    ));
              });
        });
  }
}
