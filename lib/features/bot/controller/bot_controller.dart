import 'package:flutter/material.dart';

import '../domain/bot_entities.dart';

class BotController {
  final ValueNotifier<BotEntities> displayBot = ValueNotifier(const BotEntities(
      botImage: 'assets/bot/adaptive/jimmy-bot-icon.png',
      botName: 'Jimmy',
      botType: BotType.adaptive,
      botDescription:
          "Jimmy wants to make sure you enjoy the game. \nHe'll adapt to make it a little easier, or a little \nharder, depending on how you play",
      botElo: 600));

  final ValueNotifier<List<List<BotEntities>>> availableBot = ValueNotifier([
    // Adaptive
    [
      const BotEntities(
          botImage: 'assets/bot/adaptive/jimmy-bot-icon.png',
          botName: 'Jimmy',
          botType: BotType.adaptive,
          botDescription:
              "Jimmy wants to make sure you enjoy the game. \nHe'll adapt to make it a little easier, or a little \nharder, depending on how you play",
          botElo: 600),
      const BotEntities(
          botImage: 'assets/bot/adaptive/nisha-bot-icon.png',
          botName: 'Nisha',
          botType: BotType.adaptive,
          botDescription:
              "Nisha is a friendly person who plays a little \ndefensively and enjoys playing with people at all \nlevels.",
          botElo: 900),
      const BotEntities(
          botImage: 'assets/bot/adaptive/tomas-bot-icon.png',
          botName: 'Tomas',
          botType: BotType.adaptive,
          botDescription: "Tomas will give almost anyone a good game and a tough positional battle!",
          botElo: 1200),
      const BotEntities(
          botImage: 'assets/bot/adaptive/devon-bot-icon.png',
          botName: 'Devon',
          botType: BotType.adaptive,
          botDescription: "Devon loves to play aggressively..but if he gets \nthe upper-hand, he'll go easy on you",
          botElo: 1600),
      const BotEntities(
          botImage: 'assets/bot/adaptive/natasha-bot-icon.png',
          botName: 'Natasha',
          botType: BotType.adaptive,
          botDescription: "Natasha always wants to win! But she's not \ntotally heartless - she'll ease up sometimes too.",
          botElo: 2000),
    ],

    // Beginner
    [
      const BotEntities(
          botImage: 'assets/bot/beginner/martin-bot-icon.png',
          botName: 'Martin',
          botType: BotType.beginner,
          botDescription:
              "Martin learned chess so that he could play \nwith his young kids. He still wins against them most \nof the time. See how you stack up",
          botElo: 250),
      const BotEntities(
          botImage: 'assets/bot/beginner/milica-bot-icon.png',
          botName: 'Milica',
          botType: BotType.beginner,
          botDescription: "Milica recently beat her dad at chess for the \nfirst time. Can you do any better than her dad \ndid?",
          botElo: 550),
      const BotEntities(
          botImage: 'assets/bot/beginner/martin-bot-icon.png',
          botName: 'Martin',
          botType: BotType.beginner,
          botDescription:
              "Martin learned chess so that he could play \nwith his young kids. He still wins against them most \nof the time. See how you stack up",
          botElo: 250),
      const BotEntities(
          botImage: 'assets/bot/beginner/milica-bot-icon.png',
          botName: 'Milica',
          botType: BotType.beginner,
          botDescription: "Milica recently beat her dad at chess for the \nfirst time. Can you do any better than her dad \ndid?",
          botElo: 550),
      const BotEntities(
          botImage: 'assets/bot/beginner/milica-bot-icon.png',
          botName: 'Milica',
          botType: BotType.beginner,
          botDescription: "Milica recently beat her dad at chess for the \nfirst time. Can you do any better than her dad \ndid?",
          botElo: 550),
    ],
    // Advance

    [
      const BotEntities(
          botImage: 'assets/bot/advance/wendy-bot-icon.png',
          botName: 'Wendy',
          botType: BotType.advance,
          botDescription:
              "Wendy likes to play chess in front of \nthe fireplace. She'll sometimes throw some of her \npieces into the fire of her attack, so be careful.",
          botElo: 1500),
      const BotEntities(
          botImage: 'assets/bot/advance/pablo-bot-icon.png',
          botName: 'Pablo',
          botType: BotType.advance,
          botDescription:
              "Pablo is his local club champion, so he's gotten \na bit cocky. He'll try to catch you in the opening \nwith gambits, so be careful.",
          botElo: 1600),
      const BotEntities(
          botImage: 'assets/bot/advance/wendy-bot-icon.png',
          botName: 'Wendy',
          botType: BotType.advance,
          botDescription:
              "Wendy likes to play chess in front of \nthe fireplace. She'll sometimes throw some of her \npieces into the fire of her attack, so be careful.",
          botElo: 1500),
      const BotEntities(
          botImage: 'assets/bot/advance/pablo-bot-icon.png',
          botName: 'Pablo',
          botType: BotType.advance,
          botDescription:
              "Pablo is his local club champion, so he's gotten \na bit cocky. He'll try to catch you in the opening \nwith gambits, so be careful.",
          botElo: 1600),
      const BotEntities(
          botImage: 'assets/bot/advance/wendy-bot-icon.png',
          botName: 'Wendy',
          botType: BotType.advance,
          botDescription:
              "Wendy likes to play chess in front of \nthe fireplace. She'll sometimes throw some of her \npieces into the fire of her attack, so be careful.",
          botElo: 1500),
      const BotEntities(
          botImage: 'assets/bot/advance/pablo-bot-icon.png',
          botName: 'Pablo',
          botType: BotType.advance,
          botDescription:
              "Pablo is his local club champion, so he's gotten \na bit cocky. He'll try to catch you in the opening \nwith gambits, so be careful.",
          botElo: 1600),
      const BotEntities(
          botImage: 'assets/bot/advance/pablo-bot-icon.png',
          botName: 'Pablo',
          botType: BotType.advance,
          botDescription:
              "Pablo is his local club champion, so he's gotten \na bit cocky. He'll try to catch you in the opening \nwith gambits, so be careful.",
          botElo: 1600),
    ],

    // Master
    [
      const BotEntities(
          botImage: 'assets/bot/master/nora-bot-icon.png',
          botName: 'Nora',
          botType: BotType.master,
          botDescription:
              "Nora studied the games of Magnus Carlsen. \nShe's learned from his tactics but hasn't \nmastered his patience. Watch out for her queen!",
          botElo: 2200),
      const BotEntities(
          botImage: 'assets/bot/master/arjun-bot-icon.png',
          botName: 'Arjun',
          botType: BotType.master,
          botDescription:
              "Arjun's first moves will put you out of your \ncomfort zone, and then his accurate play will \npush you off the board!",
          botElo: 2300),
      const BotEntities(
          botImage: 'assets/bot/master/luke-bot-icon.png',
          botName: 'Nora',
          botType: BotType.master,
          botDescription:
              "Nora studied the games of Magnus Carlsen. \nShe's learned from his tactics but hasn't \nmastered his patience. Watch out for her queen!",
          botElo: 2200),
      const BotEntities(
          botImage: 'assets/bot/master/stockfish-bot-icon.png',
          botName: 'Arjun',
          botType: BotType.master,
          botDescription:
              "Arjun's first moves will put you out of your \ncomfort zone, and then his accurate play will \npush you off the board!",
          botElo: 2300),
    ],
  ]);
}
