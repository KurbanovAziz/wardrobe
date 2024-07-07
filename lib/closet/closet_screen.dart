import 'package:closet_my_wardrobe_40_a/closet/models/brindi_enum.dart';
import 'package:closet_my_wardrobe_40_a/closet/models/garderob_model.dart';
import 'package:closet_my_wardrobe_40_a/closet/screens/garderob_add_screen.dart';
import 'package:closet_my_wardrobe_40_a/closet/widget/garderob_data.dart';
import 'package:closet_my_wardrobe_40_a/lsc/cmw_color.dart';
import 'package:closet_my_wardrobe_40_a/lsc/cmw_mot.dart';
import 'package:closet_my_wardrobe_40_a/wardrobe_sheriperi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ClosetScreen extends StatefulWidget {
  const ClosetScreen({super.key});

  @override
  State<ClosetScreen> createState() => _ClosetScreenState();
}

class _ClosetScreenState extends State<ClosetScreen> {
  List<GarderobModel> filterrList = [];
  GarderobCategory? garderobCategory;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<GarderobModel>>(
      valueListenable: Hive.box<GarderobModel>('garderobModel').listenable(),
      builder: (context, box, _) {
        List<GarderobModel> listik = box.values.toList().cast<GarderobModel>();
        filterrList = listik;
        if (garderobCategory != null) {
          filterrList = listik
              .where(
                (element) => element.garderobCategory == garderobCategory,
              )
              .toList();
        }
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FutureBuilder(
              future: getClosetMyWardrobeGarderob(),
              builder: (context, snap) {
                final isNotGarderob =
                    snap.hasData && snap.data == false && listik.length >= 4;

                return CMWMoti(
                  onPressed: () {
                    if (isNotGarderob) {
                      //TODO nav paywall
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const OmegioScreen(),
                      //   ),
                      // );
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GarderobAddScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 60.w, vertical: 13.h),
                    decoration: BoxDecoration(
                      color: CMWColor.blue,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!isNotGarderob)
                          const Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                          ),
                        if (!isNotGarderob)
                          SizedBox(
                            width: 8.w,
                          ),
                        Text(
                          isNotGarderob ? 'Need premium' : 'Add clothes',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: CMWColor.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          appBar: AppBar(
            forceMaterialTransparency: true,
            title: Text(
              'My wardrobe',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: CMWColor.black,
              ),
            ),
          ),
          body: listik.isEmpty
              ? const PustoiGarderob()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.r),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildCategoryButton('All', listik.length, null),
                              ...GarderobCategory.values.map((category) {
                                return _buildCategoryButton(
                                  category.getImya(),
                                  listik
                                      .where(
                                        (element) =>
                                            element.garderobCategory ==
                                            category,
                                      )
                                      .toList()
                                      .length,
                                  category,
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: filterrList.length,
                            itemBuilder: (context, index) {
                              return GarderobData(
                                garderob: filterrList[index],
                              );
                            }),
                        SizedBox(
                          height: 100.h,
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildCategoryButton(
      String name, int count, GarderobCategory? kategor) {
    bool isVybr = garderobCategory == kategor;
    return GestureDetector(
      onTap: () {
        setState(() {
          garderobCategory = kategor;
        });
      },
      child: Container(
        height: 35.h,
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        margin: EdgeInsets.only(right: 4.w),
        decoration: BoxDecoration(
          color: isVybr ? CMWColor.blue : Colors.white,
          border: Border.all(
              color: isVybr ? CMWColor.blue : CMWColor.grey1, width: 2),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Text(
            '$name ($count)',
            style: TextStyle(
              color: isVybr ? Colors.white : CMWColor.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class PustoiGarderob extends StatelessWidget {
  const PustoiGarderob({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: SvgPicture.asset('assets/icons/obuv.svg')),
        SizedBox(
          height: 8.h,
        ),
        Center(
          child: Text(
            'No additional clothing',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: CMWColor.blue9EBCF6,
            ),
          ),
        ),
      ],
    );
  }
}
