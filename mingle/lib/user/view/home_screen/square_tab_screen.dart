import 'package:flutter/material.dart';
import 'package:mingle/user/view/home_screen/tab_bar_screen.dart';

class SquareTabScreen extends StatelessWidget {
  const SquareTabScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SquareTabScreen"),
      ),
      body: const Column(
        children: [
          TabBarScreen(),
        ],
      ),
    );
  }
}
