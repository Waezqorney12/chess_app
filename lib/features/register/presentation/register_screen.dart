import 'dart:io';

import 'package:chess_application/core/routes_pages.dart';
import 'package:chess_application/core/utils/extension_utils.dart';
import 'package:chess_application/core/utils/image_utils.dart';
import 'package:chess_application/core/widget/appbar_widget.dart';
import 'package:chess_application/core/widget/field_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/app_palette.dart';
import '../../../core/app_text_style.dart';
import '../../../core/widget/divider_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  int currentStep = 0;
  File? imageFile;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        onPressed: () => setState(() => (currentStep == 0) ? Navigator.pop(context) : currentStep--),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () => currentStep == 2
            ? Navigator.pushAndRemoveUntil(context, Routes.login(), (route) => false)
            : setState(() => currentStep++),
        child: Text(
          'Continue',
          style: AppTextStyle.montserrat20ExtraBold,
        ),
      ).styledButton(width: 450, height: 50).paddingSymmetric(horizontal: 16, vertical: 12),
      body: currentStep == 0
          ? emailForm(context).paddingSymmetric(horizontal: 16)
          : currentStep == 1
              ? passwordForm(context).paddingSymmetric(horizontal: 16)
              : usernameForm(context).paddingSymmetric(horizontal: 16),
    );
  }

  Column usernameForm(BuildContext context) {
    return Column(
      children: [
        Text(
          'Create a username',
          style: AppTextStyle.montserrat32ExtraBold,
        ).paddingOnly(top: 24, bottom: 4),
        Text(
          textAlign: TextAlign.center,
          "This is what your firends and other players\n will see when you play",
          style: AppTextStyle.poppins16.copyWith(color: Colors.grey),
        ).paddingOnly(bottom: 40),
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white.withOpacity(.3),
                  )),
              child: InkWell(
                onTap: () async {
                  final xFile = await pickImage();
                  setState(() => imageFile = xFile);
                },
                child: imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(imageFile!),
                      )
                    : Icon(
                        Icons.camera_alt,
                        color: Colors.white.withOpacity(.3),
                      ),
              ),
            ),
            Expanded(
              child: widgetField(
                context,
                hintText: 'Username',
                controller: usernameController,
              ).paddingSymmetric(horizontal: 12),
            ),
          ],
        )
      ],
    );
  }

  Column passwordForm(BuildContext context) {
    return Column(
      children: [
        Text(
          'Create a password',
          style: AppTextStyle.montserrat32ExtraBold,
        ).paddingOnly(top: 24, bottom: 4),
        Text(
          textAlign: TextAlign.center,
          "Password must have at leas 8 characters,\n one capital letter, and one number",
          style: AppTextStyle.poppins16.copyWith(color: Colors.grey),
        ).paddingOnly(bottom: 40),
        widgetField(
          context,
          icon: const Icon(
            Icons.lock,
            color: Colors.grey,
          ).paddingOnly(left: 12),
          hintText: 'Password',
          controller: passwordController,
        ),
      ],
    );
  }

  Column emailForm(BuildContext context) {
    return Column(
      children: [
        Text(
          'What is your email?',
          style: AppTextStyle.montserrat32ExtraBold,
        ).paddingOnly(top: 24, bottom: 24),
        widgetField(
          context,
          hintText: 'youremail@gmail.com',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            divider(context),
            Text(
              'OR',
              style: AppTextStyle.poppins12.copyWith(color: Colors.white.withOpacity(.4)),
            ).paddingSymmetric(horizontal: 12),
            divider(context)
          ],
        ).paddingSymmetric(vertical: 24),
        ElevatedButton(
          onPressed: () {},
          child: Row(
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
                'Continue with Google',
                style: AppTextStyle.montserrat16Bold.copyWith(
                  color: AppPalette.secondaryColor,
                ),
              ).paddingOnly(left: 40),
            ],
          ),
        )
            .styledButton(
              width: 450,
              height: 50,
              color: Colors.white,
            )
            .paddingOnly(bottom: 12),
        ElevatedButton(
          onPressed: () {},
          child: Row(
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
                'Continue with Facebook',
                style: AppTextStyle.montserrat16Bold.copyWith(
                  color: Colors.white,
                ),
              ).paddingOnly(left: 40),
            ],
          ),
        ).styledButton(
          width: 450,
          height: 50,
          color: AppPalette.blueColor,
        )
      ],
    );
  }
}
