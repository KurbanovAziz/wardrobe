// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_clothes_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailClothesModelAdapter extends TypeAdapter<DetailClothesModel> {
  @override
  final int typeId = 6;

  @override
  DetailClothesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailClothesModel(
      id: fields[0] as String,
      image: fields[1] as String,
      title: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DetailClothesModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailClothesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
