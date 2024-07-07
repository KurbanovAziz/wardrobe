import 'package:closet_my_wardrobe_40_a/lsc/cmw_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CuperDialogo extends StatelessWidget {
  const CuperDialogo({
    super.key,
    required this.onNajat,
    required this.nAme,
    required this.descRtony,
    required this.bttnImya,
  });
  final String nAme;
  final String descRtony;
  final String bttnImya;
  final Function() onNajat;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        nAme,
        style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: CMWColor.black),
      ),
      content: Padding(
        padding: EdgeInsets.only(top: 8.0.h),
        child: Text(
          descRtony,
          style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: CMWColor.black),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text(
            'Cancel',
            style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w400,
                color: CMWColor.buttonBlue),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text(
            bttnImya,
            style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: CMWColor.buttonBlue),
          ),
          onPressed: () async {
            onNajat();
          },
        ),
      ],
    );
  }
}
