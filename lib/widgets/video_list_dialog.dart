// ignore_for_file: avoid_unnecessary_containers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:think_player/sections/database/db_playlistfun.dart';

import '../sections/database/dbfav.dart';
import '../sections/database/dbfav_fun.dart';

videoListDialog(context, videoList, playlistIndex) {
  //videoList
  return showDialog(
    context: context,
    builder: (context) {
      return SizedBox(
        child: Dialog(
          shape: const RoundedRectangleBorder(),
          child: Container(
            //color: backgroud_color2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Please select your Video",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 270,
                  child: Consumer<DbFunction>(
                    builder: (context, value, Widget? child) {
                      return SizedBox(
                        height: 270,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.videoListNotifer.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  textColor: Colors.white,
                                  tileColor:
                                      const Color.fromARGB(255, 3, 31, 71),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomRight: Radius.circular(25)),
                                  ),
                                  leading: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Image.asset('asset/videoplay.jpg'),
                                  ),
                                  title: Text(
                                    value.videoListNotifer[index].name,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onTap: () {
                                    if (!PlayDb().contentPlayCheck(
                                        value.videoListNotifer[index].path,
                                        playlistIndex)) {
                                      final tempPlaylistName = playListNotifier
                                          .value[playlistIndex].name;
                                      final temp = playListNotifier
                                          .value[playlistIndex].path;
                                      temp.add(
                                          value.videoListNotifer[index].path);
                                      PlayDb().addPlay2(tempPlaylistName, temp);
                                      // snack(
                                      //     '${value[index].name} Added..!!',
                                      //     context);
                                      Navigator.pop(context);
                                    } else {
                                      // snack(
                                      //     'This video is already added in this playlist',
                                      //     context);
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
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ElevatedButton(
                        //style: ElevatedButton.styleFrom(backgroundColor: backgroud_color1),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
