import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // 그림자 제거
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/img/home_screen/ic_home_myPage.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              onPressed: () {
                // 첫 번째 버튼 클릭 시 동작을 정의
              },
            ),
          ),
          actions: <Widget>[
            // 나머지 두 개의 아이콘을 오른쪽에 배치
            IconButton(
              icon: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/img/home_screen/ic_home_search.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              onPressed: () {
                // 두 번째 버튼 동작을 정의
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/img/home_screen/ic_home_notification.svg',
                    width: 28,
                    height: 28,
                  ),
                ),
                onPressed: () {
                  // 세 번째 버튼 동작을 정의
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16.0), // 여백 추가

            // 예시: 아래에 100개의 아이템을 나열
            ListView.builder(
              shrinkWrap: true, // 리스트뷰 크기를 내용에 맞게 조정
              physics: const NeverScrollableScrollPhysics(), // 스크롤 비활성화
              padding: const EdgeInsets.all(8.0), // 여백 추가
              itemCount: 50,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
            const SizedBox(height: 169), // 여백 추가
          ],
        ),
      ),
    );
  }
}
