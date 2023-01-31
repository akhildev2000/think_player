// ignore_for_file: avoid_unnecessary_containers, unnecessary_import, implementation_imports, unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:think_player/sections/database/db_playlistfun.dart';
import 'package:think_player/sections/database/dbfav_fun.dart';
import 'package:think_player/sections/functions/video_screen.dart';
import 'package:think_player/sections/functions/videoplayer2.dart';
import 'package:think_player/widgets/video_list_dialog.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/change_playname.dart';

class InsidePlaylist extends StatefulWidget {
  final templist;
  final playlistIndex;
  final playlistname;
  const InsidePlaylist({
    super.key,
    required this.templist,
    required this.playlistIndex,
    required this.playlistname,
  });

  @override
  State<InsidePlaylist> createState() => _InsidePlaylistState();
}

class _InsidePlaylistState extends State<InsidePlaylist> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0,
          title: ValueListenableBuilder(
            valueListenable: playListNotifier,
            builder: (BuildContext context, value, Widget? child) {
              return Text(
                  playListNotifier.value.elementAt(widget.playlistIndex).name,
                  //style: mainTextStyle,
                  overflow: TextOverflow.ellipsis);
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                videoListDialog(
                    context,
                    Provider.of<DbFunction>(context, listen: false)
                        .videoListNotifer,
                    widget.playlistIndex);
              },
              icon: const Icon(Icons.add_box),
            ),
            // IconButton(
            //     onPressed: () {
            //       changePlaylistName(context, widget.playlistname,
            //           widget.templist, widget.playlistIndex);
            //     },
            //     icon: Icon(Icons.edit))
          ],
        ),
        body: Container(
          child: ValueListenableBuilder(
            valueListenable: playListNotifier,
            builder: (BuildContext context, value, Widget? child) {
              return widget.templist.length == 0
                  ? Center(
                      child: Lottie.asset(
                        'asset/loading_home.json',
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: ((context, index) {
                        return Padding(
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
                            title: Text(widget.templist[index].split('/').last,
                                maxLines: 1,
                                style: GoogleFonts.merriweatherSans(
                                    fontWeight: FontWeight.w500)),
                            leading: SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.asset('asset/videoplay.jpg'),
                            ),
                            onTap: () {
                              final File tempFile =
                                  File(widget.templist[index]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoItems2(
                                        videoPlayerController:
                                            VideoPlayerController.file(
                                                tempFile))),
                              );
                            },
                            trailing: IconButton(
                                onPressed: () {
                                  final name = widget.playlistname;
                                  List deletedList = widget.templist;
                                  deletedList.removeAt(index);
                                  PlayDb().addPlay2(name, deletedList);
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                )),
                          ),
                        );
                      }),
                      itemCount: widget.templist.length,
                    );
            },
          ),
        ),
      ),
    );
  }
}
