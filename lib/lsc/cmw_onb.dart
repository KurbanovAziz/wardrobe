import 'package:closet_my_wardrobe_40_a/lsc/cmw_color.dart';
import 'package:closet_my_wardrobe_40_a/lsc/cmw_mot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class CMWonBord extends StatefulWidget {
  const CMWonBord({super.key});

  @override
  State<CMWonBord> createState() => _SenseOnbState();
}

class _SenseOnbState extends State<CMWonBord> {
  final PageController _controller = PageController();
  int introIndex = 0;
  bool showIndicators = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                introIndex = index;
                if (index == 4) {
                  showIndicators = false;
                } else {
                  showIndicators = true;
                }
              });
            },
            children: const [
              
            ],
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (showIndicators)
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 18.h),
                      ),
                      CMWMoti(
                        onPressed: () {
                          if (introIndex < 2) {
                            _controller.animateToPage(
                              introIndex + 1,
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const ServiceScreen(),
                            //   ),
                            // );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Container(
                            height: 56.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: CMWColor.blue,
                              borderRadius: BorderRadius.circular(32.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: CMWColor.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
