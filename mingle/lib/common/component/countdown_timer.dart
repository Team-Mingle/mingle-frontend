import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:quiver/iterables.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int counter = 0;
  late Timer timer;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    counter = 10;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (counter == 1) {
        setState(() {
          timer.cancel();
        });
      }
      if (mounted) {
        setState(() {
          counter--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      counter.toString(),
      style: TextStyle(
          color: GRAYSCALE_GRAY_04,
          fontSize: 14.0,
          fontWeight: FontWeight.w400),
    );
  }
}
