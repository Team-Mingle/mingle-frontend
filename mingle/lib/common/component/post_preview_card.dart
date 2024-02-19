// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:mingle/common/const/colors.dart';
// import 'package:mingle/post/models/post_model.dart';
// import 'package:mingle/post/view/post_detail_screen.dart';
// import 'package:mingle/second_hand_market/view/second_hand_post_detail_screen.dart';

// enum CardType { home, square, lawn, market, selling }

// class PostPreviewCard extends StatelessWidget {
//   final List<Map<String, String>> postList;
//   // final Future postFuture;
//   final CardType cardType;

//   const PostPreviewCard({
//     required this.postList,
//     required this.cardType,
//     Key? key,
//     // required this.postFuture,
//   }) : super(key: key);

//   int getMaxLines() {
//     switch (cardType) {
//       case CardType.home:
//         return 1;
//       case CardType.square:
//         return 3;
//       case CardType.lawn:
//         return 3;
//       case CardType.market:
//         return 1;
//       case CardType.selling:
//         return 1;
//     }
//   }

//   Widget buildDivider(double height) {
//     final verticalMargin = cardType == CardType.home ? 10.0 : 8.0;
//     final horizontalPadding = cardType == CardType.selling
//         ? 0.0
//         : (cardType == CardType.home ? 12.0 : 8.0);

