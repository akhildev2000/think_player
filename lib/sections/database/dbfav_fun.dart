import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:think_player/main.dart';
import 'package:think_player/sections/database/db_playlistfun.dart';
import 'package:think_player/sections/database/dbfav.dart';
import 'package:think_player/sections/video_list.dart';
import 'package:think_player/sections/video_screen.dart';

ValueNotifier<List<VideoModel>> favListNotifier = ValueNotifier([]);
ValueNotifier<List<VideoModel>> videoListNotifer = ValueNotifier([]);

class DbFunction {
  Future<void> addVideo(VideoModel value) async {
    bool exists = false;
    for (int i = 0; i < videoListNotifer.value.length; i++) {
      if (value.path == videoListNotifer.value[i].path) {
        exists = true;
      }
    }
    if (!exists) {
      videoListNotifer.value.add(value);
      favListNotifier.notifyListeners();
    }
  }

  Future<void> getAllVideos() async {
    final videoDB = await myhivebox('video_db');
    final playlistDB = await myhivebox2('playlist');

    videoListNotifer.notifyListeners();
    favListNotifier.value.clear();
    favListNotifier.value.addAll(videoDB.values);
    playListNotifier.value.clear();
    playListNotifier.value.addAll(playlistDB.values);
    favListNotifier.notifyListeners();
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
    favListNotifier.notifyListeners();
    getAllVideos();
  }

  Future<void> removeFav(path) async {
    final videoDB = await myhivebox('video_db');
    await videoDB.deleteAt(path);
    favListNotifier.value.removeAt(path);
    favListNotifier.notifyListeners();

    getAllVideos();
  }

  bool contentCheck(path) {
    bool result = false;
    for (int i = 0; i < favListNotifier.value.length; i++) {
      if (favListNotifier.value[i].path == path) {
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
    for (int i = 0; i < favListNotifier.value.length; i++) {
      if (favListNotifier.value[i].path == path) {
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
