import 'package:flutter/material.dart';

import '../../../core/app_text_style.dart';

Widget botImage(
  BuildContext context,
  String image,
  String name,
  String elo,
) {
  return Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Colors.white,
          height: 100,
          width: 100,
          child: Image.asset(image),
        ),
      ),
      Text.rich(
        TextSpan(text: name, style: AppTextStyle.montserrat24ExtraBold, children: [
          TextSpan(text: " ($elo)", style: AppTextStyle.montserrat16Medium),
        ]),
      ),
    ],
  );
}
