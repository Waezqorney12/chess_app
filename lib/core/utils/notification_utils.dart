import 'package:chess_application/core/app_text_style.dart';
import 'package:chess_application/core/utils/extension_utils.dart';
import 'package:chess_application/core/utils/positioned_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_palette.dart';

enum TypeDialog { notification, result }

void notificationDialog({
  required BuildContext context,
  void Function()? notificationButton,
  String? notificationText,
  required TypeDialog type,
  CupertinoAlertDialog? customDialog,
  String? title,
  String? subTitleResult,
  void Function()? actionResultButton,
  void Function()? rematchResultButton,
  void Function()? findMatchResultButton,
  String? actionText,
  String? rematchText,
  String? findMatchText,
  bool isOption = true,
}) {
  switch (type) {
    case TypeDialog.notification:
      showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: Text(
                  title ?? 'Warning',
                  style: AppTextStyle.urbanistBold.copyWith(fontSize: 16),
                ),
                content: Text(
                  textAlign: TextAlign.center,
                  notificationText ?? '',
                  style: AppTextStyle.urbanistMedium.copyWith(fontSize: 14),
                ),
                actions: [
                  if (isOption)
                    CupertinoDialogAction(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: AppTextStyle.urbanistSemiBold,
                      ),
                    ),
                  CupertinoDialogAction(
                    onPressed: notificationButton,
                    child: Text(
                      'Yes',
                      style: AppTextStyle.urbanistSemiBold.copyWith(color: AppPalette.greenColor),
                    ),
                  ),
                ],
              ));
    case TypeDialog.result:
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: const Color(0xFF302E2B),
            child: Container(
              width: 150,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF302E2B),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    width: Dimensions.screenWidht(context),
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppPalette.appBarColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 80,
                            ),
                            Text(
                              title ?? 'White Win',
                              style: AppTextStyle.urbanistBold.copyWith(fontSize: 24),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          subTitleResult ?? '404 error not found',
                          style: AppTextStyle.urbanistBold.copyWith(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  //Body
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: actionResultButton,
                        child: Text(
                          actionText ?? '',
                          style: AppTextStyle.montserrat16ExtraBold,
                        ),
                      ).styledButton(width: 150, height: 50).paddingSymmetric(horizontal: 12, vertical: 20)
                    ],
                  ),

                  // Button
                  actionText != null
                      ? ElevatedButton(
                          onPressed: actionResultButton,
                          child: Text(
                            actionText,
                            style: AppTextStyle.montserrat16ExtraBold,
                          ),
                        )
                          .styledButton(width: Dimensions.screenWidht(context), height: 50)
                          .paddingSymmetric(horizontal: 12, vertical: 12)
                      : const SizedBox.shrink(),
                  findMatchText != null && rematchText != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: rematchResultButton,
                              child: Text(
                                rematchText,
                                style: AppTextStyle.urbanistBold.copyWith(color: Colors.white),
                              ),
                            ).styledButton(width: 120, height: 50),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: findMatchResultButton,
                              child: Text(
                                findMatchText,
                                style: AppTextStyle.urbanistBold.copyWith(color: Colors.white),
                              ),
                            ).styledButton(width: 120, height: 50)
                          ],
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          );
        },
      );
  }
}
