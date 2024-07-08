import 'package:hive/hive.dart';

part 'detail_clothes_model.g.dart';

@HiveType(typeId: 6)
class DetailClothesModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String image;
  @HiveField(3)
  final String title;

  DetailClothesModel({
    required this.id,
    required this.image,
    required this.title,
  });
}
