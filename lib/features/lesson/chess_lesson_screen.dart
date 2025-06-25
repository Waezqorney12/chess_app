import 'package:chess_application/core/widget/appbar_widget.dart';
import 'package:flutter/material.dart';

class ChessLessonScreen extends StatelessWidget {
  const ChessLessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
