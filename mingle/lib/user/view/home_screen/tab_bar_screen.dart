import 'package:flutter/material.dart';
import 'package:mingle/common/component/post_card.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(
    length: 4, // 탭을 4개로 변경
    vsync: this,
    initialIndex: 0,
    animationDuration: const Duration(milliseconds: 800),
  );

  @override
  void initState() {
    tabController.addListener(() {
      // 프레임당 콜백
    });

    tabController.indexIsChanging;
    tabController.length;
    tabController.previousIndex;

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _tabBar(),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              PostCard(title: '지금 잔디밭에서는'),
              PostCard(title: '지금 잔디밭에서는'),
              PostCard(title: '지금 잔디밭에서는'),
              PostCard(title: '지금 잔디밭에서는'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tabBar() {
    return TabBar(
      controller: tabController,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      labelStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 16,
      ),
      overlayColor: MaterialStatePropertyAll(
        Colors.blue.shade100,
      ),
      splashBorderRadius: BorderRadius.circular(20),
      indicatorColor: Colors.black,
      indicatorWeight: 5,
      indicatorSize: TabBarIndicatorSize.label,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      labelPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      indicatorPadding: const EdgeInsets.all(5),
      indicator: BoxDecoration(
        color: Colors.green.shade400,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.orange,
          width: 5,
        ),
      ),
      isScrollable: true,
      onTap: (index) {},
      tabs: const [
        Tab(text: "Tab 1"),
        Tab(text: "Tab 2"),
        Tab(text: "Tab 3"),
        Tab(text: "Tab 4"),
      ],
    );
  }
}
