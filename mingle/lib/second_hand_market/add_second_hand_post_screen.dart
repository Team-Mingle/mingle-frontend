import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mingle/common/const/colors.dart';

class AddSecondHandPostScreen extends StatefulWidget {
  const AddSecondHandPostScreen({super.key});

  @override
  State<AddSecondHandPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddSecondHandPostScreen> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  bool isAnonymous = true;
  bool isSelling = true;
  String selectedCurrency = "hkd";
  String productDescription = "";
  String askingPrice = "";
  String meetingPlace = "";
  String openChatLink = "";
  List<String> currencies = ["hkd", "krw", "sgd"];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: InkWell(
                      child: SvgPicture.asset(
                        "assets/img/post_screen/cross_icon.svg",
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "판매글 작성",
                    style: TextStyle(
                        color: GRAYSCALE_GRAY_03,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                  const Spacer(),
                  const Text(
                    "게시",
                    style: TextStyle(
                        color: GRAYSCALE_GRAY_03,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              centerTitle: false,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 8.0),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: selectImages,
                                child: Container(
                                  height: 72.0,
                                  width: 72.0,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: GRAYSCALE_GRAY_02),
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: GRAYSCALE_GRAY_01),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/img/post_screen/image_picker_icon.svg",
                                        ),
                                        Text(
                                          "${imageFileList.length}/10",
                                          style: const TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w500,
                                              color: GRAYSCALE_GRAY_04),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(
                                  imageFileList.length,
                                  (index) => Row(
                                    children: [
                                      selectedImageCard(index),
                                      SizedBox(
                                        width: index == imageFileList.length - 1
                                            ? 0.0
                                            : 8.0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 32.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      maxLines: 1,
                      decoration: const InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          border: InputBorder.none,
                          hintText: "제목을 입력하세요*",
                          hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: GRAYSCALE_GRAY_02,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const Divider(
                    height: 32.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0)
                        .copyWith(bottom: 16.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelling = true;
                            });
                          },
                          child: Row(children: [
                            SvgPicture.asset(
                                "assets/img/post_screen/check_icon.svg",
                                height: 8.0,
                                width: 6.0,
                                colorFilter: ColorFilter.mode(
                                    isSelling
                                        ? PRIMARY_COLOR_ORANGE_02
                                        : GRAYSCALE_GRAY_02,
                                    BlendMode.srcIn)),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              "판매하기",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                color: isSelling
                                    ? PRIMARY_COLOR_ORANGE_02
                                    : GRAYSCALE_GRAY_02,
                              ),
                            )
                          ]),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelling = false;
                            });
                          },
                          child: Row(children: [
                            SvgPicture.asset(
                                "assets/img/post_screen/check_icon.svg",
                                height: 8.0,
                                width: 6.0,
                                colorFilter: ColorFilter.mode(
                                    !isSelling
                                        ? PRIMARY_COLOR_ORANGE_02
                                        : GRAYSCALE_GRAY_02,
                                    BlendMode.srcIn)),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              "나눔하기",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                color: !isSelling
                                    ? PRIMARY_COLOR_ORANGE_02
                                    : GRAYSCALE_GRAY_02,
                              ),
                            )
                          ]),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1.0,
                  ),
                  Stack(children: [
                    Container(
                      height: !isSelling ? 64.0 : 0.0,
                      width: MediaQuery.of(context).size.width,
                      color: GRAYSCALE_GRAY_01_5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0),
                      child: Row(
                        children: [
                          currencyDropdownList(),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: TextFormField(
                              enabled: isSelling,
                              maxLines: 1,
                              onChanged: !isSelling
                                  ? null
                                  : (String price) {
                                      setState(() {
                                        askingPrice = price;
                                      });
                                    },
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: isSelling
                                      ? "희망하는 가격을 입력하세요*"
                                      : "나눔해주시는 경우 가격을 정할 수 없습니다.",
                                  hintStyle: TextStyle(
                                      fontSize: isSelling ? 16.0 : 14.0,
                                      color: GRAYSCALE_GRAY_02,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  const Divider(
                    height: 1.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0)
                        .copyWith(top: 16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 64.0,
                          child: TextFormField(
                            onChanged: (String description) {
                              setState(() {
                                productDescription = description;
                              });
                            },
                            decoration: const InputDecoration(
                              counterText: "",
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              border: InputBorder.none,
                              hintText: "상품에 대해 설명해 주세요.*",
                              hintStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: GRAYSCALE_GRAY_02,
                                  fontWeight: FontWeight.w600),
                            ),
                            maxLength: 1000,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${productDescription.length}/1000",
                            style: const TextStyle(
                                color: GRAYSCALE_GRAY_02,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    height: 32.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 64.0,
                          child: TextFormField(
                            onChanged: (String place) {
                              setState(() {
                                meetingPlace = place;
                              });
                            },
                            maxLength: 300,
                            decoration: const InputDecoration(
                              counterText: "",
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              border: InputBorder.none,
                              hintText: "희망 거래장소/시간대*",
                              hintStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: GRAYSCALE_GRAY_02,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${meetingPlace.length}/300",
                            style: const TextStyle(
                                color: GRAYSCALE_GRAY_02,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    height: 32.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 64.0,
                          child: TextFormField(
                            onChanged: (String link) {
                              setState(() {
                                openChatLink = link;
                              });
                            },
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              border: InputBorder.none,
                              hintText: "오픈채팅방 링크*",
                              hintStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: GRAYSCALE_GRAY_02,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar:
                Container(height: imageFileList.isNotEmpty ? 160.0 : 48.0),
          ),
          bottomSheet: SizedBox(
            height: 48.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Divider(
                  height: 1.0,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(children: [
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isAnonymous = !isAnonymous;
                      });
                    },
                    child: Row(children: [
                      Text(
                        "익명",
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: isAnonymous
                                ? PRIMARY_COLOR_ORANGE_02
                                : Colors.black),
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      SvgPicture.asset("assets/img/post_screen/check_icon.svg",
                          height: 8.0,
                          width: 6.0,
                          colorFilter: ColorFilter.mode(
                              isAnonymous
                                  ? PRIMARY_COLOR_ORANGE_02
                                  : Colors.black,
                              BlendMode.srcIn)),
                    ]),
                  ),
                  const SizedBox(
                    width: 22.0,
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget currencyDropdownList() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          'Select Item',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        dropdownStyleData: const DropdownStyleData(
            padding: EdgeInsets.symmetric(vertical: 8.0)),
        items: currencies
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: selectedCurrency,
        iconStyleData: IconStyleData(
            iconDisabledColor: GRAYSCALE_GRAY_02,
            icon: SvgPicture.asset("assets/img/post_screen/down_tick.svg")),
        onChanged: !isSelling
            ? null
            : (String? currency) {
                setState(() {
                  selectedCurrency = currency!;
                });
              },
        buttonStyleData: ButtonStyleData(
            padding: const EdgeInsets.only(left: 8.0, right: 4.0),
            height: 32.0,
            width: 64.0,
            decoration: BoxDecoration(
                border: Border.all(color: GRAYSCALE_GRAY_02),
                borderRadius: BorderRadius.circular(4.0))),
        menuItemStyleData: const MenuItemStyleData(
          height: 32.0,
        ),
      ),
    );
  }

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      setState(() {
        imageFileList = selectedImages;
      });
    }
  }

  Widget selectedImageCard(int index) {
    Image currentImage = Image.file(
      File(imageFileList[index].path),
      fit: BoxFit.cover,
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: SizedBox(
        height: 72.0,
        width: 72.0,
        child: Stack(
          children: [
            SizedBox(height: 90.0, width: 90.0, child: currentImage),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: InkWell(
                  child: SvgPicture.asset(
                    "assets/img/post_screen/circular_cross_icon.svg",
                    height: 16.0,
                    width: 16.0,
                  ),
                  onTap: () {
                    setState(() {
                      imageFileList.removeAt(index);
                    });
                  },
                ),
              ),
            ),
            index == 0
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 72.0,
                      height: 22.0,
                      color: GRAYSCALE_GRAY_ORANGE_03,
                    ),
                  )
                : Container(),
            index == 0
                ? const Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 22.0,
                      child: Center(
                        child: Text(
                          "대표사진",
                          style: TextStyle(fontSize: 11.0, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
