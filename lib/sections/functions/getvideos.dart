import 'dart:io';

import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:think_player/main.dart';
import 'package:think_player/sections/database/dbfav.dart';
import 'package:think_player/sections/database/dbfav_fun.dart';

class GetVideos extends ChangeNotifier {
  Future getVideos(context) async {
    FetchAllVideos ob = FetchAllVideos();
    videos = await ob.getAllVideos();
    videos = videos.toSet().toList();
    for (int i = 0; i < videos.length; i++) {
      VideoModel videoD = VideoModel(
          name: videos[i].split('/').last,
          path: videos[i],
          file: File(
            videos[i],
          ));
      await Provider.of<DbFunction>(context, listen: false).addVideo(videoD);
      if (i == 10) {
        Provider.of<DbFunction>(context, listen: false).notifyListeners();
      } else {
        continue;
      }
    }
    Provider.of<DbFunction>(context, listen: false).notifyListeners();
    notifyListeners();
  }
}
