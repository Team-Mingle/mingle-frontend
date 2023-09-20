import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';

class MyPageTile extends StatelessWidget {
  final List<String> titles;
  final List<Widget> screens;
  const MyPageTile({super.key, required this.screens, required this.titles});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 18.0, top: 15.0, bottom: 15.0),
      child: Column(
        children: List.generate(
          titles.length,
          (index) => Column(
            children: [
              InkWell(
                child: SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        titles[index],
                        style: const TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                      ),
                      SvgPicture.asset(
                          "assets/img/signup_screen/next_screen_icon.svg"),
                    ],
                  ),
                ),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => screens[index])),
              ),
              index == titles.length - 1
                  ? Container()
                  : const Divider(
                      height: 8.0,
                      thickness: 1.0,
                      color: GRAYSCALE_GRAY_01,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
