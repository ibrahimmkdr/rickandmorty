import 'package:go_router/go_router.dart';
import 'package:mortyandrickapp/models/allEpisode_model.dart';
import 'package:mortyandrickapp/models/character_model.dart';
import 'package:mortyandrickapp/screens/character_screen.dart';
import 'package:mortyandrickapp/screens/episodeDetail_screen.dart';
import 'package:mortyandrickapp/screens/main_screen.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) {
      return const HomeScreen();
    },
    routes: [
      GoRoute(
        path: "character",
        builder: (context, state) {
          final character = state.extra as Character;
          return CharacterScreen(character: character);
        },
      ),
      GoRoute(
        path: "episode_detail",
        name: "episode_detail",
        builder: (context, state) {
          final episode = state.extra as AllEpisode;
          return EpisodeDetailScreen(episode: episode);
        },
      ),
    ],
  ),
]);
