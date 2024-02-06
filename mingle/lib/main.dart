import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/view/splash_screen.dart';
import 'package:mingle/module/components/module_review_card.dart';
import 'package:mingle/module/view/add_module_review_screen.dart';
import 'package:mingle/module/view/module_review_main_screen.dart';
import 'package:mingle/user/view/home_screen/home_root_tab.dart';
import 'package:mingle/user/view/home_screen/home_root_tab.dart';
import 'package:mingle/user/view/login_screen.dart';
import 'package:mingle/user/view/my_page_screen/my_page_screen.dart';
import 'package:mingle/user/view/signup_screen/select_nickname_screen.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
          theme: ThemeData(
              fontFamily: 'Pretendard', disabledColor: GRAYSCALE_GRAY_02),
          debugShowCheckedModeBanner: false,
          home: const HomeRootTab()),
    );
  }
}
