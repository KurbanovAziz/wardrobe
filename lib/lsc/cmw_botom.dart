import 'package:closet_my_wardrobe_40_a/closet/closet_screen.dart';
import 'package:closet_my_wardrobe_40_a/%D1%81ustomization/customization_screen.dart';
import 'package:closet_my_wardrobe_40_a/article/article_screen.dart';
import 'package:closet_my_wardrobe_40_a/lsc/cmw_color.dart';
import 'package:closet_my_wardrobe_40_a/lsc/cmw_mot.dart';
import 'package:closet_my_wardrobe_40_a/weekly/weekly_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CMWBotomBarState extends State<CMWBotomBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.indexScr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Container(
          height: 130.h,
          width: MediaQuery.of(context).size.width,
          color: CMWColor.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: buildNavItem(
                0,
                'assets/icons/btm1.svg',
              )),
              Expanded(
                  child: buildNavItem(
                1,
                'assets/icons/btm2.svg',
              )),
              Expanded(
                  child: buildNavItem(
                2,
                'assets/icons/btm3.svg',
              )),
              Expanded(
                  child: buildNavItem(
                3,
                'assets/icons/btm4.svg',
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(
    int index,
    String iconPath,
  ) {
    return CMWMoti(
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color:
                  _currentIndex == index ? CMWColor.blue : CMWColor.blue9EBCF6,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: 24.r,
                height: 24.r,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final _pages = <Widget>[
    ClosetScreen(),
    WeeklyScreen(),
    ArticleScreen(),
    CustomizationScreen(),
  ];
}

class CMWBotomBar extends StatefulWidget {
  const CMWBotomBar({super.key, this.indexScr = 0});
  final int indexScr;

  @override
  State<CMWBotomBar> createState() => CMWBotomBarState();
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CMWBotomBar(),
    );
  }
}
