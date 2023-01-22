// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:hive/hive.dart';
part 'dbfav.g.dart';

@HiveType(typeId: 1)
class VideoModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String path;
  @HiveField(3)
  var file;
  @HiveField(4)
  bool? isFav;
  VideoModel({
    required this.file,
    this.id,
    this.isFav,
    required this.name,
    required this.path,
  });
}

@HiveType(typeId: 2)
class Palylistmodel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  List<String> path;
  Palylistmodel({
    required this.name,
    required this.path,
    this.id,
  });
}
