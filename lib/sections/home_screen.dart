// ignore_for_file: implementation_imports
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:think_player/sections/database/db_playlistfun.dart';
import 'package:think_player/sections/database/dbfav_fun.dart';
//import 'package:flutter/src/widgets/container.dart';
import 'package:think_player/sections/screens/favourites.dart';
import 'package:think_player/sections/screens/playlist.dart';
import 'package:think_player/sections/screens/settings.dart';
import 'package:think_player/sections/screens/video_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // Provider.of<DbFunction>(context, listen: false).notifyListeners();
    // playListNotifier.notifyListeners();
    Provider.of<DbFunction>(context, listen: false).getAllVideos();
    playListNotifier.notifyListeners();
    super.initState();
  }

  int index = 0;
  final screens = [
    const VideoList(),
    const Favourites(),
    const PlayList(),
    const Settings(),
  ];
  final items = <Widget>[
    const Icon(Icons.home, size: 25),
    const Icon(Icons.favorite_rounded, size: 25),
    const Icon(Icons.playlist_add, size: 25),
    const Icon(Icons.settings, size: 25),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: const Color.fromARGB(255, 3, 31, 71),
        bottomNavigationBar: ConvexAppBar(
          elevation: 8,
          top: -15,
          backgroundColor: const Color.fromARGB(255, 3, 31, 71),
          items: const [
            TabItem(icon: Icons.home),
            TabItem(icon: Icons.favorite),
            TabItem(icon: Icons.playlist_add),
            TabItem(icon: Icons.settings),
          ],
          initialActiveIndex: index,
          onTap: (index) => setState(
            () {
              this.index = index;
              Provider.of<DbFunction>(context, listen: false).notifyListeners();
              DbFunction().getAllVideos();
              playListNotifier.notifyListeners();
            },
          ),
        ),
        body: IndexedStack(
          index: index,
          children: screens,
        ),
      ),
    );
  }
}
