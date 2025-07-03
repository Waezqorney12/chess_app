import 'dart:async';

import 'package:chess_application/core/app_palette.dart';
import 'package:chess_application/core/app_text_style.dart';
import 'package:chess_application/core/routes_pages.dart';
import 'package:chess_application/core/utils/extension_utils.dart';
import 'package:chess_application/core/utils/notification_utils.dart';
import 'package:chess_application/core/utils/positioned_utils.dart';
import 'package:chess_application/core/utils/time_utils.dart';
import 'package:chess_application/features/game/chess_pieces.dart';
import 'package:chess_application/features/game/component.dart';
import 'package:chess_application/features/game/controller/game_controller.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final int timer;
  const GameScreen({super.key, required this.timer});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<List<String>> historyMoves = [];
  ValueNotifier<Timer?> enemyTimer = ValueNotifier(null);
  ValueNotifier<Timer?> playerTimer = ValueNotifier(null);
  late ValueNotifier<Duration> enemyDuration;
  late ValueNotifier<Duration> playerDuration;
  late GameController _controller;

  @override
  void initState() {
    _controller = GameController();
    enemyDuration = ValueNotifier(Duration(minutes: widget.timer));
    playerDuration = ValueNotifier(Duration(minutes: widget.timer));
    if (_controller.isWhiteTurn.value) playerTimer.value = _controller.startTimer(playerTimer, playerDuration);

    playerDuration.addListener(
      () {
        // if (playerDuration.value.inSeconds == 0) notificationDialog(context: context, onTap: onTap, text: text, type: type);
      },
    );
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
            type: TypeDialog.notification,
            notificationButton: () => Navigator.pushAndRemoveUntil(context, Routes.home(), (route) => false),
            notificationText: 'Are you sure want to resign?',
          ),
        );
      },
      child: Scaffold(
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            InkWell(
              onTap: () {
                notificationDialog(
                  context: context,
                  type: TypeDialog.result,
                  actionResultButton: () => Navigator.pushAndRemoveUntil(context, Routes.home(), (route) => false),
                  findMatchText: 'Find match',
                  actionText: 'Home',
                  rematchText: 'Rematch',
                );
              },
              child: Container(
                height: 80,
                width: 80,
                color: Colors.red,
              ),
            ),
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

                    final previous = _controller.previousSelected.value;
                    final newest = _controller.newestSelected.value;

                    final selected = _controller.isWhiteTurn.value == true
                        ? _controller.playerSelected.value
                        : _controller.enemySelected.value;
                    final isSelected = _controller.isMatch(selected, row, col) ||
                        _controller.isMatch(previous, row, col) ||
                        _controller.isMatch(newest, row, col);

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
                              final isLegal =
                                  _controller.legalMoves.value.any((element) => element[0] == row && element[1] == col);
                              final isWhiteTurn = _controller.isWhiteTurn.value;
                              final selected = isWhiteTurn ? _controller.playerSelected.value : _controller.enemySelected.value;

                              if (selected.isNotEmpty && isLegal) {
                                final fromRow = selected[0];
                                final fromColumn = selected[1];

                                setState(() {
                                  if (_controller.board[row][col] != null) {
                                    final capturedPiece = _controller.board[row][col];

                                    // Capture Pieces Logic
                                    if (isWhiteTurn) {
                                      _controller.playerCaptured.value = [
                                        ..._controller.playerCaptured.value,
                                        capturedPiece!.imagePath,
                                      ];
                                    } else {
                                      _controller.opponentCaptured.value = [
                                        ..._controller.opponentCaptured.value,
                                        capturedPiece!.imagePath,
                                      ];
                                    }
                                  }

                                  // Updating the board
                                  _controller.board[row][col] = _controller.board[fromRow][fromColumn];
                                  _controller.board[fromRow][fromColumn] = null;
                                  _controller.legalMoves.value = [];
                                  _controller.playerSelected.value = [];
                                  _controller.enemySelected.value = [];
                                  _controller.historyMoves.value = [
                                    ..._controller.historyMoves.value,
                                    _controller.previousSelected.value
                                  ];
                                  _controller.newestSelected.value = [row, col];
                                  _controller.previousSelected.value = [fromRow, fromColumn];
                                  _controller.isWhiteTurn.value = !isWhiteTurn;
                                  if (_controller.isWhiteTurn.value == false) {
                                    enemyTimer.value = _controller.startTimer(enemyTimer, enemyDuration);
                                    _controller.pauseTimer(playerTimer, playerDuration);
                                  } else {
                                    playerTimer.value = _controller.startTimer(playerTimer, playerDuration);
                                    _controller.pauseTimer(enemyTimer, enemyDuration);
                                  }
                                });
                              } else if (piece != null && piece.isWhite == isWhiteTurn) {
                                setState(() {
                                  final selectedPos = [row, col];
                                  if (isWhiteTurn) {
                                    _controller.playerSelected.value = selectedPos;
                                    _controller.enemySelected.value = [];
                                  } else {
                                    _controller.enemySelected.value = selectedPos;
                                    _controller.playerSelected.value = [];
                                  }
                                  // Show available legal move each pieces
                                  switch (piece.type) {
                                    case ChessType.pawn:
                                      _controller.legalMoves.value = _controller.getPawnMoves(row, col);
                                    case ChessType.knight:
                                      _controller.legalMoves.value = _controller.getKnightMoves(row, col);
                                    case ChessType.rock:
                                      _controller.legalMoves.value = _controller.getRookMoves(row, col);
                                    case ChessType.bishop:
                                      _controller.legalMoves.value = _controller.getBishopMoves(row, col);
                                    default:
                                      _controller.legalMoves.value = [];
                                  }
                                });
                              }
                            },
                            child: Stack(
                              children: [
                                // Component Pieces
                                if (piece != null)
                                  Positioned(
                                    right: 0,
                                    left: 0,
                                    top: Dimensions.height6(context),
                                    child: Component(pieces: piece),
                                  ),

                                // Board Number
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

                                // Hint move each piece
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
