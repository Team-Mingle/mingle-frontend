import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/view/my_page_screen/my_page_screen.dart';

class SearchCourseModalWidget extends StatelessWidget {
  const SearchCourseModalWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: GRAYSCALE_GRAY_01,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "강의명을 입력하세요",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'assets/img/common/ic_search.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const MyPageScreen())),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Divider(
            height: 1,
            color: GRAYSCALE_GRAY_01,
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Text(
            '최근 검색어 내역이 없습니다.',
            style: TextStyle(
              color: GRAYSCALE_GRAY_04,
              fontSize: 14.0,
              letterSpacing: -0.01,
              height: 1.4,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
