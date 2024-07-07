// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garderob_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GarderobModelAdapter extends TypeAdapter<GarderobModel> {
  @override
  final int typeId = 4;

  @override
  GarderobModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GarderobModel(
      garderobName: fields[0] as String,
      garderobBrindiType: fields[1] as BrindiType,
      garderobWhereToWear: fields[2] as WhereToWear,
      garderobHowToWear: fields[3] as String,
      garderobCategory: fields[4] as GarderobCategory,
      garderobStyle: fields[5] as GarderobStyle,
      garderobNote: fields[6] as String,
      garderobImage: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GarderobModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.garderobName)
      ..writeByte(1)
      ..write(obj.garderobBrindiType)
      ..writeByte(2)
      ..write(obj.garderobWhereToWear)
      ..writeByte(3)
      ..write(obj.garderobHowToWear)
      ..writeByte(4)
      ..write(obj.garderobCategory)
      ..writeByte(5)
      ..write(obj.garderobStyle)
      ..writeByte(6)
      ..write(obj.garderobNote)
      ..writeByte(7)
      ..write(obj.garderobImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GarderobModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
