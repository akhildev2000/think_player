// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:think_player/sections/database/db_playlistfun.dart';

import '../sections/database/dbfav.dart';

selectPlaylist(context, videolist, playindex) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Please Select Your Playlist',
                  style: GoogleFonts.biryani(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                    fontSize: 20,
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: playListNotifier,
                builder: (BuildContext context, List<Palylistmodel> value,
                    Widget? child) {
                  return SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: const Color.fromARGB(255, 3, 31, 71),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              iconColor:
                                  Theme.of(context).listTileTheme.iconColor,
                              textColor:
                                  Theme.of(context).listTileTheme.textColor,
                              tileColor:
                                  Theme.of(context).listTileTheme.tileColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25)),
                              ),
                              leading: const Icon(
                                Icons.folder_copy,
                                size: 30,
                              ),
                              title: Text(
                                value[index].name,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                if (!PlayDb().contentPlayCheck(
                                    videolist[playindex].path, index)) {
                                  final tempPlaylistName = value[index].name;
                                  final temp = value[index].path;
                                  temp.add(videolist[playindex].path);

                                  PlayDb().addPlay2(tempPlaylistName, temp);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "${videolist[playindex].name} added to playlist",
                                      ),
                                      duration: const Duration(seconds: 3),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "${videolist[playindex].name}  already exists in this playlist",
                                    ),
                                    duration: const Duration(seconds: 3),
                                  ));
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      );
    },
  );
}
