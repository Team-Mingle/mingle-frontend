import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/view/splash_screen.dart';
import 'package:mingle/user/view/home_screen/home_root_tab.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
          theme: ThemeData(fontFamily: 'Pretendard'),
          debugShowCheckedModeBanner: false,
          home: const HomeRootTab()),
    );
  }
}
