// ignore_for_file: unused_local_variable, avoid_unnecessary_containers, prefer_is_empty

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:think_player/sections/video_list.dart';
import 'package:think_player/sections/video_screen.dart';
import 'package:think_player/sections/videoplayer2.dart';
import 'package:video_player/video_player.dart';

class SearchScreen extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: query == ''
            ? Container()
            : const Icon(
                Icons.clear,
                color: Color.fromARGB(255, 3, 31, 71),
                size: 30,
              ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Color.fromARGB(255, 3, 31, 71),
          size: 30,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    List listItems = [];
    for (var item in searchItem) {
      if (item.toLowerCase().contains(query.toLowerCase().split('/').last)) {
        listItems.add(item);
      }
    }
    return query.length == 0 || listItems.isEmpty
        ? Container(child: Center(child: Lottie.asset('asset/searching.json')))
        : ListView.separated(
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              var file = File(listItems[index]);
              var result = listItems[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    textColor: Colors.white,
                    tileColor: const Color.fromARGB(255, 3, 31, 71),
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
                    title: (Text(
                      result.toString().split('/').last,
                      overflow: TextOverflow.ellipsis,
                    )),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => VideoItems2(
                            videoPlayerController:
                                VideoPlayerController.file(file),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List matchItem = [];
    for (var item in searchItem) {
      if (item.split('/').last.toLowerCase().contains(query.toLowerCase())) {
        matchItem.add(item);
      }
    }
    return query.isEmpty || matchItem.isEmpty
        ? Container(
            child: Center(child: Lottie.asset('asset/searching.json')),
          )
        : ListView.separated(
            itemCount: matchItem.length,
            itemBuilder: (context, index) {
              var file = File(matchItem[index]);
              var result = matchItem[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  textColor: Colors.white,
                  tileColor: const Color.fromARGB(255, 3, 31, 71),
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
                  title: (Text(
                    result.toString().split('/').last,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(color: Colors.white),
                    //  style: mainTextStyle,
                  )),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => VideoItems2(
                          videoPlayerController:
                              VideoPlayerController.file(file),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(thickness: 0),
          );
  }
}
