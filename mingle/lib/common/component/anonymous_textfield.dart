import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingle/common/const/colors.dart';

class AnonymousTextfield extends StatefulWidget {
  final Function handleSubmit;
  const AnonymousTextfield({super.key, required this.handleSubmit});

  @override
  State<AnonymousTextfield> createState() => _AnonymousTextfieldState();
}

class _AnonymousTextfieldState extends State<AnonymousTextfield> {
  bool isAnonymous = true;
  String text = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 56.0,
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
                    fontWeight: FontWeight.w600,
                    color:
                        isAnonymous ? PRIMARY_COLOR_ORANGE_02 : Colors.black),
              ),
              const SizedBox(
                width: 4.0,
              ),
              SvgPicture.asset("assets/img/post_screen/check_icon.svg",
                  height: 8.0,
                  width: 6.0,
                  colorFilter: ColorFilter.mode(
                      isAnonymous ? PRIMARY_COLOR_ORANGE_02 : Colors.black,
                      BlendMode.srcIn))
            ]),
          ),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: SizedBox(
              // width: 144,
              height: 36.0,
              child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      text = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,

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
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          InkWell(
            child:
                SvgPicture.asset("assets/img/post_screen/paper_plane_icon.svg"),
            onTap: () => widget.handleSubmit(text, isAnonymous),
          )
        ]),
      ),
    );
  }
}
