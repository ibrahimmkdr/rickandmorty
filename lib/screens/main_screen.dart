import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mortyandrickapp/provider/character_provider.dart';
import 'package:mortyandrickapp/screens/episode_screen.dart';
import 'package:mortyandrickapp/widgets/search_delegate.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    const CharacterScreens(),
    const AllEpisoodeScreens(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rick And Morty",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchCharacter());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Karakterler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Bölümler',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class CharacterScreens extends StatefulWidget {
  const CharacterScreens({super.key});

  @override
  State<CharacterScreens> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreens> {
  final scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<CharacterProvider>(context, listen: false);

    apiProvider.getCharacters(page);
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });
        page++;
        await apiProvider.getCharacters(page);
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterProvider>(builder: (context, apiProvider, _) {
      return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: apiProvider.characters.isNotEmpty
            ? CharacterList(
                apiProvider: apiProvider,
                isLoading: isLoading,
                scrollController: scrollController,
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      );
    });
  }
}

class CharacterList extends StatelessWidget {
  const CharacterList({
    super.key,
    required this.apiProvider,
    required this.scrollController,
    required this.isLoading,
  });

  final CharacterProvider apiProvider;
  final ScrollController scrollController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.87,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: isLoading
          ? apiProvider.characters.length + 2
          : apiProvider.characters.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index < apiProvider.characters.length) {
          final character = apiProvider.characters[index];
          return GestureDetector(
            onTap: () {
              context.go("/character", extra: character);
            },
            child: Card(
              child: Column(
                children: [
                  Image(image: NetworkImage(character.image!)),
                  Text(character.name!)
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
