import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:quiver/iterables.dart';

class CountdownTimer extends StatefulWidget {
  final Function setCountdownComplete;
  const CountdownTimer({super.key, required this.setCountdownComplete});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();

  void resetTimer() {
    _CountdownTimerState().resetTimer();
  }

  void startTimer() {
    _CountdownTimerState().startTimer();
  }
}

class _CountdownTimerState extends State<CountdownTimer> {
  int counter = 180;
  int minutes = 0;
  int seconds = 0;
  late Timer timer;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void resetTimer() {
    setState(() {
      counter = 180;
      minutes = 0;
      seconds = 0;
    });
    // startTimer();
  }

  void startTimer() {
    // int counter = 180;
    if (mounted) {
      setState(() {
        counter = 180;
      });
    }

    print("timer started");
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print("timer ticking");
      if (counter == 1) {
        widget.setCountdownComplete(true);
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
          letterSpacing: -0.01,
          height: 1.4,
          fontWeight: FontWeight.w400),
    );
  }
}
