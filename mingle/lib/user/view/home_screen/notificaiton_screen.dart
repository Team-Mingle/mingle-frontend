import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/components/notificaiton_item.dart';
import 'package:mingle/user/model/notification_model.dart';
import 'package:mingle/user/provider/notification_provider.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncNotification = ref.watch(notificationProvider);

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR_GRAY,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: BACKGROUND_COLOR_GRAY,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: InkWell(
            child: SvgPicture.asset(
              "assets/img/signup_screen/cross_icon.svg",
              fit: BoxFit.scaleDown,
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text(
          "알림",
          style: TextStyle(
            fontFamily: "Pretendard",
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff000000),
            height: 19 / 16,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 1000));
              ref.refresh(notificationProvider); 
            },
          ),
          asyncNotification.when(
            data: (notifications) {
              final List<NotificationModel> notificationList = notifications;
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return NotificationItem(
                        notification: notificationList[index]);
                  },
                  childCount: notificationList.length,
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => SliverToBoxAdapter(
              child: Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
