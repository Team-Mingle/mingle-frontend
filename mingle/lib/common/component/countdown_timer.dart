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
  int counter = 180;
  int minutes = 3;
  int seconds = 0;
  late Timer timer;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    // int counter = 180;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter == 1) {
        setState(() {
          timer.cancel();
        });
      }
      if (mounted) {
        setState(() {
          counter--;
          minutes = (counter / 60).floor();
          seconds = (counter % 60);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "$minutes:${seconds == 0 ? "00" : seconds < 10 ? "0$seconds" : seconds}",
      style: const TextStyle(
          color: GRAYSCALE_GRAY_04,
          fontSize: 14.0,
          fontWeight: FontWeight.w400),
    );
  }
}
