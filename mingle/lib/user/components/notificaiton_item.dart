import 'package:flutter/material.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/model/notification_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imagePath = _getImagePath(notification.contentType);

    bool isTradingBoard = notification.boardType == '거래게시판';

    String boardTypeToShow = isTradingBoard ? '거래게시판' : notification.boardType;

    return GestureDetector(
      onTap: () {
        print(notification.notificationId);
      },
      child: Container(
        decoration: BoxDecoration(
          color: notification.isRead ? Colors.white : const Color(0xFFFFECE9),
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
                    notification.notificationType,
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
              notification.content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                height: 17 / 14,
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
                    notification.boardType,
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
                    notification.categoryType,
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
