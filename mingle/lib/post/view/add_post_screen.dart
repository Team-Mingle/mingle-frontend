import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/module/components/toast_message_card.dart';
import 'package:mingle/post/models/add_post_model.dart';
import 'package:mingle/post/models/category_model.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/post/repository/post_repository.dart';

class AddPostScreen extends ConsumerStatefulWidget {
  final String boardType;
  const AddPostScreen({super.key, required this.boardType});

  @override
  ConsumerState<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends ConsumerState<AddPostScreen> {
  late FToast fToast;

  final ImagePicker imagePicker = ImagePicker();
  List<File> imageFileList = [];
  List<XFile> imagePreviewFileList = [];
  bool isAnonymous = true;
  String title = "";
  String content = "";
  // String boardType = widget.boardType;
  String categoryType = "";
  String categoryName = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void handleSubmit(WidgetRef ref) async {
    setState(() {
      isLoading = true;
    });
    AddPostModel addPostModel = AddPostModel(
        title: title,
        content: content,
        categoryType: categoryType,
        isAnonymous: isAnonymous);
    print(title);
    print(content);
    print(widget.boardType);
    print(categoryType);
    print(isAnonymous);
    print(imageFileList);
    try {
      final response = await ref.watch(postRepositoryProvider).addPost(
            boardType: widget.boardType,
            // addPostModel: FormData.fromMap(
            //     {...addPostModel.toJson(), "multipartFile": imageFileList})
            //  addPostModel.toJson(),
            // multipartFile: imageFileList,

            title: addPostModel.title,
            content: addPostModel.content,
            categoryType: addPostModel.categoryType,
            isAnonymous: addPostModel.isAnonymous,
            multipartFile: imageFileList,
          ) as Map<String, dynamic>;
      final int postId = response['postId'];
      switch (categoryType) {
        case 'FREE':
          widget.boardType == 'TOTAL'
              ? ref
                  .watch(totalFreePostProvider.notifier)
                  .addPost(postId: postId)
              : ref
                  .watch(univFreePostProvider.notifier)
                  .addPost(postId: postId);
        case 'QNA':
          widget.boardType == 'TOTAL'
              ? ref.watch(totalQnAPostProvider.notifier).addPost(postId: postId)
              : ref.watch(univQnAPostProvider.notifier).addPost(postId: postId);
        case 'KSA':
          ref.watch(univKsaPostProvider.notifier).addPost(postId: postId);
        case 'MINGLE':
          ref.watch(totalMinglePostProvider.notifier).addPost(postId: postId);
      }
      widget.boardType == 'TOTAL'
          ? ref.watch(totalAllPostProvider.notifier).addPost(postId: postId)
          : ref.watch(univAllPostProvider.notifier).addPost(postId: postId);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    } on DioException catch (e) {
      setState(() {
        isLoading = false;
      });
      fToast.showToast(
        child:
            ToastMessage(message: e.response?.data['message'] ?? "다시 시도해주세요"),
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 2),
      );
    }
    // print(response);
  }

