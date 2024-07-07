import 'dart:io';

import 'package:closet_my_wardrobe_40_a/closet/models/garderob_model.dart';
import 'package:closet_my_wardrobe_40_a/closet/screens/garderob_detail_screen.dart';
import 'package:closet_my_wardrobe_40_a/lsc/cmw_color.dart';
import 'package:closet_my_wardrobe_40_a/lsc/cmw_mot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GarderobData extends StatelessWidget {
  const GarderobData({super.key, required this.garderob});
  final GarderobModel garderob;

  @override
  Widget build(BuildContext context) {
    return CMWMoti(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GarderobDetailScreen(
              garderob: garderob,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: CMWColor.blue9EBCF6),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.file(
                  File(garderob.garderobImage),
                  height: 190.h,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Text(
              garderob.garderobName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: CMWColor.black),
            ),
          ],
        ),
      ),
    );
  }
}
