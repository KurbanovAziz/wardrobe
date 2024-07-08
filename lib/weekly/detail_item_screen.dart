import 'dart:convert';
import 'dart:math';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../event_bus.dart';
import '../infrastructure/resources/app_colors.dart';
import '../infrastructure/resources/app_styles.dart';
import 'category/models/detail_clothes_model.dart';
import 'category/models/detail_odejda_model.dart';

class DetailItemScreen extends StatefulWidget {
  const DetailItemScreen({
    super.key,
    required this.id,
    required this.image,
    required this.nazvanie,
  });

  final String id;
  final String nazvanie;
  final List<String> image;

  @override
  State<DetailItemScreen> createState() => _DetailItemScreenState();
}

class _DetailItemScreenState extends State<DetailItemScreen> {
  var data2 = GetIt.I<Box<DetailClothesModel>>();
  var data = GetIt.I.get<Box<Detailodejdamodel>>();
  List<Detailodejdamodel> lists = [];
  final event = GetIt.I<EventBus>();

  @override
  void initState() {
    super.initState();
    event.on<UpdateList>().listen((event) {
      loadData();
      setState(() {});
    });
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      lists = data.values.toList();
    });
  }

  List<String> possibleNames = [
    'Shirt',
    'Pants',
    'Jacket',
    'Skirt',
    'Dress',
    'Shorts',
    'Sweater',
    'Coat',
    'Blouse',
    'Jeans',
    'T-Shirt',
    'Cardigan',
    'Vest',
    'Scarf',
    'Hat',
    'Gloves',
    'Socks',
    'Shoes',
    'Sandals',
    'Boots'
  ];

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.nazvanie,
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: GridView.builder(
        itemCount: widget.image.length,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 11.w,
          childAspectRatio: 166.w / 259.h,
        ),
        itemBuilder: (BuildContext context, int index) {
          String randomName = possibleNames[random.nextInt(possibleNames.length)];
          return ClothesInfoCard(
            asset: widget.image[index],
            name: randomName,
          );
        },
      ),
    );
  }
}

class ClothesInfoCard extends StatelessWidget {
  const ClothesInfoCard({
    super.key,
    required this.asset,
    required this.name,
  });

  final String asset;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: 166.w,
      height: 259.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.blue),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.memory(
            base64Decode(asset),
            fit: BoxFit.cover,
            width: 134.w,
            height: 190.h,
          ),
          Text(
            name,
            style: AppStyles.helper2.copyWith(
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