  @override
  Widget build(BuildContext context) {
    bool canSubmit =
        title.isNotEmpty && content.isNotEmpty && categoryType.isNotEmpty;

    List<String> categories = widget.boardType == "TOTAL"
        ? ref.watch(totalPostCategoryProvider).categoryNames
        : ref.watch(univPostCategoryProvider).categoryNames;
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  surfaceTintColor: Colors.transparent,
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
                            letterSpacing: -0.01,
                            height: 1.4,
                            fontWeight: FontWeight.w400),
                      ),
                      const Spacer(),
                      isLoading
                          ? const CircularProgressIndicator(
                              color: PRIMARY_COLOR_ORANGE_01,
                            )
                          : AbsorbPointer(
                              absorbing: isLoading,
                              child: GestureDetector(
                                onTap:
                                    canSubmit ? () => handleSubmit(ref) : () {},
                                child: Text(
                                  "게시",
                                  style: TextStyle(
                                      color: canSubmit
                                          ? PRIMARY_COLOR_ORANGE_01
                                          : GRAYSCALE_GRAY_03,
                                      fontSize: 14.0,
                                      letterSpacing: -0.01,
                                      height: 1.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
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
                            GestureDetector(
                              child: Row(
                                children: [
                                  Text(categoryName.isEmpty
                                      ? "게시판 이름"
                                      : categoryName),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  SvgPicture.asset(
                                      "assets/img/post_screen/down_tick.svg")
                                ],
                              ),
                              onTap: () => showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: (categories.length * 48) +
                                        ((categories.length - 1) * 20) +
                                        64,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 32.0,
                                          ),
                                          ...List.generate(
                                              2 * categories.length - 1,
                                              (index) {
                                            if (index % 2 == 0) {
                                              String currentCategory =
                                                  categories[index ~/ 2];
                                              String currentName =
                                                  CategoryModel.convertName(
                                                      currentCategory);

                                              return ListTile(
                                                title: Center(
                                                  child: Text(
                                                    currentName,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          categoryType ==
                                                                  currentName
                                                              ? FontWeight.bold
                                                              : FontWeight
                                                                  .normal,
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    categoryType = currentName;
                                                    categoryName =
                                                        currentName; // 선택한 항목 설정
                                                  });
                                                },
                                              );
                                            } else {
                                              return const SizedBox(
                                                height: 20.0,
                                              );
                                            }
                                          }),
                                          // ListTile(
                                          //   title: Center(
                                          //     child: Text(
                                          //       '자유',
                                          //       style: TextStyle(
                                          //         fontWeight: categoryType == 'FREE'
                                          //             ? FontWeight.bold
                                          //             : FontWeight.normal,
                                          //       ),
                                          //     ),
                                          //   ),
                                          //   onTap: () {
                                          //     Navigator.pop(context);
                                          //     setState(() {
                                          //       categoryType = 'FREE';
                                          //       categoryName = '자유'; // 선택한 항목 설정
                                          //     });
                                          //   },
                                          // ),
                                          // const SizedBox(
                                          //   height: 20.0,
                                          // ),
                                          // ListTile(
                                          //   title: Center(
                                          //     child: Text(
                                          //       '질문',
                                          //       style: TextStyle(
                                          //         fontWeight: categoryType == 'QNA'
                                          //             ? FontWeight.bold
                                          //             : FontWeight.normal,
                                          //       ),
                                          //     ),
                                          //   ),
                                          //   onTap: () {
                                          //     Navigator.pop(context);
                                          //     setState(() {
                                          //       categoryType = 'QNA';
                                          //       categoryName = '질문'; // 선택한 항목 설정
                                          //     });
                                          //   },
                                          // ),
                                          // const SizedBox(
                                          //   height: 20.0,
                                          // ),
                                          // ListTile(
                                          //   title: Center(
                                          //     child: Text(
                                          //       '밍글소식',
                                          //       style: TextStyle(
                                          //         fontWeight:
                                          //             categoryType == 'MINGLE'
                                          //                 ? FontWeight.bold
                                          //                 : FontWeight.normal,
                                          //       ),
                                          //     ),
                                          //   ),
                                          //   onTap: () {
                                          //     Navigator.pop(context);
                                          //     setState(() {
                                          //       categoryType =
                                          //           'MINGLE'; // 선택한 항목 설정
                                          //       categoryName = '밍글소식';
                                          //     });
                                          //   },
                                          // ),
                                          // const SizedBox(
                                          //   height: 20.0,
                                          // ),
                                          // ListTile(
                                          //   title: Center(
                                          //     child: Text(
                                          //       '학생회',
                                          //       style: TextStyle(
                                          //         fontWeight: categoryType == 'KSA'
                                          //             ? FontWeight.bold
                                          //             : FontWeight.normal,
                                          //       ),
                                          //     ),
                                          //   ),
                                          //   onTap: () {
                                          //     Navigator.pop(context);
                                          //     setState(() {
                                          //       categoryType = 'KSA'; // 선택한 항목 설정
                                          //       categoryName = '학생회';
                                          //     });
                                          //   },
                                          // ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            const SizedBox(
                              height: 32.0,
                            ),
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  title = value;
                                });
                              },
                              decoration: const InputDecoration.collapsed(
                                hintText: "제목을 입력하세요",
                                hintStyle: TextStyle(
                                  color: GRAYSCALE_GRAY_02,
                                  fontSize: 16.0,
                                  letterSpacing: -0.02,
                                  height: 1.5,
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
                          onChanged: (value) {
                            setState(() {
                              content = value;
                            });
                          },
                          maxLines: null,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintMaxLines: 5,
                              hintText: """밍글에서 나누고 싶은 이야기가 있나요?
        
        · 운영규칙을 위반하는 게시글은 삭제 될 수 있습니다.
        · 불쾌감을 줄 수 있는 내용은 신고로 제재될 수 있습니다.
        · 더 상세한 내용은 밍글 가이드라인을 참고하세요.""",
                              hintStyle: TextStyle(
                                  color: GRAYSCALE_GRAY_02,
                                  fontSize: 13.0,
                                  height: 1.4,
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
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          color: Colors.white,
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
                                      width: index == imageFileList.length - 1
                                          ? 0.0
                                          : 4.0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        border:
                            Border(top: BorderSide(color: GRAYSCALE_GRAY_01))),
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
                                letterSpacing: -0.005,
                                height: 1.3,
                                fontWeight: FontWeight.w600,
                                color: isAnonymous
                                    ? PRIMARY_COLOR_ORANGE_02
                                    : GRAYSCALE_GRAY_03),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          SvgPicture.asset(
                              "assets/img/post_screen/check_icon.svg",
                              height: 8.0,
                              width: 6.0,
                              colorFilter: ColorFilter.mode(
                                  isAnonymous
                                      ? PRIMARY_COLOR_ORANGE_02
                                      : GRAYSCALE_GRAY_03,
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
        ),
      ),
    );
  }

  void selectImages() async {
    final List<XFile> files = await imagePicker.pickMultiImage();
    // FilePickerResult? result =
    //     await FilePicker.platform.pickFiles(allowMultiple: true);
    if (files.isNotEmpty) {
      // 파일 경로를 통해 formData 생성
      // List<MultipartFile> selectedImages = List.generate(files.length, (index) {
      //   print(files[index].path);
      //   return MultipartFile.fromBytes(
      //       File(files[index].path).readAsBytesSync());
      // });

      List<File> selectedImages = List.generate(files.length, (index) {
        print(files[index].path);
        return File(files[index].path);
      });
      setState(() {
        imageFileList = selectedImages;
        imagePreviewFileList = files;
      });
      print(imageFileList);
    }
  }

  Widget selectedImageCard(int index) {
    Image currentImage = Image.file(
      File(imagePreviewFileList[index].path),
      // File(imageFileList[index]),
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
                      imagePreviewFileList.removeAt(index);
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
