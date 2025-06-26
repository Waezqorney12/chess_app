import 'package:chess_application/features/bot/presentation/bot_screen.dart';
import 'package:chess_application/features/friendlist/presentation/friendlist_screen.dart';
import 'package:chess_application/features/game/game_puzzle_screen.dart';
import 'package:chess_application/features/game/game_screen.dart';
import 'package:chess_application/features/game/game_settings_screen.dart';
import 'package:chess_application/features/home/presentation/home_screen.dart';
import 'package:chess_application/features/lesson/chess_lesson_screen.dart';
import 'package:chess_application/features/profile/domain/entities/profile_entities.dart';
import 'package:chess_application/features/profile/presentation/profile_screen.dart';
import 'package:chess_application/features/register/presentation/register_screen.dart';
import 'package:chess_application/features/register/presentation/thumbnail_register_screen.dart';
import 'package:flutter/material.dart';

import '../features/login/presentation/login_screen.dart';
import '../features/profile/presentation/profile_edit_screen.dart';

class Routes {
  static MaterialPageRoute login() => MaterialPageRoute(builder: (context) => const LoginScreen());
  static MaterialPageRoute regist() => MaterialPageRoute(builder: (context) => const RegisterScreen());
  static MaterialPageRoute thumbnailRegist() => MaterialPageRoute(builder: (context) => const ThumbnailRegisterScreen());
  static MaterialPageRoute game({required int timer}) => MaterialPageRoute(builder: (context) => GameScreen(timer: timer));
  static MaterialPageRoute home() => MaterialPageRoute(builder: (context) => const HomeScreen());
  static MaterialPageRoute gameSettings() => MaterialPageRoute(builder: (context) => const GameSettingsScreen());
  static MaterialPageRoute puzzle() => MaterialPageRoute(builder: (context) => const GamePuzzleScreen());
  static MaterialPageRoute lesson() => MaterialPageRoute(builder: (context) => const ChessLessonScreen());
  static MaterialPageRoute friendlist() => MaterialPageRoute(builder: (context) => const FriendlistScreen());
  static MaterialPageRoute bot() => MaterialPageRoute(builder: (context) => BotScreen());
  static MaterialPageRoute profile() => MaterialPageRoute(builder: (context) => const ProfileScreen());
  static MaterialPageRoute profileEdit() => MaterialPageRoute(
      builder: (context) => ProfileEditScreen(
            profile: ProfileEntities(),
          ));
}
