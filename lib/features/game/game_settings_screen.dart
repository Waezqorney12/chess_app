import 'package:chess_application/core/app_palette.dart';
import 'package:chess_application/core/app_text_style.dart';
import 'package:chess_application/core/routes_pages.dart';
import 'package:chess_application/core/utils/extension_utils.dart';
import 'package:chess_application/core/widget/appbar_widget.dart';
import 'package:flutter/material.dart';

class GameSettingsScreen extends StatefulWidget {
  const GameSettingsScreen({super.key});

  @override
  State<GameSettingsScreen> createState() => _GameSettingsScreenState();
}

class _GameSettingsScreenState extends State<GameSettingsScreen> {
  bool timeClicked = false;
  int time = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        backgroundColor: AppPalette.appBarColor,
        title: timeClicked == true ? 'Time' : 'New Game',
        style: AppTextStyle.montserrat24ExtraBold,
        onPressed: () => timeClicked == true ? setState(() => timeClicked = false) : Navigator.pop(context),
      ),
      body:
          timeClicked == true ? timePage().paddingSymmetric(horizontal: 16) : mainPage(context).paddingSymmetric(horizontal: 16),
    );
  }

  Column timePage() {
    return Column(
      children: [
        gameType(title: 'Bullet', image: 'assets/bullet-icon.png').paddingOnly(top: 20, bottom: 8),
        gameTime(timeOne: 1, timeTwo: 2, timeThree: 3),
        const SizedBox(height: 12),
        gameType(title: 'Rapid').paddingOnly(top: 20, bottom: 8),
        gameTime(timeOne: 10, timeTwo: 20, timeThree: 30)
      ],
    );
  }

  Column mainPage(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade800.withOpacity(.7),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => setState(() => timeClicked = true),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.timer_outlined,
                  color: AppPalette.greenColor,
                ).paddingOnly(left: 8),
                Text(
                  '$time min',
                  style: AppTextStyle.montserrat16Reguler,
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                  size: 16,
                ).paddingOnly(right: 8)
              ],
            ),
          ),
        ).paddingOnly(top: 40, bottom: 12),
        ElevatedButton(
            onPressed: () => Navigator.pushAndRemoveUntil(context, Routes.game(), (route) => false),
            child: Text(
              'Start Game',
              style: AppTextStyle.montserrat20ExtraBold,
            )).styledButton(width: 400, height: 50),
        optionsMatch(
          'Play with friends',
          'assets/friend-icon.png',
          onPressed: () => Navigator.push(context, Routes.friendlist()),
        ).styledButton(width: 400, height: 50, color: AppPalette.appBarColor).paddingSymmetric(vertical: 16),
        optionsMatch(
          'Play with bot',
          'assets/bot-icon.png',
          onPressed: () => Navigator.push(context, Routes.bot()),
        ).styledButton(width: 400, height: 50, color: AppPalette.appBarColor),
      ],
    );
  }

  Row gameTime({
    required int timeOne,
    required int timeTwo,
    required timeThree,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              time = timeOne;
              timeClicked = false;
            });
          },
          child: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade800,
            ),
            child: Center(
              child: Text(
                '$timeOne min',
                style: AppTextStyle.montserrat16Medium,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              time = timeTwo;
              timeClicked = false;
            });
          },
          child: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade800,
            ),
            child: Center(
              child: Text(
                '$timeTwo min',
                style: AppTextStyle.montserrat16Medium,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              time = timeThree;
              timeClicked = false;
            });
          },
          child: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade800,
            ),
            child: Center(
              child: Text(
                '$timeThree min',
                style: AppTextStyle.montserrat16Medium,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row gameType({
    String? image,
    required String title,
  }) {
    return Row(
      children: [
        image != null
            ? SizedBox(
                height: 20,
                width: 20,
                child: Image.asset(image),
              )
            : Icon(
                Icons.timer_outlined,
                color: AppPalette.greenColor,
              ),
        Text(
          title,
          style: AppTextStyle.montserrat16Reguler,
        ).paddingSymmetric(horizontal: 12)
      ],
    );
  }

  ElevatedButton optionsMatch(
    String title,
    String image, {
    required void Function()? onPressed,
  }) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Row(
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset(image),
            ).paddingOnly(left: 60, right: 12),
            Text(
              title,
              style: AppTextStyle.montserrat16Bold,
            ),
          ],
        ));
  }
}
