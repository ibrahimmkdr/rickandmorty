import 'package:flutter/material.dart';
import 'package:mortyandrickapp/provider/allEpisode_provider.dart';
import 'package:mortyandrickapp/provider/character_provider.dart';
import 'package:mortyandrickapp/provider/episode_provider.dart';
import 'package:mortyandrickapp/widgets/go_router.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AllApisodeProvider()),
        ChangeNotifierProvider(create: (context) => CharacterProvider()),
        ChangeNotifierProvider(create: (context) => ApiProvider()),
      ],
      child: MaterialApp.router(
        title: 'Character & Episodes',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        routerConfig: router,
      ),
    );
  }
}