//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: verticalMargin),
//         height: height,
//         color: GRAYSCALE_GRAY_01,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: postList.length,
//           itemBuilder: (context, index) {
//             final post = postList[index];
//             return Column(
//               children: [
//                 // 첫번째 줄에만 padding
//                 if (index == 0)
//                   SizedBox(
//                     height: (() {
//                       switch (cardType) {
//                         case CardType.home:
//                           return 20.0;
//                         case CardType.selling:
//                           return 24.0;
//                         default:
//                           return 16.0;
//                       }
//                     })(),
//                   ),
//                 InkWell(
//                   onTap: () {
//                     print('Item $index tapped');
//                     if (cardType == CardType.market ||
//                         cardType == CardType.selling) {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (_) => const SecondHandPostDetailScreen(),
//                         ),
//                       );
//                     } else {
//                       // Navigator.of(context).push(
//                       //   MaterialPageRoute(
//                       //     builder: (_) => const PostDetailScreen(),
//                       //   ),
//                       // );
//                     }
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start, // 사진 위쪽 정렬
//                       children: [
//                         if (cardType == CardType.market ||
//                             cardType == CardType.selling)
//                           Container(
//                             width: 96, // 이미지의 가로 크기 조절
//                             height: 96, // 이미지의 세로 크기 조절
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(4),
//                               image: DecorationImage(
//                                 image: NetworkImage(
//                                   post['imageUrl'] ??
//                                       'https://cdn.pixabay.com/photo/2014/02/27/16/10/flowers-276014_1280.jpg',
//                                 ),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         if (cardType == CardType.market ||
//                             cardType == CardType.selling)
//                           const SizedBox(
//                             width: 16.0,
//                           ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       post['title'] ?? '',
//                                       style: const TextStyle(
//                                         fontFamily: "Pretendard",
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w400,
//                                         color: GRAYSCALE_BLACK_GRAY,
//                                       ),
//                                       textAlign: TextAlign.left,
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                   if (cardType == CardType.market ||
//                                       cardType == CardType.selling)
//                                     SvgPicture.asset(
//                                       cardType == CardType.market
//                                           ? 'assets/img/second_hand_market_screen/heart_icon.svg'
//                                           : cardType == CardType.selling
//                                               ? 'assets/img/post_screen/triple_dot_icon.svg'
//                                               : '', // 다른 경우에 대한 처리 (비어있는 문자열로 설정)
//                                       width: 20,
//                                       height: 20,
//                                     ),
//                                   const SizedBox(
//                                     width: 4.0,
//                                   )
//                                 ],
//                               ),
//                               if (cardType == CardType.market ||
//                                   cardType == CardType.selling)
//                                 const SizedBox(height: 6.0),
//                               Text(
//                                 cardType == CardType.market
//                                     ? '${post['askingPrice'] ?? ''} ${post['currencies'] ?? ''}'
//                                     : post['content'] ?? '',
//                                 style: const TextStyle(
//                                   fontFamily: "Pretendard",
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: GRAYSCALE_GRAY_05,
//                                 ),
//                                 textAlign: TextAlign.left,
//                                 maxLines: getMaxLines(),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               SizedBox(
//                                 height: (cardType == CardType.market ||
//                                         cardType == CardType.selling)
//                                     ? 43.0
//                                     : 6.0,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text(
//                                         post['nickname'] ?? '',
//                                         style: const TextStyle(
//                                           fontFamily: "Pretendard",
//                                           fontSize: 11,
//                                           fontWeight: FontWeight.w400,
//                                           color: GRAYSCALE_GREY_ORANGE,
//                                         ),
//                                         textAlign: TextAlign.left,
//                                       ),
//                                       const SizedBox(width: 4.0),
//                                       SvgPicture.asset(
//                                         'assets/img/common/ic_dot.svg',
//                                         width: 2,
//                                         height: 2,
//                                       ),
//                                       const SizedBox(width: 4.0),
//                                       Text(
//                                         post['timestamp'] ?? '',
//                                         style: const TextStyle(
//                                           fontFamily: "Pretendard",
//                                           fontSize: 11,
//                                           fontWeight: FontWeight.w400,
//                                           color: GRAYSCALE_GREY_ORANGE,
//                                         ),
//                                         textAlign: TextAlign.left,
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       SvgPicture.asset(
//                                         cardType == CardType.market
//                                             ? 'assets/img/second_hand_market_screen/heart_icon.svg'
//                                             : 'assets/img/common/ic_like.svg',
//                                         width: 16,
//                                         height: 16,
//                                       ),
//                                       Text(
//                                         post['likeCounts'] ?? '',
//                                         style: const TextStyle(
//                                           fontFamily: "Pretendard",
//                                           fontSize: 11,
//                                           fontWeight: FontWeight.w400,
//                                           color: GRAYSCALE_GRAY_ORANGE_02,
//                                         ),
//                                         textAlign: TextAlign.left,
//                                       ),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       SvgPicture.asset(
//                                         'assets/img/common/ic_comment.svg',
//                                         width: 16,
//                                         height: 16,
//                                       ),
//                                       Text(
//                                         post['commentCounts'] ?? '',
//                                         style: const TextStyle(
//                                           fontFamily: "Pretendard",
//                                           fontSize: 11,
//                                           fontWeight: FontWeight.w400,
//                                           color: GRAYSCALE_GRAY_ORANGE_02,
//                                         ),
//                                         textAlign: TextAlign.left,
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 if (index != postList.length - 1) buildDivider(1.0),
//                 if (cardType == CardType.selling)
//                   GestureDetector(
//                     onTap: () {
//                       showModalBottomSheet(
//                         context: context,
//                         builder: (BuildContext context) {
//                           String selectedOption = '판매중'; // 기본 선택 항목

//                           return Container(
//                             height: 248,
//                             width: MediaQuery.of(context).size.width,
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(20),
//                               ),
//                             ),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 20.0),
//                               child: Column(
//                                 children: [
//                                   const SizedBox(
//                                     height: 32.0,
//                                   ),
//                                   ListTile(
//                                     title: Center(
//                                       child: Text(
//                                         '판매중',
//                                         style: TextStyle(
//                                           fontWeight: selectedOption == '판매중'
//                                               ? FontWeight.bold
//                                               : FontWeight.normal,
//                                         ),
//                                       ),
//                                     ),
//                                     onTap: () {
//                                       Navigator.pop(context);
//                                       selectedOption = '판매중'; // 선택한 항목 설정
//                                       print("판매중");
//                                     },
//                                   ),
//                                   const SizedBox(
//                                     height: 20.0,
//                                   ),
//                                   ListTile(
//                                     title: Center(
//                                       child: Text(
//                                         '예약중',
//                                         style: TextStyle(
//                                           fontWeight: selectedOption == '예약중'
//                                               ? FontWeight.bold
//                                               : FontWeight.normal,
//                                         ),
//                                       ),
//                                     ),
//                                     onTap: () {
//                                       Navigator.pop(context);
//                                       selectedOption = '예약중'; // 선택한 항목 설정
//                                       print("예약중");
//                                     },
//                                   ),
//                                   const SizedBox(
//                                     height: 20.0,
//                                   ),
//                                   ListTile(
//                                     title: Center(
//                                       child: Text(
//                                         '판매완료',
//                                         style: TextStyle(
//                                           fontWeight: selectedOption == '판매완료'
//                                               ? FontWeight.bold
//                                               : FontWeight.normal,
//                                         ),
//                                       ),
//                                     ),
//                                     onTap: () {
//                                       Navigator.pop(context);
//                                       selectedOption = '판매완료'; // 선택한 항목 설정
//                                       print("판매완료");
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                         backgroundColor: Colors.transparent,
//                       );
//                     },
//                     child: const SizedBox(
//                       height: 40.0,
//                       child: Center(
//                         child: Text(
//                           '판매상태 변경',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 14,
//                             fontFamily: 'Pretendard',
//                             fontWeight: FontWeight.w500,
//                             height: 0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),

//                 if (cardType == CardType.selling) buildDivider(2.0),
//                 if (index == postList.length - 1)
//                   const SizedBox(
//                     height: 20.0,
//                   ),
//               ],
//             );
//           },
//         ));
//   }
// }
