import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';

Widget buildTypeIndicator(String categoryType, bool isChina) {
  switch (categoryType) {
    case "MINGLE":
      return Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFEDFDA),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: Text(
                isChina ? "총학생회" : "밍글소식",
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff595959),
                ),
                textAlign: TextAlign
                    .center, // Changed to center to align text in the middle of the container
              ),
            ),
          ),
          const SizedBox(
            width: 4.0,
          )
        ],
      );
    case "KSA":
      return Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFDFF3FE),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: Text(
                "학생회",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff595959),
                ),
                textAlign: TextAlign
                    .center, // Changed to center to align text in the middle of the container
              ),
            ),
          ),
          const SizedBox(
            width: 4.0,
          )
        ],
      );
    case "QNA":
      return Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFE9E7E7),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: Text(
                "질문",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff595959),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            width: 4.0,
          )
        ],
      );
    default:
      return const SizedBox.shrink();
  }
}

Widget buildRoleIndicator(String nickname, String memberRole, double fontSize) {
  switch (memberRole) {
    case "ADMIN":
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            nickname,
            style: TextStyle(
              fontFamily: "Pretendard",
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: const Color(0xff686868),
              height: 13 / fontSize,
            ),
            textAlign: TextAlign.left,
          ),
          SvgPicture.asset(
            'assets/img/common/ic_check.svg',
            width: 14,
            height: 14,
          ),
        ],
      );
    case "KSA":
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            nickname,
            style: TextStyle(
              fontFamily: "Pretendard",
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: const Color(0xff686868),
              height: 13 / fontSize,
            ),
            textAlign: TextAlign.left,
          ),
          SvgPicture.asset(
            'assets/img/common/ic_check.svg',
            width: 14,
            height: 14,
          ),
        ],
      );
    case "FRESHMAN":
      return Text(
        "$nickname🐥",
        style: TextStyle(
          fontFamily: "Pretendard",
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: const Color(0xff686868),
          height: 13 / fontSize,
        ),
        textAlign: TextAlign.left,
      );
    default:
      return Text(
        nickname,
        style: TextStyle(
          fontFamily: "Pretendard",
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
          color: GRAYSCALE_GRAY_04,
        ),
        textAlign: TextAlign.left,
      );
  }
}
