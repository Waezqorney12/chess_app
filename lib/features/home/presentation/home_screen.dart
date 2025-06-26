import 'package:chess_application/core/app_palette.dart';
import 'package:chess_application/core/utils/extension_utils.dart';
import 'package:chess_application/features/home/data/domain/entities/game_options_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core/app_text_style.dart';
import '../../../core/routes_pages.dart';

class HomeScreen extends StatelessWidget {
  final String? username;
  const HomeScreen({super.key, this.username = 'Asep'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: username != null || username!.isNotEmpty
            ? AppBar(
                backgroundColor: AppPalette.appBarColor,
                title: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Image.asset('assets/decoration-icon.png').sized(h: 40, w: 40),
                    ),
                    chessLogo()
                  ],
                ),
                leading: GestureDetector(
                  onTap: () => Navigator.push(context, Routes.profile()),
                  child: SizedBox(
                    width: 80,
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.asset(
                              'assets/thumbnail-puzzle.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ).paddingOnly(left: 16),
                  ),
                ),
                actions: [
                  InkWell(
                    onTap: () => Navigator.push(context, Routes.friendlist()),
                    child: Image.asset('assets/friend-icon.png'),
                  ).sized(h: 30, w: 30).paddingSymmetric(horizontal: 16)
                ],
              )
            : unauthorize(context),
        bottomNavigationBar: Container(
          color: AppPalette.appBarColor,
          child: ElevatedButton(
            onPressed: () => Navigator.pushAndRemoveUntil(context, Routes.home(), (route) => false),
            child: Text(
              'Play',
              style: AppTextStyle.montserrat20ExtraBold,
            ),
          ).styledButton(width: 450, height: 50).paddingSymmetric(horizontal: 12, vertical: 12),
        ),
        body: Column(
          children: gameOptions
              .asMap()
              .entries
              .map(
                (options) => InkWell(
                  onTap: () => switch (options.key) {
                    0 => Navigator.push(context, Routes.gameSettings()),
                    1 => Navigator.push(context, Routes.puzzle()),
                    2 => Navigator.push(context, Routes.lesson()),
                    3 => Navigator.push(context, Routes.bot()),
                    _ => throw Exception('Invalid route')
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppPalette.appBarColor.withOpacity(.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(options.value.image),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(options.value.title, style: AppTextStyle.montserrat16Bold),
                          Text(
                            options.value.description,
                            style: AppTextStyle.montserrat12.copyWith(
                              color: Colors.grey,
                            ),
                          ).paddingOnly(bottom: 8),
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: Image.asset(options.value.logo),
                          ),
                        ],
                      ).paddingOnly(left: 12)
                    ],
                  ).paddingAll(16),
                ),
              )
              .toList(),
        ));
  }

  AppBar unauthorize(BuildContext context) {
    return AppBar(
      backgroundColor: AppPalette.appBarColor,
      leading: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () => Navigator.push(context, Routes.login()),
          child: Text(
            'Log In',
            style: AppTextStyle.montserrat12Semi.copyWith(
              color: Colors.grey,
            ),
          ).paddingOnly(left: 12),
        ),
      ),
      title: chessLogo().paddingOnly(right: 40),
      centerTitle: true,
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.push(context, Routes.thumbnailRegist()),
            child: Text(
              'Sign Up',
              style: AppTextStyle.montserrat12Semi,
            )).styledButton(width: 100, height: 40).paddingOnly(right: 8, left: 12)
      ],
    );
  }

  Container chessLogo() {
    return Container(
      height: 40,
      width: 160,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/logo.png'),
      )),
    );
  }
}

List<GameOptionsEntities> gameOptions = const [
  GameOptionsEntities(
    'assets/thumbnail-chessboard.jpg',
    'Play Online',
    'Play someone at your level',
    'assets/play-icon.png',
  ),
  GameOptionsEntities(
    'assets/thumbnail-puzzle.jpg',
    'Solve Puzzles',
    'Find the right move!',
    'assets/puzzle-icon.png',
  ),
  GameOptionsEntities(
    'assets/thumbnail-chessboard.jpg',
    'Take Lessons',
    'Learn something new!',
    'assets/lesson-icon.png',
  ),
  GameOptionsEntities(
    'assets/thumbnail-chessboard.jpg',
    'Play a bot',
    'Advance your chess skills!',
    'assets/bot-icon.png',
  ),
];
