import 'package:chess_application/features/game/chess_pieces.dart';
import 'package:flutter/material.dart';

class Component extends StatelessWidget {
  final ChessPieces? pieces;
  const Component({
    super.key,
    this.pieces,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: (pieces != null && pieces!.imagePath.isNotEmpty) ? Image.asset(pieces!.imagePath) : null,
    );
  }
}
