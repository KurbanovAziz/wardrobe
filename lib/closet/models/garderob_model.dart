// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:closet_my_wardrobe_40_a/closet/models/brindi_enum.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'garderob_model.g.dart';

@HiveType(typeId: 4)
class GarderobModel {
  @HiveField(0)
  final String garderobName;
  @HiveField(1)
  final BrindiType garderobBrindiType;
  @HiveField(2)
  final WhereToWear garderobWhereToWear;
  @HiveField(3)
  final String garderobHowToWear;
  @HiveField(4)
  final GarderobCategory garderobCategory;
  @HiveField(5)
  final GarderobStyle garderobStyle;
  @HiveField(6)
  final String garderobNote;
  @HiveField(7)
  final String garderobImage;
  GarderobModel({
    required this.garderobName,
    required this.garderobBrindiType,
    required this.garderobWhereToWear,
    required this.garderobHowToWear,
    required this.garderobCategory,
    required this.garderobStyle,
    required this.garderobNote,
    required this.garderobImage,
  });
}
