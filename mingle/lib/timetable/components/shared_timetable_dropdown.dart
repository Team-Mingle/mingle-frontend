import 'package:flutter/material.dart';
import 'package:mingle/common/const/colors.dart';

class MyExpansionPanelList extends StatelessWidget {
  final List<String> friendList;
  final Map<String, bool> expansionStates; // 확장 상태를 받아오는 맵

  const MyExpansionPanelList({
    Key? key,
    required this.friendList,
    required this.expansionStates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 1,
      expansionCallback: (int panelIndex, bool isExpanded) {
        // 확장/축소 상태 변경 로직을 구현
        final friend = friendList[panelIndex];
        final isCurrentlyExpanded = expansionStates[friend] ?? false;
        expansionStates[friend] = !isCurrentlyExpanded;
      },
      children: friendList.asMap().entries.map<ExpansionPanel>((entry) {
        final index = entry.key;
        final friend = entry.value;
        return ExpansionPanel(
          headerBuilder: (context, isExpanded) {
            return ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                friend,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            );
          },
          body: Container(
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ListView.builder(
              itemCount: 3, // '철수', '짱구', '훈이'가 들어가는 경우
              itemBuilder: (BuildContext context, int position) {
                return getRow(position);
              },
            ),
          ),
          isExpanded: expansionStates[friend] ?? false, // 확장 상태 설정
        );
      }).toList(),
    );
  }

  Widget getRow(int i) {
    final List<String> subItems = ['철수', '짱구', '훈이'];
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: ListTile(
          title: Text(
            subItems[i],
            style: const TextStyle(
              color: PRIMARY_COLOR_ORANGE_01,
            ),
          ),
        ),
      ),
      onTap: () {
        // 하위 목록 항목을 클릭 시 수행할 작업 추가
      },
    );
  }
}
