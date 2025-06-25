import 'package:chess_application/core/app_text_style.dart';
import 'package:flutter/cupertino.dart';

import '../app_palette.dart';

void notificationDialog({
  required BuildContext context,
  required void Function()? onTap,
  required String text,
  String? title,
  bool isOption = true,
}) {
  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(
        title ?? 'Warning',
        style: AppTextStyle.urbanistBold.copyWith(fontSize: 16),
      ),
      content: Text(
        textAlign: TextAlign.center,
        text,
        style: AppTextStyle.urbanistMedium.copyWith(fontSize: 14),
      ),
      actions: [
        if (isOption)
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Tidak',
              style: AppTextStyle.urbanistSemiBold,
            ),
          ),
        CupertinoDialogAction(
          onPressed: onTap,
          child: Text(
            'Ya',
            style: AppTextStyle.urbanistSemiBold.copyWith(color: AppPalette.greenColor),
          ),
        ),
      ],
    ),
  );
}
