import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/components/notification_item.dart';
import 'package:mingle/user/model/notification_model.dart';
import 'package:mingle/user/provider/notification_provider.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncNotification = ref.watch(notificationProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
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
            fontSize: 16.0,
            letterSpacing: -0.02,
            height: 1.5,
            fontWeight: FontWeight.w400,
            color: Color(0xff000000),
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
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
                      return Column(
                        children: [
                          NotificationItem(
                              notification: notificationList[index]),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(
                              color: GRAYSCALE_GRAY_02,
                              height: 0,
                            ),
                          )
                        ],
                      );
                    },
                    childCount: notificationList.length,
                  ),
                );
              },
              loading: () => const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  ),
              error: (error, stack) => const SliverFillRemaining(
                    child: Center(child: Text("알림을 불러오는데 실패했습니다.")),
                  )

              // SliverToBoxAdapter(
              //   child: Center(child: Text('Error: $error')),
              // ),
              ),
        ],
      ),
    );
  }
}
