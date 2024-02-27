import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/post/models/post_model.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/post/view/post_detail_screen.dart';
import 'package:mingle/user/model/notification_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingle/user/provider/member_provider.dart';

class NotificationItem extends ConsumerStatefulWidget {
  final NotificationModel notification;
  // final CursorPaginationBase data;
  final dynamic notifierProvider;
  final dynamic allNotifierProvider;
  final ProviderFamily<PostModel?, int>? postDetailProvider;

  const NotificationItem({
    Key? key,
    required this.notification,
    //  required this.data,
    this.notifierProvider,
    this.allNotifierProvider,
    this.postDetailProvider,
  }) : super(key: key);

  @override
  ConsumerState<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends ConsumerState<NotificationItem> {
  void refreshList() {
    widget.notifierProvider!.paginate(normalRefetch: true);
    widget.allNotifierProvider!.paginate(normalRefetch: true);
  }

  @override
  Widget build(BuildContext context) {
    String imagePath = _getImagePath(widget.notification.contentType);

    bool isTradingBoard = widget.notification.boardType == '거래게시판';

    String boardTypeToShow =
        isTradingBoard ? '거래게시판' : widget.notification.boardType;

    return GestureDetector(
      onTap: () {
        switch (widget.notification.boardType) {
          case "광장":
            switch (widget.notification.categoryType) {
              case "자유":
                print(widget.notification.notificationId);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PostDetailScreen(
                      boardType: widget.notification.boardType,
                      postId: widget.notification.notificationId,
                      refreshList: refreshList,
                      notifierProvider:
                          ref.watch(totalFreePostProvider.notifier),
                      allNotifierProvider:
                          ref.watch(totalFreePostProvider.notifier),
                      postDetailProvider: totalFreePostDetailProvider,
                    ),
                  ),
                );
              case "질문":
                print(widget.notification.notificationId);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PostDetailScreen(
                      boardType: widget.notification.boardType,
                      postId: widget.notification.notificationId,
                      refreshList: refreshList,
                      notifierProvider:
                          ref.watch(totalQnAPostProvider.notifier),
                      allNotifierProvider:
                          ref.watch(totalQnAPostProvider.notifier),
                      postDetailProvider: totalQnAPostDetailProvider,
                    ),
                  ),
                );
              case "밍글소식":
                print(widget.notification.notificationId);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PostDetailScreen(
                      boardType: widget.notification.boardType,
                      postId: widget.notification.notificationId,
                      refreshList: refreshList,
                      notifierProvider:
                          ref.watch(totalMinglePostProvider.notifier),
                      allNotifierProvider:
                          ref.watch(totalMinglePostProvider.notifier),
                      postDetailProvider: totalMinglePostDetailProvider,
                    ),
                  ),
                );

              default:
                print("Unknown post type: ${widget.notification.categoryType}");
            }
            break;
          case "잔디밭":
            switch (widget.notification.categoryType) {
              case "자유":
                print(widget.notification.notificationId);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PostDetailScreen(
                      boardType: widget.notification.boardType,
                      postId: widget.notification.notificationId,
                      refreshList: refreshList,
                      notifierProvider:
                          ref.watch(univFreePostProvider.notifier),
                      allNotifierProvider:
                          ref.watch(univFreePostProvider.notifier),
                      postDetailProvider: univFreePostDetailProvider,
                    ),
                  ),
                );
              case "질문":
                print(widget.notification.notificationId);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PostDetailScreen(
                      boardType: widget.notification.boardType,
                      postId: widget.notification.notificationId,
                      refreshList: refreshList,
                      notifierProvider: ref.watch(univQnAPostProvider.notifier),
                      allNotifierProvider:
                          ref.watch(univQnAPostProvider.notifier),
                      postDetailProvider: univQnAPostDetailProvider,
                    ),
                  ),
                );
              case "학생회":
                print(widget.notification.notificationId);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PostDetailScreen(
                      boardType: widget.notification.boardType,
                      postId: widget.notification.notificationId,
                      refreshList: refreshList,
                      notifierProvider: ref.watch(univKsaPostProvider.notifier),
                      allNotifierProvider:
                          ref.watch(univKsaPostProvider.notifier),
                      postDetailProvider: univKsaPostDetailProvider,
                    ),
                  ),
                );

              default:
                print("Unknown post type: ${widget.notification.categoryType}");
            }
            break;

          default:
            print("Unknown post type: ${widget.notification.boardType}");
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.notification.isRead
              ? Colors.white
              : const Color(0xFFFFECE9),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: SizedBox(
                    width: 12,
                    height: 12,
                    child: imagePath.isNotEmpty
                        ? SvgPicture.asset(imagePath)
                        : const Icon(Icons.notification_important),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    widget.notification.notificationType,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: GRAYSCALE_GRAY_05,
                      height: 19 / 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              widget.notification.content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14.0,
                letterSpacing: -0.01,
                height: 1.4,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 4.0,
            ),
            if (isTradingBoard)
              Text(
                boardTypeToShow,
                style: const TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff686868),
                  height: 19 / 12,
                ),
              )
            else
              Row(
                children: [
                  Text(
                    widget.notification.boardType,
                    style: const TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff686868),
                      height: 19 / 12,
                    ),
                  ),
                  const Text(
                    "•",
                    style: TextStyle(color: GRAYSCALE_GRAY_02, fontSize: 12.0),
                  ),
                  Text(
                    widget.notification.categoryType,
                    style: const TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff686868),
                      height: 19 / 12,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  String _getImagePath(String contentType) {
    switch (contentType) {
      case 'COMMENT':
        return 'assets/img/common/ic_notification_comment.svg';
      case 'INTEREST':
        return 'assets/img/common/ic_notification_interest.svg';
      case 'POST':
        return 'assets/img/common/ic_notification_like.svg';
      default:
        return '';
    }
  }
}
