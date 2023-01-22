import 'dart:io';
import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:think_player/main.dart';
import 'package:think_player/sections/database/dbfav.dart';
import 'package:think_player/sections/database/dbfav_fun.dart';
import 'package:think_player/sections/favourites.dart';
import 'package:think_player/sections/search.dart';

import 'package:think_player/sections/video_screen.dart';
import 'package:think_player/widgets/select_palylist.dart';
import 'package:think_player/widgets/sortfun.dart';
import 'package:video_player/video_player.dart';

import '../widgets/create_playlist.dart';

List<String> searchItem = [];
List<VideoModel> sortedList = [];
String? sortOrder;
int _selectedItemPosition = 0;

class VideoList extends StatefulWidget {
  const VideoList({
    super.key,
  });

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  List videos = [];
  @override
  void initState() {
    getVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    videoListNotifer.value.toSet().toList();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: Column(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 11, left: 30),
              child: Icon(Icons.video_collection, size: 27),
            )
          ],
        ),
        title: const Padding(
          padding: EdgeInsets.only(right: 30),
          child: Text(
            "Think Player",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        actions: [
          Stack(
            children: [
              _selectedItemPosition == 0
                  ? DropdownButton(
                      underline: Container(),
                      items: sort.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      icon: Icon(
                        Icons.sort,
                        color: Theme.of(context).iconTheme.color,
                        size: 25,
                      ),
                      onChanged: (value) {
                        setState(() {
                          sortOrder = value;
                        });
                        //print(value);
                      },
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 25,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      //backgroundColor: const Color.fromARGB(255, 3, 31, 71),
      body: ValueListenableBuilder(
          valueListenable: videoListNotifer,
          builder: (BuildContext context, List<VideoModel> videoList,
              Widget? child) {
            if (sortOrder == 'Name (a to z)') {
              sortedList = SortFunctions().sortAtoZ(videoList);
            } else if (sortOrder == 'Name (z to a)') {
              sortedList = SortFunctions().sortZtoA(videoList);
            } else {
              sortedList = videoList;
            }
            return videoList.isEmpty
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 120, left: 75),
                        child: Lottie.asset('asset/loading_home.json',
                            height: 250),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 65),
                        child: Text('Fetching Videos',
                            style: GoogleFonts.merriweatherSans(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 25)),
                      )
                    ],
                  )
                : ListView.builder(
                    itemBuilder: ((context, index) {
                      if (searchItem.length <= index) {
                        searchItem.add(videoList[index].path);
                      } else {
                        searchItem[index] = videoList[index].path;
                      }
                      bool check =
                          DbFunction().contentCheck(videoList[index].path);
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
                            onPressed: (() async {
                              bool check = DbFunction()
                                  .contentCheck(videoList[index].path);
                              if (videoList[index].isFav != true && !check) {
                                videoList[index].isFav = true;
                                setState(() {});
                                final favDetails = VideoModel(
                                    path: videoList[index].path,
                                    name: videoList[index].path.split('/').last,
                                    file: videoList[index].file.toString(),
                                    id: videoList[index].id);
                                DbFunction().addFav(favDetails);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(milliseconds: 120),
                                    content: Text('Added to Favourites'),
                                  ),
                                );
                                setState(() {});
                              } else {
                                int? tempindex = DbFunction()
                                    .removeIndex(videoList[index].path);
                                if (tempindex != null) {
                                  videoList[index].isFav = false;
                                  DbFunction().removeFav(tempindex);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(milliseconds: 120),
                                      content: Text('Removed From Favourites'),
                                    ),
                                  );
                                  setState(() {});
                                }
                              }
                            }),
                            icon: !check
                                ? const Icon(
                                    Icons.favorite_border_outlined,
                                  )
                                : const Icon(Icons.favorite),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25)),
                          ),
                          title: Text(sortedList[index].name,
                              maxLines: 1,
                              style: GoogleFonts.merriweatherSans(
                                  fontWeight: FontWeight.w500)),
                          onTap: () {
                            //final File tempFile = File('/${videos[index]}');
                            playerID = videoPlayerCheck(0);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoItems(
                                  contentFiles: videoList,
                                  index: index,
                                ),
                              ),
                            );
                          },
                          onLongPress: () {
                            listofplaylist(index, context, videoList);
                          },
                        ),
                      );
                    }),
                    itemCount: videoList.length,
                  );
          }),
    );
  }
}

listofplaylist(index, context, videolist) {
  int playindex = index;
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: SizedBox(
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  textColor: Colors.white,
                  tileColor: const Color.fromARGB(255, 3, 31, 71),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                  ),
                  leading: const Icon(
                    Icons.playlist_add,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text('Add To Playlist',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                  onTap: () {
                    selectPlaylist(context, videolist, playindex);
                    //print(videolist);
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                    textColor: Colors.white,
                    tileColor: const Color.fromARGB(255, 3, 31, 71),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                    ),
                    leading: const Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                    ),
                    title: Text('Create New Playlist',
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                    onTap: () {
                      Navigator.pop(context);
                      createPlaylist(context);
                    }),
              ),
            ],
          ),
        ),
      );
    },
  );
}
