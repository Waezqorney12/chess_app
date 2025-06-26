class BotEntities {
  final String botImage;
  final String botName;
  final BotType botType;
  final int botElo;
  final String botDescription;

  const BotEntities({
    required this.botImage,
    required this.botName,
    required this.botType,
    required this.botDescription,
    required this.botElo,
  });

  copyWith({
    final String? botImage,
    final String? botName,
    final BotType? botType,
    final int? botElo,
    final String? botDescription,
  }) {
    return BotEntities(
      botImage: botImage ?? this.botImage,
      botName: botName ?? this.botName,
      botType: botType ?? this.botType,
      botDescription: botDescription ?? this.botDescription,
      botElo: botElo ?? this.botElo,
    );
  }
}

enum BotType { adaptive, beginner, advance, master }
