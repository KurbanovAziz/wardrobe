import 'dart:io';

import 'package:closet_my_wardrobe_40_a/closet/models/brindi_enum.dart';
import 'package:closet_my_wardrobe_40_a/closet/models/garderob_model.dart';
import 'package:closet_my_wardrobe_40_a/lsc/cmw_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GarderobDetailScreen extends StatelessWidget {
  const GarderobDetailScreen({super.key, required this.garderob});
  final GarderobModel garderob;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Clothes',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: CMWColor.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.file(
                      File(garderob.garderobImage),
                      fit: BoxFit.fitHeight,
                      height: 285.h,
                      width: 300.h,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  garderob.garderobName,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: CMWColor.black,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      garderob.garderobBrindiType.getImya(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: CMWColor.black,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '${garderob.garderobWhereToWear.getImya()} / ${garderob.garderobHowToWear}',
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: CMWColor.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: CMWColor.black,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            padding: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(width: 2, color: CMWColor.grey1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: Text(
                                garderob.garderobCategory.getImya(),
                                style: TextStyle(
                                  color: CMWColor.blue6193F3,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 29.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Style',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: CMWColor.black,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            padding: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(width: 2, color: CMWColor.grey1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: Text(
                                garderob.garderobStyle.getImya(),
                                style: TextStyle(
                                  color: CMWColor.blue6193F3,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text('Special notes',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: CMWColor.black)),
                SizedBox(height: 10.h),
                if (garderob.garderobNote.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: CMWColor.grey1)),
                    child: Text(
                      garderob.garderobNote,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: CMWColor.black),
                    ),
                  ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
