import 'package:chess_application/core/app_palette.dart';
import 'package:chess_application/core/app_text_style.dart';
import 'package:chess_application/core/routes_pages.dart';
import 'package:chess_application/core/utils/extension_utils.dart';
import 'package:chess_application/core/widget/field_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/widget/divider_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: ElevatedButton(
        onPressed: () => Navigator.pushAndRemoveUntil(context, Routes.home(), (route) => false),
        child: Text(
          'Log In',
          style: AppTextStyle.montserrat20ExtraBold,
        ),
      ).styledButton(width: 450, height: 50).paddingSymmetric(horizontal: 12, vertical: 12),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/logo.png'),
          widgetField(
            context,
            hintText: 'Email',
            controller: emailController,
            icon: Icon(
              Icons.person,
              color: Colors.white.withOpacity(.4),
            ).paddingOnly(left: 12),
          ).paddingSymmetric(horizontal: 24, vertical: 24),
          widgetField(
            context,
            hintText: 'Password',
            controller: passwordController,
            icon: Icon(
              Icons.lock,
              color: Colors.white.withOpacity(.4),
            ).paddingOnly(left: 12),
          ).paddingSymmetric(horizontal: 24),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Text('Forgot Password?',
                style: AppTextStyle.montserrat12Semi.copyWith(
                  color: Colors.white.withOpacity(.6),
                )),
          ).paddingOnly(right: 24, top: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              divider(context),
              Text(
                'OR',
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(.4),
                ),
              ).paddingSymmetric(horizontal: 12),
              divider(context)
            ],
          ).paddingSymmetric(vertical: 24),
          ElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset(
                    fit: BoxFit.fill,
                    'assets/google.png',
                  ),
                ),
                Text(
                  'Log In with Google',
                  style: AppTextStyle.montserrat16Bold.copyWith(
                    color: AppPalette.secondaryColor,
                  ),
                ).paddingOnly(right: 28),
              ],
            ),
          )
              .styledButton(
                width: 450,
                height: 50,
                color: Colors.white,
              )
              .paddingSymmetric(horizontal: 24),
          ElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset(
                    fit: BoxFit.fill,
                    'assets/facebook.png',
                  ),
                ),
                Text(
                  'Log In with Facebook',
                  style: AppTextStyle.montserrat16Bold.copyWith(
                    color: Colors.white,
                  ),
                ).paddingOnly(right: 28),
              ],
            ),
          )
              .styledButton(
                width: 450,
                height: 50,
                color: AppPalette.blueColor,
              )
              .paddingSymmetric(horizontal: 24, vertical: 24)
        ],
      ),
    );
  }

}
