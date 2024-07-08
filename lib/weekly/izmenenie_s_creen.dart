import 'dart:convert';
import 'dart:io';

import 'package:dropdown_flutter/custom_dropdown.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../closet/models/brindi_enum.dart';
import '../event_bus.dart';
import '../lsc/cmw_color.dart';
import '../lsc/cmw_mot.dart';
import '../main.dart';
import 'add_image_screen.dart';
import 'category/models/detail_odejda_model.dart';

class IzmenenieSCreen extends StatefulWidget {
  IzmenenieSCreen({super.key, required this.model});

  Detailodejdamodel model;

  @override
  State<IzmenenieSCreen> createState() => _IzmenenieSCreenState();
}

class _IzmenenieSCreenState extends State<IzmenenieSCreen> {
  @override
  File? _image;
  var data = GetIt.I.get<Box<Detailodejdamodel>>();
  final event = GetIt.I<EventBus>();

  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController howRoWearController = TextEditingController(text: '');
  String textBrand = '';
  String textWhereToWear = '';
  GarderobStyle? garderobStyle;
  List<SelectCategory> category = [
    SelectCategory(category: 'Outerwear', isSelected: false),
    SelectCategory(category: 'Underwear', isSelected: false),
    SelectCategory(category: 'Dress overalls', isSelected: false),
    SelectCategory(category: 'Shoes', isSelected: false),
    SelectCategory(category: 'Accessories', isSelected: false),
    SelectCategory(category: 'Sportswear', isSelected: false),
    SelectCategory(category: 'Homewear', isSelected: false),
  ];

  List<SelectCategory> styleList = [
    SelectCategory(category: 'Classic', isSelected: false),
    SelectCategory(category: 'Sport', isSelected: false),
    SelectCategory(category: 'Casual', isSelected: false),
    SelectCategory(category: 'Festive', isSelected: false),
    SelectCategory(category: 'Home', isSelected: false),
    SelectCategory(category: 'Outside', isSelected: false),
  ];

  void selectCategory(String cat) {
    category.forEach((element) {
      if (cat == element.category) {
        element.isSelected = true;
      } else {
        element.isSelected = false;
      }
    });
  }

  void selectStyle(String cat) {
    styleList.forEach((element) {
      if (cat == element.category) {
        element.isSelected = true;
      } else {
        element.isSelected = false;
      }
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
    setImage();
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
  void initState() {
    super.initState();
    nameController.text = widget.model.namess;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _image == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(32.r),
                        child: Image.memory(
                          base64Decode(widget.model.image[0]),
                          height: 300.h,
                          width: MediaQuery.sizeOf(context).width,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const SizedBox(),
                SizedBox(height: 12.h),
                _image != null
                    ? Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(32.r),
                            child: Image.file(
                              _image!,
                              height: 300.h,
                              width: MediaQuery.sizeOf(context).width,
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      )
                    : const SizedBox(),
                _image != null
                    ? const SizedBox()
                    : Row(
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
                                  border:
                                      Border.all(color: CMWColor.blue9EBCF6),
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
                          SizedBox(width: 16.r),
                          Expanded(
                            child: CMWMoti(
                              onPressed: () {
                                _pickImage(ImageSource.gallery);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: CMWColor.blue9EBCF6),
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
                SizedBox(height: 16.h),
                TextFormField(
                  onChanged: (value) {
                    // setState(() {});
                  },
                  controller: nameController,
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
                SizedBox(height: 16.h),
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
                  // initialItem: brindiType?.getImya(),
                  overlayHeight: 342.h,
                  onChanged: (p0) {
                    textBrand = p0 ?? '';
                  },
                ),
                SizedBox(height: 16.h),
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
                  // initialItem: whereToWear?.getImya(),
                  overlayHeight: 342.h,
                  onChanged: (value) {
                    textWhereToWear = value ?? '';
                  },
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  onChanged: (value) {},
                  controller: howRoWearController,
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
                    hintText: "How to wear",
                  ),
                ),
                SizedBox(height: 16.h),
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
                    final categoryElem = category[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectCategory(categoryElem.category);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: categoryElem.isSelected
                              ? CMWColor.blue6193F3
                              : Colors.white,
                          border: Border.all(
                              width: 2,
                              color: categoryElem.isSelected
                                  ? CMWColor.blue6193F3
                                  : CMWColor.grey1),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Text(
                            categoryElem.category,
                            style: TextStyle(
                              color: categoryElem.isSelected
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
                SizedBox(height: 16.h),
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
                    final sityle = styleList[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectStyle(sityle.category);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: sityle.isSelected
                              ? CMWColor.blue6193F3
                              : Colors.white,
                          border: Border.all(
                              width: 2,
                              color: sityle.isSelected
                                  ? CMWColor.blue6193F3
                                  : CMWColor.grey1),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Text(
                            sityle.category,
                            style: TextStyle(
                              color: sityle.isSelected
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
                SizedBox(height: 16.h),
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
                      // setState(() {});
                    },
                    // controller: _garderobNotesController,
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
                SizedBox(height: 12.h),
                CMWMoti(
                  onPressed: () {
                    List<String> listsd = [];
                    if (stringImageForSaveAndroid.isNotEmpty) {
                      listsd.add(stringImageForSaveAndroid);
                    }
                    widget.model.image.forEach((action) {
                      listsd.add(action);
                    });
                    data.put(
                        widget.model.id,
                        Detailodejdamodel(
                          id: widget.model.id,
                          image: stringImageForSaveAndroid.isEmpty
                              ? widget.model.image
                              : listsd,
                          namess: nameController.text,
                        ));
                    event.fire(UpdateList());
                    Navigator.of(context).pop();
                  },
                  child: Container(
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
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
