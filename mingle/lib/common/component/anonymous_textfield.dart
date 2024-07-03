import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingle/common/const/colors.dart';

class AnonymousTextfield extends StatefulWidget {
  final Function handleSubmit;
  final ScrollController scrollController;
  final FocusNode focusNode;
  final bool isCommentReply;
  final TextEditingController controller;
  const AnonymousTextfield(
      {super.key,
      required this.handleSubmit,
      required this.scrollController,
      required this.focusNode,
      required this.isCommentReply,
      required this.controller});

  @override
  State<AnonymousTextfield> createState() => _AnonymousTextfieldState();
}

class _AnonymousTextfieldState extends State<AnonymousTextfield> {
  bool isAnonymous = true;
  // final TextEditingController _controller = TextEditingController();

// This is what you're looking for!
  void _scrollDown() {
    widget.scrollController.animateTo(
      widget.scrollController.position.maxScrollExtent + 74,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  // String text = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 56.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 16.0, right: 17.0, top: 10.0, bottom: 10.0),
        child: Row(children: [
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
              SvgPicture.asset("assets/img/post_screen/check_icon.svg",
                  height: 8.0,
                  width: 6.0,
                  colorFilter: ColorFilter.mode(
                      isAnonymous ? PRIMARY_COLOR_ORANGE_02 : GRAYSCALE_GRAY_03,
                      BlendMode.srcIn))
            ]),
          ),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Column(
              children: [
                TextFormField(
                    focusNode: widget.focusNode,
                    onChanged: (value) {
                      setState(() {});
                    },
                    minLines: 1,
                    maxLines: 3,
                    controller: widget.controller,
                    decoration: InputDecoration(
                      filled: true,
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 6.0),
                      fillColor: const Color(0xFFE9E7E7),
                      // hintText: "닉네임 작성",
                      hintStyle: const TextStyle(
                          color: Color(0xFFE9E7E7), fontSize: 11.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Color(0xFFE9E7E7),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Color(0xFFE9E7E7),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Color(0xFFE9E7E7),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          widget.controller.text.isEmpty
              ? GestureDetector(
                  child: SvgPicture.asset(
                    "assets/img/post_screen/paper_plane_icon.svg",
                  ),
                  onTap: () {},
                )
              : GestureDetector(
                  child: SvgPicture.asset(
                      "assets/img/post_screen/paper_plane_icon.svg",
                      colorFilter: const ColorFilter.mode(
                          PRIMARY_COLOR_ORANGE_02, BlendMode.srcIn)),
                  onTap: () {
                    widget.handleSubmit(widget.controller.text, isAnonymous);
                    widget.controller.clear();
                    if (!widget.isCommentReply) _scrollDown();
                  },
                )
        ]),
      ),
    );
  }
}
