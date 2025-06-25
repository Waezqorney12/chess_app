import 'package:chess_application/core/app_palette.dart';
import 'package:chess_application/core/app_text_style.dart';
import 'package:chess_application/core/routes_pages.dart';
import 'package:chess_application/core/utils/extension_utils.dart';
import 'package:chess_application/core/widget/appbar_widget.dart';
import 'package:flutter/material.dart';

class ThumbnailRegisterScreen extends StatelessWidget {
  const ThumbnailRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        onPressed: () => Navigator.pop(context),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Play Chess.',
              style: AppTextStyle.montserrat32ExtraBold,
            ),
            Text(
              'Have Fun.',
              style: AppTextStyle.montserrat32ExtraBold,
            ),
            SizedBox(
              child: Image.asset('assets/regist-logo.png'),
            ).paddingOnly(top: 40),
            space(),
            ElevatedButton(
              onPressed: () => Navigator.push(context, Routes.regist()),
              child: Text(
                'Get Started',
                style: AppTextStyle.montserrat20ExtraBold,
              ),
            ).styledButton(width: 400, height: 60).paddingOnly(bottom: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(context, Routes.login()),
              child: Text(
                'Log In',
                style: AppTextStyle.montserrat20ExtraBold,
              ),
            )
                .styledButton(
                  width: 400,
                  height: 60,
                  color: AppPalette.appBarColor,
                )
                .paddingOnly(bottom: 60)
          ],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
