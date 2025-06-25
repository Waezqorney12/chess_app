import 'dart:async';
import 'dart:io';

import 'package:chess_application/core/app_palette.dart';
import 'package:chess_application/core/app_text_style.dart';
import 'package:chess_application/core/utils/extension_utils.dart';
import 'package:chess_application/core/utils/notification_utils.dart';
import 'package:chess_application/core/utils/positioned_utils.dart';
import 'package:chess_application/core/utils/time_utils.dart';
import 'package:chess_application/features/game/chess_pieces.dart';
import 'package:chess_application/features/game/component.dart';
import 'package:chess_application/features/game/game_controller.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<List<String>> historyMoves = [];
  ValueNotifier<Timer?> enemyTimer = ValueNotifier(null);
  ValueNotifier<Timer?> playerTimer = ValueNotifier(null);
  ValueNotifier<Duration> enemyDuration = ValueNotifier(const Duration(minutes: 10));
  ValueNotifier<Duration> playerDuration = ValueNotifier(const Duration(minutes: 10));
  late GameController _controller;
  @override
  void initState() {
    _controller = GameController();
    if (_controller.isWhiteTurn.value == false) enemyTimer.value = _controller.startTimer(enemyTimer, enemyDuration);
    playerTimer.value = _controller.startTimer(playerTimer, playerDuration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => notificationDialog(
            context: context,
            onTap: () => exit(0),
            text: 'Apakah anda yakin ingin keluar',
          ),
        );
      },
      child: Scaffold(
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            // Enemy Player
            ValueListenableBuilder(
              valueListenable: enemyDuration,
              builder: (context, value, child) {
                return player(
                        playerName: 'Dewa Kipas',
                        playerImage: 'assets/black-pieces/black-pawn.png',
                        playerType: PlayerType.opponent,
                        duration: enemyDuration.value,
                        bottom: _controller.opponentCaptured.value.isNotEmpty ? 0 : 20)
                    .paddingSymmetric(vertical: 32);
              },
            ),

            // Chess Pieces
            ...List.generate(8, (row) {
              return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(8, (col) {
                    // Determine the color of the cell
                    final isWhite = (row + col) % 2 == 0;
                    final piece = _controller.board[row][col];

                    final selected = piece?.isWhite == true ? _controller.playerSelected.value : _controller.enemySelected.value;
                    final isSelected = selected.isNotEmpty && selected[0] == row && selected[1] == col;
                    final bgColor = isSelected
                        ? AppPalette.selectedBackground
                        : isWhite
                            ? AppPalette.sageGreenColor
                            : AppPalette.greenColor;
                    return Expanded(
                      child: Container(
                        height: 50,
                        width: 50,
                        color: bgColor,
                        child: InkWell(
                            onTap: () {
                              if (piece == null) return;
                              print("object: $row $col");
                              final isLegal = _controller.legalMoves.value.any(
                                (element) => element[0] == row && element[1] == col,
                              );

                              print(_controller.isWhiteTurn.value);
                              print(selected);
                              print(piece.isWhite);
                              print(bgColor);
                              // Show available legal move each pieces
                              switch (piece.type) {
                                case ChessType.pawn:
                                  _controller.legalMoves.value = _controller.getPawnMoves(row, col);
                                case ChessType.knight:
                                  _controller.legalMoves.value = _controller.getKnightMoves(row, col);
                                default:
                                  _controller.legalMoves.value = [];
                              }

                              print(isLegal);
                              if (selected.isNotEmpty) {
                                final toRow = selected[0];
                                final toColumn = selected[1];
                                print("$toRow $toColumn");
                              }

                              print("Legal: ${_controller.legalMoves.value}");
                              if (piece.isWhite) {
                                _controller.playerSelected.value = [row, col];
                                _controller.enemySelected.value = [];
                              } else if (!piece.isWhite) {
                                _controller.enemySelected.value = [row, col];
                                _controller.playerSelected.value = [];
                              }
                              setState(() {});
                            },
                            child: Stack(
                              children: [
                                if (piece != null)
                                  Positioned(
                                    right: 0,
                                    left: 0,
                                    top: Dimensions.height6(context),
                                    child: Component(pieces: piece),
                                  ),

                                Positioned(
                                  left: Dimensions.widht2(context),
                                  child: Text(
                                    (col == 0 && row <= 7)
                                        ? ((row + 1) % 2 == 0)
                                            ? '${row + 1}'
                                            : ''
                                        : '',
                                    style: AppTextStyle.montserrat12Semi.copyWith(color: AppPalette.sageGreenColor),
                                  ),
                                ),
                                Positioned(
                                  left: Dimensions.widht2(context),
                                  child: Text(
                                    (col == 0 && row <= 7)
                                        ? (row % 2 == 0)
                                            ? '${row + 1}'
                                            : ''
                                        : '',
                                    style: AppTextStyle.montserrat12Semi.copyWith(color: AppPalette.greenColor),
                                  ),
                                ),
                                // Show dot if this cell is in legalMoves
                                if (_controller.legalMoves.value.any((pos) => pos[0] == row && pos[1] == col))
                                  Center(
                                    child: Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade300.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                              ],
                            )),
                      ),
                    );
                  }));
            }),

            // Player
            ValueListenableBuilder(
              valueListenable: playerDuration,
              builder: (context, value, child) {
                return player(
                        playerImage: 'assets/white-pieces/white-pawn.png',
                        playerName: 'SurrendAjaBang',
                        playerType: PlayerType.player,
                        duration: playerDuration.value,
                        bottom: _controller.playerCaptured.value.isNotEmpty ? 0 : 20)
                    .paddingSymmetric(vertical: 32);
              },
            )
          ]),
        ),
      ),
    );
  }

  Row player(
      {required String playerName,
      String? playerImage,
      required PlayerType playerType,
      required Duration duration,
      required double bottom}) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: playerImage != null ? Colors.white.withOpacity(.3) : null,
          ),
          child: playerImage != null ? Image.asset(playerImage) : null,
        ).paddingSymmetric(horizontal: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              playerName,
              style: AppTextStyle.poppins16.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(.8),
              ),
            ).paddingOnly(bottom: bottom),
            Row(
                children: switch (playerType) {
              PlayerType.opponent => _controller.opponentCaptured.value.map((value) => piecesWidget(value)).toList(),
              PlayerType.player => _controller.playerCaptured.value.map((value) => piecesWidget(value)).toList(),
            }),
          ],
        ).paddingOnly(right: 12),
        const Spacer(),
        Container(
          height: 40,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black.withOpacity(.5),
          ),
          child: Center(
            child: Text(
              TimeUtils.formatDuration(duration),
              style: AppTextStyle.montserrat20.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ).paddingOnly(right: 12)
      ],
    );
  }

  SizedBox piecesWidget(String? value) {
    return SizedBox(
      height: 24,
      width: 24,
      child: value != null ? Image.asset(value) : null,
    );
  }
}

enum PlayerType { opponent, player }
