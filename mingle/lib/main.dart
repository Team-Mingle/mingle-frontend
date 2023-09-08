import 'package:flutter/material.dart';
import 'package:mingle/common/view/splash_screen.dart';

void main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Pretendard'),
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
