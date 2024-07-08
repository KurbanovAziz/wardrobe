import 'package:hive/hive.dart';

part 'detail_odejda_model.g.dart';

@HiveType(typeId: 5)
class Detailodejdamodel {
  @HiveField(0)
  final String id;
  @HiveField(2)
  final List<String> image;
  @HiveField(3)
  final String namess;

  Detailodejdamodel(
      {required this.id, required this.image, required this.namess});
}
