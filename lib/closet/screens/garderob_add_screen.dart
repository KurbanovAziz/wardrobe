// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:closet_my_wardrobe_40_a/closet/models/brindi_enum.dart';
import 'package:closet_my_wardrobe_40_a/closet/models/garderob_model.dart';
import 'package:closet_my_wardrobe_40_a/closet/widget/cuper_dialogo.dart';
import 'package:closet_my_wardrobe_40_a/lsc/cmw_botom.dart';
import 'package:closet_my_wardrobe_40_a/lsc/cmw_color.dart';
import 'package:closet_my_wardrobe_40_a/lsc/cmw_mot.dart';
import 'package:dropdown_flutter/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class GarderobAddScreen extends StatefulWidget {
  const GarderobAddScreen({super.key});

  @override
  State<GarderobAddScreen> createState() => _GarderobAddScreenState();
}

class _GarderobAddScreenState extends State<GarderobAddScreen> {
  final TextEditingController _garderobNameController = TextEditingController();
  final TextEditingController _garderobHowToWearController =
      TextEditingController();
  final TextEditingController _garderobNotesController =
      TextEditingController();

  File? garderobImage;

  BrindiType? brindiType;
  WhereToWear? whereToWear;
  GarderobCategory? garderobCategory;
  GarderobStyle? garderobStyle;

  bool get isZapoln =>
      _garderobNameController.text.isNotEmpty &&
      _garderobHowToWearController.text.isNotEmpty &&
      garderobImage != null &&
      brindiType != null &&
      garderobStyle != null &&
      garderobCategory != null;

