import 'package:think_player/sections/database/dbfav.dart';
import 'package:think_player/sections/database/dbfav_fun.dart';

var sort = [
  'Name (a to z)',
  'Name (z to a)',
];

class SortFunctions {
  List<VideoModel> sortAtoZ(List<VideoModel> list) {
    videoListNotifer;
    List<VideoModel> tempList = list;
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < list.length; j++) {
        int check = list[j].name.compareTo(list[i].name);
        if (check > 0) {
          final value = tempList[i];
          tempList[i] = tempList[j];
          tempList[j] = value;
          break;
        }
      }
    }
    return tempList;
  }

  List<VideoModel> sortZtoA(List<VideoModel> list) {
    videoListNotifer;
    List<VideoModel> tempList = list;
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < list.length; j++) {
        int check = list[j].name.compareTo(list[i].name);
        if (check > 0) {
          final value = tempList[i];
          tempList[i] = tempList[j];
          tempList[j] = value;
          break;
        }
      }
    }
    return tempList.reversed.toList();
  }
}
