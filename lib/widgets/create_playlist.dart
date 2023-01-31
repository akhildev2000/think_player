// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:think_player/sections/database/db_playlistfun.dart';
import 'package:think_player/sections/database/dbfav.dart';

import '../main.dart';

final playlistNameControler = TextEditingController();
createPlaylist(context) {
  final _formkey = GlobalKey<FormState>();
  return showDialog(
    //createPlaylist
    context: context,
    builder: (context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        backgroundColor: const Color.fromARGB(255, 3, 31, 71),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter Playlist Name",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formkey,
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Playlist Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) {
                  bool check = PlayDb().contentPlayNameCheck(value);
                  if (value == '') {
                    return 'Enter a name';
                  } else if (check) {
                    return '$value already in playlist';
                  } else {
                    return null;
                  }
                },
                controller: playlistNameControler,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color.fromARGB(255, 3, 31, 71)),
            onPressed: () {
              if (_formkey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        '${playlistNameControler.text} created in playlists'),
                    duration: const Duration(seconds: 3),
                  ),
                );
                //print(playlistNameControler.text);
                final data =
                    Palylistmodel(name: playlistNameControler.text, path: []);
                PlaylistData.add(data);
                //print(data.name);
                PlayDb().addPlay(data, null);
                //print(data.name);
                Navigator.pop(context);
                playlistNameControler.clear();
              }
            },
            child: const Text('Create Playlist'),
          ),
        ],
      );
    },
  );
}
