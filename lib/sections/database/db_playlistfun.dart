import 'package:flutter/material.dart';

import 'package:think_player/main.dart';
import 'package:think_player/sections/database/dbfav.dart';

import 'dbfav_fun.dart';

ValueNotifier<List<Palylistmodel>> playListNotifier = ValueNotifier([]);

class PlayDb {
  DbFunction favObj = DbFunction();
  Future<void> addPlay(Palylistmodel value, currentname) async {
    final videoDB = await myhivebox2('playlist');
    bool notFound = false;
    if (currentname != null) {
      for (int i = 0; i < videoDB.length; i++) {
        if (videoDB.values.elementAt(i).name == currentname) {
          videoDB.putAt(i, value);
          notFound = true;
          break;
        }
      }
    }
    if (!notFound) {
      //print(value.path);
      videoDB.add(value);
      playListNotifier.value.add(value);
    }
    // print(value.name);
    playListNotifier.notifyListeners();
    DbFunction().getAllVideos();
  }

  addPlay2(name, list) async {
    final videoDB = await myhivebox2('playlist');
    dynamic val = Palylistmodel(name: name, path: list);

    for (int i = 0; i < videoDB.length; i++) {
      if (videoDB.values.elementAt(i).name == name) {
        videoDB.putAt(i, val);

        playListNotifier.value[i] = val;
        //playListNotifier.value.add(val);
        playListNotifier.notifyListeners();
      }
    }
    playListNotifier.notifyListeners();
    DbFunction().getAllVideos();
  }

  bool contentCheck(path) {
    bool result = false;
    for (int i = 0; i < favObj.favListNotifier.length; i++) {
      if (favObj.favListNotifier[i].path == path) {
        result = true;
      }
      if (result == true) {
        break;
      }
    }
    return result;
  }

  bool contentPlayCheck(path, i) {
    bool result = false;
    for (int j = 0; j < playListNotifier.value[i].path.length; j++) {
      if (playListNotifier.value[i].path[j] == path) {
        result = true;
      }
      if (result == true) {
        break;
      }
    }
    return result;
  }

  Future<void> removePlay(index) async {
    final videoDB = await myhivebox2('playlist');
    // await videoDB.deleteAt(id);
    await videoDB.deleteAt(index);
    playListNotifier.notifyListeners();

    DbFunction().getAllVideos();
  }

  bool contentPlayNameCheck(name) {
    bool result = false;
    for (int i = 0; i < playListNotifier.value.length; i++) {
      if (playListNotifier.value[i].name == name) {
        result = true;
      }
      if (result == true) {
        break;
      }
    }
    return result;
  }
}
