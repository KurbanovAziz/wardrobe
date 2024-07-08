import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../lsc/cmw_color.dart';

class EmptyScreen extends StatelessWidget {
  EmptyScreen({
    super.key,
    required this.click,
  });

  Function() click;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/dress.svg'),
              SizedBox(height: 8.h),
              Text(
                'You still have no image for the week',
                style: TextStyle(fontSize: 16.sp, color: CMWColor.blue9EBCF6),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: click,
              child: Container(
                margin: const EdgeInsets.all(16),
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: CMWColor.blue,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset('assets/icons/plus.svg'),
                    SizedBox(width: 8.w),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 14.0.h),
                      child: Text(
                        'Add an outfit',
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ))
      ],
    );
  }
}

