import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:think_player/main.dart';
import 'package:think_player/sections/database/db_playlistfun.dart';
import 'package:think_player/widgets/create_playlist.dart';

import '../sections/database/dbfav.dart';

changePlaylistName(context, currentName, playlist, playlistIndex) {
  //changePlaylistName
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  _controller.text = currentName;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter Playlist Name",
              textAlign: TextAlign.left,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Playlist Name'),
                controller: _controller,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              //style: TextStyle(color: backgroud_color1 ),
            ),
          ),
          ElevatedButton(
            //style: ElevatedButton.styleFrom(backgroundColor: backgroud_color1),
            onPressed: () {
              //snack('$currentName changed to ${_controller.text}', context);
              final data =
                  Palylistmodel(name: _controller.text, path: playlist);
              PlaylistData.add(data);

              PlayDb().addPlay2(currentName, data);
              Navigator.pop(context);
              playlistNameControler.clear();
            },
            child: Text('Change Playlist Name'),
          ),
        ],
      );
    },
  );
}
