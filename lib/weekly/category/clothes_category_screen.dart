import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:closet_my_wardrobe_40_a/event_bus.dart';
import 'package:closet_my_wardrobe_40_a/weekly/detail_item_screen.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../../infrastructure/resources/app_colors.dart';
import '../../infrastructure/resources/app_styles.dart';
import '../../lsc/cmw_color.dart';
import '../../lsc/cmw_mot.dart';
import '../add_image_screen.dart';
import '../izmenenie_s_creen.dart';
import 'models/detail_odejda_model.dart';

class ClothesCategoryScreen extends StatefulWidget {
  ClothesCategoryScreen({
    super.key,
    required this.addAn,
    required this.clickOnItem,
  });

  Function() addAn;
  Function() clickOnItem;

  @override
  State<ClothesCategoryScreen> createState() => _ClothesCategoryScreenState();
}

class _ClothesCategoryScreenState extends State<ClothesCategoryScreen> {
  var data = GetIt.I.get<Box<Detailodejdamodel>>();

  List<Detailodejdamodel> lists = [];
  final event = GetIt.I<EventBus>();
  File? _image;

  final picker = ImagePicker();
  List<bool> actionList = [];

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
      actionList = List.generate(lists.length, (index) => false);
    });
  }

  void showAction(int index) {
    for (int i = 0; actionList.length > i; i++) {
      if (i == index) {
        actionList[i] = true;
      } else {
        actionList[i] = false;
      }
    }
    setState(() {});
  }

  bool check() {
    for (int i = 0; actionList.length > i; i++) {
      if (actionList[i] == true) {
        return false;
      }
    }
    return true;
  }

  void setFalse() {
    for (int i = 0; actionList.length > i; i++) {
      actionList[i] = false;
    }
    setState(() {});
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        setImage();
      });
    }
  }

  Future<String> setImage() async {
    if (_image != null) {
      final bytes = await _image!.readAsBytes();
      stringImageForSaveAndroid = base64Encode(bytes);
      return base64Encode(bytes);
    }
    return '';
  }

  String stringImageForSaveAndroid = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15.h),
        Expanded(
          child: GridView.builder(
            itemCount: lists.length,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20.h,
              crossAxisSpacing: 16.w,
              childAspectRatio: 165.w / 196.h,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  ClothesCard(
                    izmeni: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                IzmenenieSCreen(model: lists[index])),
                      );
                      // AddImageScreen
                    },
                    deleteTochno: () {
                      data.delete(lists[index].id);
                      setFalse();
                      loadData();
                      setState(() {});
                    },
                    showAction: actionList[index],
                    delete: () => showAction(index),
                    onTap: () {
                      if (!check()) {
                        setFalse();
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailItemScreen(
                                    id: lists[index].id,
                                    image: lists[index].image,
                                    nazvanie: lists[index].namess,
                                  )),
                        );
                      }
                    },
                    name: lists[index].namess,
                    asset1: lists[index].image[0],
                    asset2: lists[index].image.length > 2
                        ? lists[index].image[2]
                        : lists[index].image[0],
                    asset3: lists[index].image.length > 3
                        ? lists[index].image[3]
                        : lists[index].image[0],
                    addImage: () async {
                      _pickImage(ImageSource.gallery);
                      List<String> list = lists[index].image;
                      list.removeWhere((element) => element.isEmpty);
                      list.add(stringImageForSaveAndroid);
                      data.put(
                          lists[index].id,
                          Detailodejdamodel(
                              image: list,
                              id: lists[index].id,
                              namess: lists[index].namess));
                      setState(() {});
                    },
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(height: 12.h),
        CMWMoti(
          onPressed: widget.addAn,
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
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
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}

class ClothesCard extends StatelessWidget {
  ClothesCard({
    super.key,
    required this.name,
    required this.asset1,
    required this.asset2,
    required this.asset3,
    required this.delete,
    required this.addImage,
    required this.showAction,
    required this.deleteTochno,
    required this.izmeni,
    this.onTap,
  });

  final String name;
  final String asset1;
  final String asset2;
  final String asset3;
  final VoidCallback? onTap;
  Function() delete;
  Function() addImage;
  Function() deleteTochno;
  Function() izmeni;
  bool showAction;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.blue),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 110.sp,
                        child: AutoSizeText(
                          name,
                          maxLines: 1,
                          style: AppStyles.helper2,
                        ),
                      ),
                      GestureDetector(
                        onTap: delete,
                        child: const Icon(Icons.more_vert_outlined),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                asset2.isEmpty  ? base64Decode(asset2) :  base64Decode(asset2),
                                fit: BoxFit.cover,
                                width: 56.w,
                                height: 56.h,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                base64Decode(asset2),
                                fit: BoxFit.cover,
                                width: 56.w,
                                height: 56.h,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                asset3.isEmpty  ? base64Decode(asset1) :  base64Decode(asset3),
                                fit: BoxFit.cover,
                                width: 56.w,
                                height: 56.h,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            GestureDetector(
                              onTap: addImage,
                              child: SizedBox(
                                width: 56.w,
                                height: 56.h,
                                child: const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
            right: 40.w,
            top: 20.h,
            child: Visibility(
              visible: showAction,
              child: Container(
                width: 72.w,
                height: 44.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.blue),
                    color: Colors.white),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: izmeni,
                      child: Text(
                        'Edit',
                        style: AppStyles.helper3
                            .copyWith(color: AppColors.blueAccent),
                      ),
                    ),
                    GestureDetector(
                      onTap: deleteTochno,
                      child: Text(
                        'Delete',
                        style: AppStyles.helper3
                            .copyWith(color: AppColors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}

//
// Future<void> _buildShowDialog(BuildContext context) {
//   return showDialog(
//     useSafeArea: true,
//     barrierDismissible: true,
//     barrierColor: Colors.transparent,
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog(
//         insetPadding: const EdgeInsets.only(top: 70, left: 80, right: 260),
//         alignment: Alignment.topLeft,
//         child: Container(
//           width: 72.w,
//           height: 44.h,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(4),
//               border: Border.all(color: AppColors.blue),
//               color: Colors.white),
//           child: Column(
//             children: [
//               Text(
//                 'Edit',
//                 style: AppStyles.helper3.copyWith(color: AppColors.blueAccent),
//               ),
//               Text(
//                 'Delete',
//                 style: AppStyles.helper3.copyWith(color: AppColors.blueAccent),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
