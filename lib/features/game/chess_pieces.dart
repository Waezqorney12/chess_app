enum ChessType { pawn, rock, queen, king, bishop, knight }

class ChessPieces {
  final ChessType type;
  final bool isWhite;
  final String imagePath;

  const ChessPieces({
    required this.type,
    required this.isWhite,
    required this.imagePath,
  });
}
