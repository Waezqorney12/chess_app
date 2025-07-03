// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:chess_application/features/game/chess_pieces.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum PlayerColor { white, random, black }

class GameController {
  ValueNotifier<List<int>> enemySelected = ValueNotifier([]);
  ValueNotifier<List<int>> playerSelected = ValueNotifier([]);

  ValueNotifier<List<int>> previousSelected = ValueNotifier([]);
  ValueNotifier<List<int>> newestSelected = ValueNotifier([]);

  ValueNotifier<List<List<int>>> historyMoves = ValueNotifier([]);

  late List<List<ChessPieces?>> board;
  ValueNotifier<List<List<int>>> legalMoves = ValueNotifier([]);

  bool isMatch(List<int> list, int row, int col) {
    return list.isNotEmpty && list[0] == row && list[1] == col;
  }

  GameController() {
    initBoard();
  }

  Timer? startTimer(ValueNotifier<Timer?> timer, ValueNotifier<Duration> duration) {
    return timer.value = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        duration.value = duration.value - const Duration(seconds: 1);
        if (duration.value.inSeconds <= 0) timer.value?.cancel();
      },
    );
  }

  void pauseTimer(ValueNotifier<Timer?> timer, ValueNotifier<Duration> duration) {
    if (timer.value != null) timer.value!.cancel();
  }

  bool _isInBounds(int row, int col) => row >= 0 && row < 8 && col >= 0 && col < 8;

  List<List<int>> getPawnMoves(int row, int col) {
    final piece = board[row][col];
    if (piece == null || piece.type != ChessType.pawn) return [];
    List<List<int>> moves = [];

    int direction = piece.isWhite ? -1 : 1;
    int startRow = piece.isWhite ? 6 : 1;

    // One Step
    if (_isInBounds(row + direction, col) && board[row + direction][col] == null) {
      moves.add([row + direction, col]);
      // Two Step
      if (row == startRow && board[row + 2 * direction][col] == null) {
        moves.add([row + 2 * direction, col]);
      }
    }

    for (int dx in [-1, 1]) {
      int newRow = row + direction;
      int newCol = col + dx;
      if (_isInBounds(newRow, newCol)) {
        final target = board[newRow][newCol];
        if (target != null && target.isWhite != piece.isWhite) {
          moves.add([newRow, newCol]);
        }
      }
    }
    return moves;
  }

  List<List<int>> getKnightMoves(int row, int col) {
    final List<List<int>> moves = [];
    final piece = board[row][col];

    if (piece == null || piece.type != ChessType.knight) return [];

    final availableMoves = [
      [row - 2, col + 1],
      [row - 2, col - 1],
      [row - 1, col + 2],
      [row - 1, col - 2],
      [row + 1, col + 2],
      [row + 1, col - 2],
      [row + 2, col + 1],
      [row + 2, col - 1],
    ];
    for (final move in availableMoves) {
      int newRow = move[0];
      int newColumn = move[1];

      if (_isInBounds(newRow, newColumn)) {
        final target = board[newRow][newColumn];
        if (target == null || target.isWhite != piece.isWhite) {
          moves.add([newRow, newColumn]);
        }
      }
    }
    return moves;
  }

  List<List<int>> getQueenMoves(int row, int col) {
    List<List<int>> queenMoves = [];
    final piece = board[row][col];

    if (piece == null || piece.type != ChessType.queen) return [];

    return queenMoves;
  }

  List<List<int>> getKingMoves(int row, int col) {
    List<List<int>> kingMoves = [];
    final piece = board[row][col];
    if (piece == null || piece.type != ChessType.king) return [];

    final availableMoves = [
      [row, col + 1],
      [row, col - 1],
      [row - 1, col],
      [row + 1, col],
      [row - 1, col + 1],
      [row - 1, col - 1],
      [row + 1, col - 1],
      [row + 1, col + 1],
    ];

    for (final move in availableMoves) {
      final updatedRow = move[0];
      final updatedCol = move[1];

      if (_isInBounds(updatedRow, updatedCol)) {
        final target = board[updatedRow][updatedCol];
        if (target == null) {
          kingMoves.add([updatedRow, updatedCol]);
        } else {
          if (target.isWhite != piece.isWhite) kingMoves.add([updatedRow, updatedCol]);
        }
      }
    }
    return kingMoves;
  }

  List<List<int>> getRookMoves(int row, int col) {
    List<List<int>> rookMoves = [];
    final piece = board[row][col];

    if (piece == null || piece.type != ChessType.rock) return [];

    // Down Moves
    for (int i = 1; i < 8 - row; i++) {
      final updatedRow = row + i;
      if (!_isInBounds(updatedRow, col)) break;
      final target = board[updatedRow][col];
      if (target == null) {
        rookMoves.add([updatedRow, col]);
      } else {
        if (target.isWhite != piece.isWhite) rookMoves.add([updatedRow, col]);
        break;
      }
    }

    // Up move
    for (int i = 1; row - i >= 0; i++) {
      final updatedRow = row - i;
      final target = board[updatedRow][col];
      if (!_isInBounds(updatedRow, col)) break;

      if (target == null) {
        rookMoves.add([updatedRow, col]);
      } else {
        if (target.isWhite != piece.isWhite) rookMoves.add([updatedRow, col]);
        break;
      }
    }

    // Right Move
    for (int i = 1; i < 8 - col; i++) {
      final updatedCol = col + i;
      if (!_isInBounds(row, updatedCol)) break;
      final target = board[row][updatedCol];
      if (target == null) {
        rookMoves.add([row, updatedCol]);
      } else {
        if (target.isWhite != piece.isWhite) rookMoves.add([row, updatedCol]);
        break;
      }
    }

    // Left Move
    for (int i = 1; col - i >= 0; i++) {
      final updatedCol = col - i;
      final target = board[row][updatedCol];
      if (!_isInBounds(row, updatedCol)) break;

      if (target == null) {
        rookMoves.add([row, updatedCol]);
      } else {
        if (target.isWhite != piece.isWhite) rookMoves.add([row, updatedCol]);
        break;
      }
    }

    return rookMoves;
  }

  List<List<int>> getBishopMoves(int row, int col) {
    List<List<int>> bishopMoves = [];
    final piece = board[row][col];
    if (piece == null || piece.type != ChessType.bishop) return [];

    // Diagonal topRight
    for (int i = 1; col + i < 8 || row - i >= 0; i++) {
      final updatedCol = col + i;
      final updatedRow = row - i;

      if (!_isInBounds(updatedRow, updatedCol)) break;
      final target = board[updatedRow][updatedCol];
      if (target == null) {
        bishopMoves.add([updatedRow, updatedCol]);
      } else {
        if (target.isWhite != piece.isWhite) bishopMoves.add([updatedRow, updatedCol]);
        break;
      }
    }
    // Diagonal topLeft
    for (int i = 1; row - i >= 0 || col - i >= 0; i++) {
      final updatedRow = row - i;
      final updatedCol = col - i;
      if (!_isInBounds(updatedRow, updatedCol)) break;
      final target = board[updatedRow][updatedCol];

      if (target == null) {
        bishopMoves.add([updatedRow, updatedCol]);
      } else {
        if (target.isWhite != piece.isWhite) bishopMoves.add([updatedRow, updatedCol]);
        break;
      }
    }
    // Diagonal bottomLeft
    for (int i = 1; i < 8 - row || col - i >= 0; i++) {
      final updatedRow = row + i;
      final updatedCol = col - i;
      if (!_isInBounds(updatedRow, updatedCol)) break;
      final target = board[updatedRow][updatedCol];
      if (target == null) {
        bishopMoves.add([updatedRow, updatedCol]);
      } else {
        if (target.isWhite != piece.isWhite) bishopMoves.add([updatedRow, updatedCol]);
        break;
      }
    }
    // Diagonal bottomRight
    for (int i = 1; i < 8 - row || i < col - i; i++) {
      final updatedRow = row + i;
      final updatedCol = col + i;
      if (!_isInBounds(updatedRow, updatedCol)) break;
      final target = board[updatedRow][updatedCol];
      if (target == null) {
        bishopMoves.add([updatedRow, updatedCol]);
      } else {
        if (target.isWhite != piece.isWhite) bishopMoves.add([updatedRow, updatedCol]);
        break;
      }
    }

    return bishopMoves;
  }

  void initBoard() {
    board = List.generate(8, (_) => List.filled(8, null));

    // Set black pieces
    board[0] = List.generate(
        8,
        (col) => ChessPieces(
              type: getPiecesType(col),
              isWhite: false,
              imagePath: getBlackPieceImagePath(col),
            ));
    board[1] = List.generate(
        8,
        (_) => const ChessPieces(
              type: ChessType.pawn,
              isWhite: false,
              imagePath: 'assets/black-pieces/black-pawn.png',
            ));

    // Set white pieces
    board[7] = List.generate(
        8,
        (col) => ChessPieces(
              type: getPiecesType(col),
              isWhite: true,
              imagePath: getWhitePieceImagePath(col),
            ));
    board[6] = List.generate(
        8,
        (_) => const ChessPieces(
              type: ChessType.pawn,
              isWhite: true,
              imagePath: 'assets/white-pieces/white-pawn.png',
            ));

    // Middle rows stay null
  }

  ValueNotifier<bool> isWhiteTurn = ValueNotifier(true);

  ValueNotifier<List<String>> opponentCaptured = ValueNotifier([]);
  ValueNotifier<List<String>> playerCaptured = ValueNotifier([]);

  ChessType getPiecesType(int col) {
    switch (col) {
      case 0:
      case 7:
        return ChessType.rock;
      case 1:
      case 6:
        return ChessType.knight;
      case 2:
      case 5:
        return ChessType.bishop;
      case 3:
        return ChessType.queen;
      case 4:
        return ChessType.king;
      default:
        throw ArgumentError('Invalid column index: $col');
    }
  }

  String getImagePieces(int row, int col) {
    return switch (row) {
      0 => getBlackPieceImagePath(col),
      1 => 'assets/black-pieces/black-pawn.png',
      6 => 'assets/white-pieces/white-pawn.png',
      7 => getWhitePieceImagePath(col),
      _ => '',
    };
  }

  String getBlackPieceImagePath(int col) {
    switch (col) {
      case 0:
      case 7:
        return 'assets/black-pieces/black-rock.png';
      case 1:
      case 6:
        return 'assets/black-pieces/black-knight.png';
      case 2:
      case 5:
        return 'assets/black-pieces/black-bishop.png';
      case 3:
        return 'assets/black-pieces/black-queen.png';
      case 4:
        return 'assets/black-pieces/black-king.png';
      default:
        throw ArgumentError('Invalid column index: $col');
    }
  }

  String getWhitePieceImagePath(int col) {
    switch (col) {
      case 0:
      case 7:
        return 'assets/white-pieces/white-rock.png';
      case 1:
      case 6:
        return 'assets/white-pieces/white-knight.png';
      case 2:
      case 5:
        return 'assets/white-pieces/white-bishop.png';
      case 3:
        return 'assets/white-pieces/white-queen.png';
      case 4:
        return 'assets/white-pieces/white-king.png';
      default:
        throw ArgumentError('Invalid column index: $col');
    }
  }
}
