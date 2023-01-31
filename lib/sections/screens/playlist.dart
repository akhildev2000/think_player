// ignore_for_file: unused_import, unnecessary_import, implementation_imports

import 'dart:math';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:think_player/sections/database/db_playlistfun.dart';
import 'package:think_player/sections/database/dbfav.dart';
import 'package:think_player/sections/database/dbfav_fun.dart';
import 'package:think_player/sections/functions/inside_playlist.dart';
import 'package:think_player/widgets/change_playname.dart';
import 'package:think_player/widgets/create_playlist.dart';
import 'package:think_player/sections/screens/favourites.dart';

class PlayList extends StatefulWidget {
  const PlayList({super.key});

  @override
  State<PlayList> createState() => _PlaylistState();
}

class _PlaylistState extends State<PlayList> {
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
            "Playlist",
            style: GoogleFonts.merriweather(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                createPlaylist(context);
              },
              icon: const Icon(Icons.add_box)),
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: playListNotifier,
          builder: (context, value, child) {
            return value.isEmpty
                ? Center(
                    child: Lottie.asset('asset/screen.json', height: 200),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          iconColor: Theme.of(context).listTileTheme.iconColor,
                          textColor: Theme.of(context).listTileTheme.textColor,
                          tileColor: Theme.of(context).listTileTheme.tileColor,
                          leading: const Icon(
                            Icons.folder_copy,
                            size: 50,
                          ),
                          title: Text(value[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.merriweatherSans(
                                  fontWeight: FontWeight.w500)),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        const Color.fromARGB(255, 3, 31, 71),
                                    title: const Text(
                                      'Delete Playlist',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: const Text(
                                      'Do you really want to delete this playlist?',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          PlayDb().removePlay(index);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Yes',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text(
                                            'No',
                                            style: TextStyle(color: Colors.red),
                                          ))
                                    ],
                                  );
                                },
                              );
                              //PlayDb().removePlay(index);
                            },
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25)),
                          ),
                          onTap: () {
                            final templist = value[index].path;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => InsidePlaylist(
                                      templist: templist,
                                      playlistIndex: index,
                                      playlistname: value[index].name,
                                    )),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    itemCount: value.length);
          }),
    );
  }
}
