import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mortyandrickapp/provider/allEpisode_provider.dart';
import 'package:provider/provider.dart';

class AllEpisoodeScreens extends StatefulWidget {
  const AllEpisoodeScreens({Key? key});

  @override
  State<AllEpisoodeScreens> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<AllEpisoodeScreens> {
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<AllApisodeProvider>(context, listen: false);
    Future.microtask(
      () async {
        await apiProvider.getAllEposides();
        inspect(apiProvider.allEposidesList);
      },
    );
    apiProvider.getCharacter(page.toString());
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });
        page++;
        await apiProvider.getCharacter(page.toString());
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bölümler"),
      ),
      body: Consumer<AllApisodeProvider>(
        builder: (context, apiProvider, _) {
          return ListView.builder(
            controller: scrollController,
            itemCount: apiProvider.allEposidesList?.length,
            itemBuilder: (context, index) {
              final episode = apiProvider.allEposidesList?[index];
              return ListTile(
                onTap: () {
                  context.pushNamed("episode_detail", extra: episode);
                },
                title: Text(episode?.name ?? "İsim yok"),
                subtitle: Text(
                    "Yükleme tarihi: ${episode?.created?.toString() ?? "Bilinmiyor"}"),
              );
            },
          );
        },
      ),
    );
  }
}
