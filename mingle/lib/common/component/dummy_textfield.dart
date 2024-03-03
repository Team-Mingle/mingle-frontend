import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingle/common/const/colors.dart';

class DummyTextfield extends StatefulWidget {
  final TextEditingController controller;
  const DummyTextfield({
    super.key,
    required this.controller,
  });

  @override
  State<DummyTextfield> createState() => _DummyTextfieldState();
}

class _DummyTextfieldState extends State<DummyTextfield> {
  bool isAnonymous = true;

// This is what you're looking for!

  // String text = "";
  @override
  void initState() {
    super.initState();
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
        child: TextFormField(
            controller: widget.controller,
            minLines: 1,
            maxLines: 3,
            decoration: InputDecoration(
              filled: true,
              isCollapsed: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
              fillColor: const Color(0xFFE9E7E7),
              // hintText: "닉네임 작성",
              hintStyle:
                  const TextStyle(color: Color(0xFFE9E7E7), fontSize: 11.0),
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
    );
  }
}
