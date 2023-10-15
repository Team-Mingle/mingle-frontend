import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mingle/common/const/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  bool isAnonymous = true;

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
                    "게시글 작성",
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
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 12.0),
                        InkWell(
                          child: Row(
                            children: [
                              const Text("게시판 이름"),
                              const SizedBox(
                                width: 10.0,
                              ),
                              SvgPicture.asset(
                                  "assets/img/post_screen/down_tick.svg")
                            ],
                          ),
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                        TextFormField(
                          decoration: const InputDecoration.collapsed(
                            hintText: "제목을 입력하세요",
                            hintStyle: TextStyle(
                              color: GRAYSCALE_GRAY_02,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4.0,
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    height: 24.0,
                    thickness: 1.0,
                    color: GRAYSCALE_GRAY_01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      maxLines: null,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintMaxLines: 5,
                          hintText: """밍글에서 나누고 싶은 이야기가 있나요?
· 운영규칙을 위반하는 게시글은 삭제 될 수 있습니다.
· 다른 유저들에게 불쾌감을 줄 수 있는 내용은 신고로   
  제재될 수 있습니다.
· 더 상세한 내용은 밍글 가이드라인을 참고하세요.""",
                          hintStyle: TextStyle(
                              color: GRAYSCALE_GRAY_02,
                              fontWeight: FontWeight.w600)),
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar:
                Container(height: imageFileList.isNotEmpty ? 160.0 : 48.0),
          ),
          bottomSheet: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              imageFileList.isEmpty
                  ? Container(
                      height: 0.0,
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SizedBox(
                        height: 122.0,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(
                                  imageFileList.length,
                                  (index) => Row(
                                        children: [
                                          selectedImageCard(index),
                                          SizedBox(
                                            width: index ==
                                                    imageFileList.length - 1
                                                ? 0.0
                                                : 4.0,
                                          )
                                        ],
                                      ))),
                        ),
                      ),
                    ),
              SizedBox(
                height: 48.0,
                child: Row(children: [
                  const SizedBox(
                    width: 16.0,
                  ),
                  InkWell(
                    onTap: selectImages,
                    child: SvgPicture.asset(
                        "assets/img/post_screen/image_picker_icon.svg"),
                  ),
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
              ),
            ],
          ),
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
        height: 90.0,
        width: 90.0,
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
          ],
        ),
      ),
    );
  }
}
