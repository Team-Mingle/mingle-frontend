import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ImageDetailScreen extends StatefulWidget {
  final List<String> images;
  int currentIndex;
  final Function onPageChange;
  // final CarouselController controller;

  ImageDetailScreen({
    super.key,
    this.currentIndex = 0,
    required this.onPageChange,
    // required this.controller,
    required this.images,
  });

  @override
  State<ImageDetailScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  CarouselController controller = CarouselController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.currentIndex);
    return Scaffold(body: SafeArea(child: sliderWidget(widget.images))
        //   GestureDetector(
        //     onVerticalDragUpdate: (details) {
        //       // if (details.delta.dx > 0) {
        //       //   // print("Dragging in +X direction");
        //       // } else {
        //       //   // print("Dragging in -X direction");
        //       // }
        //       print(details.delta.dy);
        //       if (details.delta.dy > 20) {
        //         Navigator.of(context).pop();
        //         // print("Dragging in +Y direction");
        //       } else {
        //         // print("Dragging in -Y direction");
        //       }
        //     },
        //     child: Center(
        //       child: Hero(
        //         tag: 'imageHero',
        //         child: widget.image,
        //       ),
        //     ),
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // );
        );
  }

  Widget sliderWidget(List<String> images) {
    return CarouselSlider(
      carouselController: controller,
      items: images.map((imgLink) {
        return Builder(
          builder: (context) {
            return GestureDetector(
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
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        initialPage: widget.currentIndex,
        enableInfiniteScroll: false,
        // height: 320,
        height: MediaQuery.of(context).size.height,
        viewportFraction: 1.0,
        autoPlay: false,
        onPageChanged: (index, reason) {
          widget.onPageChange(index);
        },
      ),
    );
  }
}
