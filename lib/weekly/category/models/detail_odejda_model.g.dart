// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_odejda_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailodejdamodelAdapter extends TypeAdapter<Detailodejdamodel> {
  @override
  final int typeId = 5;

  @override
  Detailodejdamodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Detailodejdamodel(
      id: fields[0] as String,
      image: (fields[2] as List).cast<String>(),
      namess: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Detailodejdamodel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.namess);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailodejdamodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
