import 'package:chess_application/core/app_palette.dart';
import 'package:chess_application/core/app_text_style.dart';
import 'package:chess_application/core/routes_pages.dart';
import 'package:chess_application/core/utils/extension_utils.dart';
import 'package:chess_application/core/widget/appbar_widget.dart';
import 'package:chess_application/features/bot/controller/bot_controller.dart';
import 'package:chess_application/features/bot/domain/entities/bot_entities.dart';
import 'package:chess_application/features/bot/shared/bot_image_widget.dart';
import 'package:chess_application/features/game/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BotChallengeScreen extends StatelessWidget {
  final BotEntities bot;
  BotChallengeScreen({
    super.key,
    required this.bot,
  });

  final _controller = BotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        onPressed: () => Navigator.pop(context),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () => Navigator.pushAndRemoveUntil(context, Routes.game(timer: 10), (route) => false),
        child: Text(
          'Play!',
          style: AppTextStyle.montserrat24ExtraBold,
        ),
      ).styledButton(width: 450, height: 60).paddingSymmetric(horizontal: 16, vertical: 12),
      body: SingleChildScrollView(
        child: Column(
          children: [
            botImage(context, bot.botImage, bot.botName, "${bot.botElo}"),
            Text(
              ' I PLAY AS',
              style: AppTextStyle.montserrat12Semi.copyWith(color: Colors.grey),
            ).paddingOnly(top: 20),

            // Options Color
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: PlayerColor.values.map(
                (value) {
                  return InkWell(
                    onTap: () => _controller.playeColor.value = value,
                    child: ValueListenableBuilder(
                      valueListenable: _controller.playeColor,
                      builder: (context, color, child) {
                        return Container(
                          height: 60,
                          width: 60,
                          decoration: switch (value) {
                            PlayerColor.white => BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                border: color == value ? Border.all(color: Colors.green, width: 2) : null,
                              ),
                            PlayerColor.random => BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: color == value ? Border.all(color: Colors.green, width: 2) : null,
                              ),
                            PlayerColor.black => BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black,
                                border: color == value ? Border.all(color: Colors.green, width: 2) : null,
                              ),
                          },
                          child: switch (value) {
                            PlayerColor.white => Image.asset('assets/white-pieces/white-king.png').paddingAll(16),
                            PlayerColor.random => Stack(
                                children: [
                                  randomBlock(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: randomBlock(
                                        color: Colors.black,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        )),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    top: 0,
                                    left: 0,
                                    child: Icon(
                                      Icons.question_mark_outlined,
                                      color: Colors.grey.shade400,
                                      size: 40,
                                    ),
                                  )
                                ],
                              ),
                            PlayerColor.black => Image.asset('assets/white-pieces/white-king.png').paddingAll(16),
                          },
                        );
                      },
                    ).paddingSymmetric(horizontal: 12),
                  );
                },
              ).toList(),
            ).paddingSymmetric(vertical: 16),
            Text(
              'MODE',
              style: AppTextStyle.montserrat12Semi.copyWith(color: Colors.grey),
            ).paddingOnly(bottom: 16),

            ..._controller.challenge.value.map(
              (challenge) {
                return ValueListenableBuilder(
                  valueListenable: _controller.selectedChallenge,
                  builder: (context, value, child) {
                    return InkWell(
                      onTap: () => _controller.selectedChallenge.value = challenge,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          border:
                              _controller.selectedChallenge.value == challenge ? Border.all(color: Colors.green, width: 2) : null,
                          borderRadius: BorderRadius.circular(8),
                          color: AppPalette.appBarColor,
                        ),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  challenge.challengeName,
                                  style: AppTextStyle.montserrat20Bold,
                                ),
                                Text(
                                  challenge.challengeDescription,
                                  style: AppTextStyle.montserrat16Medium.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            ...List.generate(
                              challenge.challengePoint,
                              (index) => SvgPicture.asset('assets/crown-gold-icon.svg').sized(h: 24, w: 24),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 12),
                      ).paddingSymmetric(vertical: 8, horizontal: 16),
                    );
                  },
                );
              },
            )
          ],
        ).center(),
      ),
    );
  }

  Container randomBlock({
    required Color color,
    required BorderRadiusGeometry borderRadius,
  }) {
    return Container(
      height: 60,
      width: 30,
      decoration: BoxDecoration(color: color, borderRadius: borderRadius),
    );
  }
}
