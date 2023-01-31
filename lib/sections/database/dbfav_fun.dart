import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:think_player/main.dart';
import 'package:think_player/sections/database/db_playlistfun.dart';
import 'package:think_player/sections/database/dbfav.dart';
import 'package:think_player/sections/screens/video_list.dart';
import 'package:think_player/sections/functions/video_screen.dart';

//ValueNotifier<List<VideoModel>> favListNotifier = ValueNotifier([]);
//ValueNotifier<List<VideoModel>> videoListNotifer = ValueNotifier([]);

class DbFunction extends ChangeNotifier {
  List<VideoModel> videoListNotifer = [];
  List<VideoModel> favListNotifier = [];
  PlayDb playObj = PlayDb();
  Future<void> addVideo(VideoModel value) async {
    bool exists = false;
    for (int i = 0; i < videoListNotifer.length; i++) {
      if (value.path == videoListNotifer[i].path) {
        exists = true;
      }
    }
    if (!exists) {
      videoListNotifer.add(value);
      notifyListeners();
    }
  }

  Future<void> getAllVideos() async {
    final videoDB = await myhivebox('video_db');
    final playlistDB = await myhivebox2('playlist');
    // videoListNotifer.addAll(videoDB.values);
    // videoListNotifer.notifyListeners();
    favListNotifier.clear();
    favListNotifier.addAll(videoDB.values);
    playListNotifier.value.clear();
    playListNotifier.value.addAll(playlistDB.values);

    notifyListeners();
  }

  Future<void> addFav(VideoModel value) async {
    final videoDB = await myhivebox('video_db');
    final id = await videoDB.add(value);
    value.id = id;
    final data = VideoModel(
      file: value.file,
      name: value.name,
      id: id,
      path: value.path,
    );
    //print("$id ${value.file} ${value.path} ");
    await videoDB.put(id, data);
    //print(videoDB.values.length);

    getAllVideos();
    notifyListeners();
  }

  Future<void> removeFav(path) async {
    final videoDB = await myhivebox('video_db');
    await videoDB.deleteAt(path);
    favListNotifier.removeAt(path);

    getAllVideos();
    notifyListeners();
  }

  bool contentCheck(path) {
    bool result = false;
    for (int i = 0; i < favListNotifier.length; i++) {
      if (favListNotifier[i].path == path) {
        result = true;
      }
      if (result == true) {
        break;
      }
    }
    return result;
  }

  int? removeIndex(path) {
    int? result;
    for (int i = 0; i < favListNotifier.length; i++) {
      if (favListNotifier[i].path == path) {
        result = i;
      }
    }
    return result;
  }
}

clearAllDB() async {
  final videoDB = await myhivebox('video_db');
  videoDB.deleteFromDisk();
  final playlistDB = await myhivebox2('playlist');
  playlistDB.deleteFromDisk();
  DbFunction().getAllVideos();
}
