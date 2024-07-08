import 'package:closet_my_wardrobe_40_a/lsc/cmw_color.dart';
import 'package:closet_my_wardrobe_40_a/weekly/add_image_screen.dart';
import 'package:closet_my_wardrobe_40_a/weekly/category/clothes_category_screen.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../event_bus.dart';
import 'category/models/detail_odejda_model.dart';
import 'empty_screen.dart';

class WeeklyScreen extends StatefulWidget {
  const WeeklyScreen({super.key});

  @override
  State<WeeklyScreen> createState() => _WeeklyScreenState();
}

class _WeeklyScreenState extends State<WeeklyScreen> {
  var data = GetIt.I.get<Box<Detailodejdamodel>>();

  List<Detailodejdamodel> lists = [];
  bool showAdd = false;
  bool showCategoryScreen = false; // новое состояние для отслеживания экрана
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
      if (lists.isNotEmpty) {
        showCategoryScreen= false;
      }
    });
  }

  void toggleScreen() {
    setState(() {
      showCategoryScreen = !showCategoryScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          showCategoryScreen || lists.isNotEmpty
              ? 'Clothes for the week'
              : 'Image for the week',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: CMWColor.black,
          ),
        ),
      ),
      body: lists.isEmpty
          ? (showAdd
              ? AddImageScreen(
                  click: toggleScreen,
                )
              : EmptyScreen(click: () {
                  setState(() {
                    showAdd = !showAdd;
                    showCategoryScreen = false; // сброс состояния
                  });
                }))
          : (showCategoryScreen
              ? AddImageScreen(
                  click: toggleScreen,
                )
              : ClothesCategoryScreen(
                  clickOnItem: () {

                  },
                  addAn: toggleScreen,
                )),
    );
  }
}
