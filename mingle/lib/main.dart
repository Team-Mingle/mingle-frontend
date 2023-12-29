import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/view/splash_screen.dart';
import 'package:mingle/module/view/add_module_review_screen.dart';
import 'package:mingle/module/view/first_onboarding_screen.dart';
import 'package:mingle/module/view/module_details_screen.dart';
import 'package:mingle/module/view/module_review_main_screen.dart';
import 'package:mingle/module/view/point_shop_screen.dart';
import 'package:mingle/user/view/home_screen/home_root_tab.dart';
import 'package:mingle/user/view/home_screen/home_tab_screen.dart';
import 'package:mingle/user/view/login_screen.dart';
import 'package:mingle/user/view/my_page_screen/my_module_reviews_screen.dart';
import 'package:mingle/user/view/app_start_screen.dart';
import 'package:mingle/user/view/home_screen/home_root_tab.dart';
import 'package:mingle/user/view/home_screen/home_tab_screen.dart';
import 'package:mingle/user/view/login_screen.dart';
import 'package:mingle/user/view/signup_screen/service_agreement_screen.dart';
import 'package:mingle/module/view/point_shop_screen.dart';
import 'package:mingle/user/view/home_screen/home_root_tab.dart';
import 'package:mingle/user/view/home_screen/home_tab_screen.dart';
import 'package:mingle/user/view/login_screen.dart';
import 'package:mingle/user/view/my_page_screen/my_module_reviews_screen.dart';

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
          home: const AppStartScreen()),
    );
  }
}
