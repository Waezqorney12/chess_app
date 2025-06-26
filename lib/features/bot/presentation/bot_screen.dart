import 'package:chess_application/core/app_text_style.dart';
import 'package:chess_application/core/routes_pages.dart';
import 'package:chess_application/core/utils/extension_utils.dart';
import 'package:chess_application/core/widget/appbar_widget.dart';
import 'package:chess_application/features/bot/controller/bot_controller.dart';
import 'package:chess_application/features/bot/shared/bot_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../domain/entities/bot_entities.dart';

class BotScreen extends StatelessWidget {
  BotScreen({super.key});

  final _controller = BotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
          backgroundColor: Colors.transparent,
          context,
          onPressed: () => Navigator.pop(context),
        ),
        bottomNavigationBar: ElevatedButton(
          onPressed: () => Navigator.push(context, Routes.botChallenge(bot: _controller.displayBot.value)),
          child: Text(
            'Choose',
            style: AppTextStyle.montserrat20ExtraBold,
          ),
        ).styledButton(width: 450, height: 60).paddingSymmetric(horizontal: 12, vertical: 12),
        body: SingleChildScrollView(
          child: ValueListenableBuilder(
            valueListenable: _controller.displayBot,
            builder: (context, value, child) {
              final displayBot = _controller.displayBot.value;
              return Column(
                children: [
                  botImage(context, displayBot.botImage, displayBot.botName, "${displayBot.botElo}"),
                  Text(textAlign: TextAlign.center, displayBot.botDescription).paddingOnly(top: 12, bottom: 40),
                  ...List.generate(
                    BotType.values.length,
                    (index) {
                      return Column(
                        children: [
                          Text(
                            BotType.values[index].name.toUpperCase(),
                            style: AppTextStyle.montserrat12Semi.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          Wrap(
                                  runSpacing: 12,
                                  alignment: WrapAlignment.center,
                                  children: _controller.availableBot.value[index].map(
                                    (e) {
                                      return InkWell(
                                          onTap: () {
                                            _controller.displayBot.value = e;
                                          },
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            clipBehavior: Clip.none,
                                            decoration: BoxDecoration(
                                              border: _controller.displayBot.value == e
                                                  ? Border.all(color: Colors.green, width: 2)
                                                  : null,
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.asset(
                                                e.botImage,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ).paddingSymmetric(horizontal: 8));
                                    },
                                  ).toList())
                              .paddingSymmetric(vertical: 12)
                        ],
                      );
                    },
                  )
                ],
              ).center();
            },
          ),
        ));
  }
}
