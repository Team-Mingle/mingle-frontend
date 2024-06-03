import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SimpleImageDetailScreen extends StatelessWidget {
  final String imgLink;
  const SimpleImageDetailScreen({super.key, required this.imgLink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            // if (details.delta.dx > 0) {
            //   // print("Dragging in +X direction");
            // } else {
            //   // print("Dragging in -X direction");
            // }
            print(details.delta.dy);
            if (details.delta.dy > 20) {
              Navigator.of(context).pop();
              // print("Dragging in +Y direction");
            } else {
              // print("Dragging in -Y direction");
            }
          },
          child: Stack(children: [
            Center(
              child: Hero(
                tag: imgLink,
                child: Image(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    imgLink,
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SvgPicture.asset(
                    "assets/img/signup_screen/cross_icon.svg",
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ]),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
