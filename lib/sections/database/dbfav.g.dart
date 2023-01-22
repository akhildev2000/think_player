// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbfav.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoModelAdapter extends TypeAdapter<VideoModel> {
  @override
  final int typeId = 1;

  @override
  VideoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoModel(
      file: fields[3] as dynamic,
      id: fields[0] as int?,
      isFav: fields[4] as bool?,
      name: fields[1] as String,
      path: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VideoModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.path)
      ..writeByte(3)
      ..write(obj.file)
      ..writeByte(4)
      ..write(obj.isFav);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PalylistmodelAdapter extends TypeAdapter<Palylistmodel> {
  @override
  final int typeId = 2;

  @override
  Palylistmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Palylistmodel(
      name: fields[1] as String,
      path: (fields[2] as List).cast<String>(),
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Palylistmodel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PalylistmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
