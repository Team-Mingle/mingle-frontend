import 'package:flutter/material.dart';
import 'package:mingle/common/const/colors.dart';

class ViewingPassCard extends StatelessWidget {
  final String title;
  final String purchaseDate;
  final String expiryDate;
  const ViewingPassCard(
      {super.key,
      required this.title,
      required this.purchaseDate,
      required this.expiryDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          border: Border.all(color: GRAYSCALE_GRAY_01_5),
          borderRadius: BorderRadius.circular(8.0)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Row(
          children: [
            const Text(
              "구매",
              style: TextStyle(color: GRAYSCALE_GRAY_04, fontSize: 12.0),
            ),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              purchaseDate,
              style: const TextStyle(fontSize: 12.0),
            )
          ],
        ),
        const SizedBox(
          height: 4.0,
        ),
        Row(
          children: [
            const Text(
              "만료",
              style: TextStyle(color: GRAYSCALE_GRAY_04, fontSize: 12.0),
            ),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              expiryDate,
              style: const TextStyle(fontSize: 12.0),
            )
          ],
        ),
      ]),
    );
  }
}
