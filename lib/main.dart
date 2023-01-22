// ignore_for_file: unnecessary_import, constant_identifier_names

import 'dart:io';

import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:think_player/sections/Themes/theme_provider.dart';
import 'package:think_player/sections/database/dbfav.dart';
import 'package:think_player/sections/database/dbfav_fun.dart';
// import 'package:think_player/sections/home_screen.dart';
import 'package:think_player/sections/splash_screen.dart';

List videos = [];
final List<Palylistmodel> PlaylistData = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(VideoModelAdapter());
  Hive.registerAdapter(PalylistmodelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Think PLayer',
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            home: const SplashScreen(),
          );
        },
      );

  @override
  void initState() {
    DbFunction().getAllVideos();
    super.initState();
  }
}

Future<Box<VideoModel>> myhivebox(String boxName) async {
  if (!kIsWeb && !Hive.isBoxOpen(boxName)) {
    Hive.init((await getApplicationDocumentsDirectory()).path);
  }
  return await Hive.openBox(boxName);
}

Future<Box<Palylistmodel>> myhivebox2(String boxName) async {
  if (!kIsWeb && !Hive.isBoxOpen(boxName)) {
    Hive.init((await getApplicationDocumentsDirectory()).path);
  }
  return await Hive.openBox(boxName);
}

Future getVideos() async {
  FetchAllVideos ob = FetchAllVideos();
  videos = await ob.getAllVideos();
  videos = videos.toSet().toList();
  for (int i = 0; i < videos.length; i++) {
    VideoModel videoD = VideoModel(
        name: videos[i].split('/').last,
        path: videos[i],
        file: File(
          videos[i],
        ));
    await DbFunction().addVideo(videoD);
    if (i == 10) {
      videoListNotifer.notifyListeners();
    } else {
      continue;
    }
  }
  videoListNotifer.notifyListeners();
}

bool videoPlayerCheck(int playerID) {
  if (playerID == 0) {
    return true;
  } else {
    return false;
  }
}
