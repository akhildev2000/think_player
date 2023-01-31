// ignore_for_file: unnecessary_import, constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:think_player/sections/Themes/theme_provider.dart';

import 'package:think_player/sections/database/dbfav.dart';
import 'package:think_player/sections/database/dbfav_fun.dart';
import 'package:think_player/sections/functions/getvideos.dart';
// import 'package:think_player/sections/home_screen.dart';
import 'package:think_player/sections/functions/splash_screen.dart';

List videos = [];
final List<Palylistmodel> PlaylistData = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(VideoModelAdapter());
  Hive.registerAdapter(PalylistmodelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DbFunction(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetVideos(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Think PLayer',
            themeMode: value.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            home: const SplashScreen(),
          );
        },
      ),
    );
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

bool videoPlayerCheck(int playerID) {
  if (playerID == 0) {
    return true;
  } else {
    return false;
  }
}