  Future<void> _onSohran() async {
    if (isZapoln && garderobImage != null) {
      try {
        File file = File(garderobImage!.path);
        String kartNma = file.path.split('/').last;
        Directory papik = await getApplicationDocumentsDirectory();
        String patuu = papik.path;

        String destinationPathee = '$patuu/$kartNma';

        File newFileddd = await file.copy(destinationPathee);
        final newGarderob = GarderobModel(
            garderobName: _garderobNameController.text,
            garderobBrindiType: brindiType ?? BrindiType.values.first,
            garderobWhereToWear: whereToWear ?? WhereToWear.values.first,
            garderobHowToWear: _garderobHowToWearController.text,
            garderobCategory: garderobCategory ?? GarderobCategory.values.first,
            garderobStyle: garderobStyle ?? GarderobStyle.values.first,
            garderobNote: _garderobNotesController.text,
            garderobImage: newFileddd.path);
        final box = await Hive.openBox<GarderobModel>('garderobModel');

        await box.put(DateTime.now().toIso8601String(), newGarderob);

        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const CMWBotomBar(
                indexScr: 0,
              ),
            ),
            (route) => false,
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        imageQuality: 100,
        maxHeight: 640,
        maxWidth: 360,
      );
      if (image == null) {
        return;
      }
      final File img = File(image.path);
      setState(() {
        garderobImage = img;
      });
    } on PlatformException {
      //for IOS exception
      if (await Permission.camera.isPermanentlyDenied ||
          await Permission.photos.isPermanentlyDenied ||
          await Permission.camera.isDenied) {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) => CuperDialogo(
            nAme: 'Access to Photos has been denied',
            descRtony: 'Allow access in settings to upload photos',
            bttnImya: 'Settings',
            onNajat: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CMWMoti(
        onPressed: () {
          if (isZapoln) {
            _onSohran();
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 13.h),
          decoration: BoxDecoration(
            color: isZapoln ? CMWColor.blue : CMWColor.grey1,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_circle_outline,
                color: Colors.white,
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                'Add clothes',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: CMWColor.white,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Add clothes',
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
                if (garderobImage == null)
                  Row(
                    children: [
                      Expanded(
                        child: CMWMoti(
                          onPressed: () {
                            _pickImage(ImageSource.camera);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: CMWColor.blue9EBCF6),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Center(
                              child: Text(
                                'Camera',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: CMWColor.blue9EBCF6,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16.r,
                      ),
                      Expanded(
                        child: CMWMoti(
                          onPressed: () {
                            _pickImage(ImageSource.gallery);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: CMWColor.blue9EBCF6),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Center(
                              child: Text(
                                'Photo gallery',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: CMWColor.blue9EBCF6,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (garderobImage != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Photo',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: CMWColor.black),
                      ),
                      CMWMoti(
                        onPressed: () {
                          _pickImage(ImageSource.gallery);
                        },
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Image.file(
                              garderobImage!,
                              fit: BoxFit.cover,
                              width: 190.w,
                              height: 164.h,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 16.h,
                ),
                Text('Name',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: CMWColor.black)),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: _garderobNameController,
                  textCapitalization: TextCapitalization.words,
                  cursorColor: CMWColor.black,
                  style: TextStyle(
                    color: CMWColor.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: CMWColor.white,
                    hintStyle: TextStyle(
                      color: CMWColor.grey1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: CMWColor.grey1),
                      borderRadius: BorderRadius.circular(16.0.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0.r),
                      borderSide: const BorderSide(
                        color: CMWColor.grey1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0.r),
                      borderSide: const BorderSide(
                        color: CMWColor.grey1,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(16.r),
                    hintText: "Name",
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text('Brand',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: CMWColor.black)),
                SizedBox(
                  height: 10.h,
                ),
                DropdownFlutter<String>.search(
                  closedHeaderPadding: REdgeInsets.all(18.r),
                  hintText: 'Brand',
                  searchHintText: 'Search across 70 brands',
                  decoration: CustomDropdownDecoration(
                    expandedBorder: Border.all(color: CMWColor.blue9EBCF6),
                    searchFieldDecoration: SearchFieldDecoration(
                      hintStyle: TextStyle(
                        color: CMWColor.blue9EBCF6,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0.r),
                        borderSide: const BorderSide(
                          color: CMWColor.blue9EBCF6,
                        ),
                      ),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0.r),
                        borderSide: const BorderSide(
                          color: CMWColor.blue9EBCF6,
                        ),
                      ),
                    ),
                    headerStyle: TextStyle(
                      color: CMWColor.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    hintStyle: TextStyle(
                      color: CMWColor.grey1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    closedBorder: Border.all(color: CMWColor.grey1),
                  ),
                  items: BrindiType.values
                      .map(
                        (e) => e.getImya(),
                      )
                      .toList(),
                  initialItem: brindiType?.getImya(),
                  overlayHeight: 342.h,
                  onChanged: (value) {
                    brindiType = BrindiType.values
                        .where(
                          (element) => element.getImya() == value,
                        )
                        .firstOrNull;
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text('Where to wear',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: CMWColor.black)),
                SizedBox(
                  height: 10.h,
                ),
                DropdownFlutter<String>.search(
                  closedHeaderPadding: REdgeInsets.all(18.r),
                  hintText: 'Where to wear',
                  searchHintText: 'Search',
                  decoration: CustomDropdownDecoration(
                    expandedBorder: Border.all(color: CMWColor.blue9EBCF6),
                    searchFieldDecoration: SearchFieldDecoration(
                      hintStyle: TextStyle(
                        color: CMWColor.blue9EBCF6,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0.r),
                        borderSide: const BorderSide(
                          color: CMWColor.blue9EBCF6,
                        ),
                      ),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0.r),
                        borderSide: const BorderSide(
                          color: CMWColor.blue9EBCF6,
                        ),
                      ),
                    ),
                    headerStyle: TextStyle(
                      color: CMWColor.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    hintStyle: TextStyle(
                      color: CMWColor.grey1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    closedBorder: Border.all(color: CMWColor.grey1),
                  ),
                  items: WhereToWear.values
                      .map(
                        (e) => e.getImya(),
                      )
                      .toList(),
                  initialItem: whereToWear?.getImya(),
                  overlayHeight: 342.h,
                  onChanged: (value) {
                    whereToWear = WhereToWear.values
                        .where(
                          (element) => element.getImya() == value,
                        )
                        .firstOrNull;
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text('How to wear',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: CMWColor.black)),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: _garderobHowToWearController,
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: CMWColor.black,
                  style: TextStyle(
                    color: CMWColor.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: CMWColor.white,
                    hintStyle: TextStyle(
                      color: CMWColor.grey1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: CMWColor.grey1),
                      borderRadius: BorderRadius.circular(16.0.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0.r),
                      borderSide: const BorderSide(
                        color: CMWColor.grey1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0.r),
                      borderSide: const BorderSide(
                        color: CMWColor.grey1,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(16.r),
                    hintText: "Name",
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text('Select a category',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: CMWColor.black)),
                SizedBox(height: 10.h),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: GarderobCategory.values.length,
                  itemBuilder: (context, index) {
                    final category = GarderobCategory.values[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          garderobCategory = category;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: garderobCategory == category
                              ? CMWColor.blue6193F3
                              : Colors.white,
                          border: Border.all(
                              width: 2,
                              color: garderobCategory == category
                                  ? CMWColor.blue6193F3
                                  : CMWColor.grey1),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Text(
                            category.getImya(),
                            style: TextStyle(
                              color: garderobCategory == category
                                  ? Colors.white
                                  : CMWColor.blue6193F3,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text('Select a style',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: CMWColor.black)),
                SizedBox(height: 10.h),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: GarderobStyle.values.length,
                  itemBuilder: (context, index) {
                    final sityle = GarderobStyle.values[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          garderobStyle = sityle;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: garderobStyle == sityle
                              ? CMWColor.blue6193F3
                              : Colors.white,
                          border: Border.all(
                              width: 2,
                              color: garderobStyle == sityle
                                  ? CMWColor.blue6193F3
                                  : CMWColor.grey1),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Text(
                            sityle.getImya(),
                            style: TextStyle(
                              color: garderobStyle == sityle
                                  ? Colors.white
                                  : CMWColor.blue6193F3,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
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
                Container(
                  padding: EdgeInsets.all(16.r),
                  constraints:
                      BoxConstraints(minHeight: 108.h, maxHeight: 300.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: CMWColor.grey1)),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: _garderobNotesController,
                    maxLines: 6,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: CMWColor.black,
                    style: TextStyle(
                      color: CMWColor.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: CMWColor.white,
                      hintStyle: TextStyle(
                        color: CMWColor.grey1,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(0.r),
                      hintText: "Name",
                    ),
                  ),
                ),
                SizedBox(
                  height: 100.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
