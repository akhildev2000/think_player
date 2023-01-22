// ignore_for_file: unused_import

import 'dart:io';
import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:think_player/main.dart';
import 'package:think_player/sections/database/dbfav.dart';
import 'package:think_player/sections/database/dbfav_fun.dart';
import 'package:think_player/sections/video_list.dart';
import 'package:think_player/sections/video_screen.dart';
import 'package:think_player/sections/videoplayer2.dart';
import 'package:video_player/video_player.dart';
import 'package:lottie/lottie.dart';

bool playerID = false;

class Favourites extends StatefulWidget {
  const Favourites({
    super.key,
  });

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Text(
            "Favourites",
            style: GoogleFonts.merriweather(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: favListNotifier,
          builder:
              (BuildContext context, List<VideoModel> list, Widget? child) {
            return list.isEmpty
                ? Center(
                    child: Lottie.asset('asset/animation/favourites.json',
                        height: 200))
                : ListView.builder(
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          iconColor: Theme.of(context).listTileTheme.iconColor,
                          textColor: Theme.of(context).listTileTheme.textColor,
                          tileColor: Theme.of(context).listTileTheme.tileColor,
                          leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.asset('asset/videoplay.jpg'),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              DbFunction().removeFav(index);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(milliseconds: 120),
                                  content: Text('Removed From Favourites'),
                                ),
                              );
                              videoListNotifer.value[index].isFav = false;
                            },
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                          ),
                          title: Text(list[index].name,
                              maxLines: 1,
                              style: GoogleFonts.merriweatherSans(
                                  fontWeight: FontWeight.w500)),
                          onTap: () {
                            playerID = videoPlayerCheck(1);

                            final File file = File(list[index].path);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => VideoItems2(
                                        videoPlayerController:
                                            VideoPlayerController.file(file))));
                          },
                        ),
                      );
                    }),
                    itemCount: list.length);
          }),
    );
  }
}
