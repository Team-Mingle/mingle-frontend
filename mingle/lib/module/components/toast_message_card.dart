import 'package:flutter/material.dart';
import 'package:mingle/common/const/colors.dart';

class ToastMessage extends StatelessWidget {
  final String message;
  const ToastMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          border: Border.all(color: GRAYSCALE_GRAY_04),
          borderRadius: BorderRadius.circular(3.0),
          color: GRAYSCALE_GRAY_04),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
