import 'package:closet_my_wardrobe_40_a/lsc/cmw_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../closet/models/brindi_enum.dart';
import '../lsc/cmw_mot.dart';

import '../weekly/empty_screen.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  bool listEmpty = true;
  bool addImage = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Articles from fashion',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: CMWColor.black,
            ),
          ),
        ),
        // body: AddImageScreen()//ClothesCategoryScreen(),
      // ? addImage
      //     ? AddImageScreen()
      //     : EmptyScreen(
      //         click: () {
      //           setState(() {
      //             addImage = !addImage;
      //           });
      //         },
      //       )
      // : SizedBox(),
    );
  }
}
