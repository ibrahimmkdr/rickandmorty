import 'package:flutter/material.dart';
import 'package:mortyandrickapp/models/character_model.dart';
import 'package:provider/provider.dart';
import 'package:mortyandrickapp/provider/episode_provider.dart';

class CharacterScreen extends StatelessWidget {
  final Character character;
  const CharacterScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name!),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.35,
              width: double.infinity,
              child: Hero(
                tag: character.id!,
                child: Image.network(
                  character.image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: size.height * 0.14,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  cardData("Durum:", character.status!),
                  cardData("Irk:", character.species!),
                  cardData("Koordinat:", character.origin!.name!),
                ],
              ),
            ),
            const Text(
              "Episode",
              style: TextStyle(fontSize: 17),
            ),
            EpisodeList(size: size, character: character)
          ],
        ),
      ),
    );
  }
}

Widget cardData(String text1, String text2) {
  return Expanded(
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text1),
          Text(
            text2,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    ),
  );
}

// ignore: camel_case_types
class EpisodeList extends StatefulWidget {
  const EpisodeList({super.key, required this.size, required this.character});

  final Size size;
  final Character character;
//
  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

// ignore: camel_case_types
class _EpisodeListState extends State<EpisodeList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final apiProvider = Provider.of<ApiProvider>(context, listen: false);
      apiProvider.getEpisodes(widget.character);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context, apiProvider, _) {
        return SizedBox(
          height: widget.size.height * 0.35,
          child: ListView.builder(
            itemCount: apiProvider.episodes.length,
            itemBuilder: (context, index) {
              final episode = apiProvider.episodes[index];
              return ListTile(
                leading: Text(episode.episode!),
                title: Text(episode.name!),
                trailing: Text(episode.airDate!),
              );
            },
          ),
        );
      },
    );
  }
}
