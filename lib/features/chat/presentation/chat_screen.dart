import 'package:chess_application/core/app_palette.dart';
import 'package:chess_application/core/app_text_style.dart';
import 'package:chess_application/core/utils/extension_utils.dart';
import 'package:chess_application/core/utils/positioned_utils.dart';
import 'package:chess_application/core/widget/appbar_widget.dart';
import 'package:chess_application/core/widget/field_widget.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPalette.appBarColor,
        title: widgetField(
          context,
          icon: const Icon(Icons.search, color: Colors.grey),
          padding: const EdgeInsets.only(left: 12),
          hintText: 'Search...',
          controller: searchController,
        ),
        bottom: PreferredSize(
          preferredSize: Size(Dimensions.screenWidht(context), 12),
          child: const SizedBox.shrink(),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.grey,
            )),
      ),
      body: Container(
        height: 80,
        width: Dimensions.screenWidht(context),
        decoration: const BoxDecoration(
          border: Border.symmetric(horizontal: BorderSide(color: Colors.white)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset('assets/default-profile.jpg').sized(w: 52, h: 52),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Asep Kurniawan',
                        style: AppTextStyle.montserrat12Semi,
                      ),
                      Text(
                        '2 months ago',
                        style: AppTextStyle.montserrat12Semi.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'You and Asep Kurniawan are aspjoddsap',
                    style: AppTextStyle.montserrat12.copyWith(
                      color: Colors.grey,
                    ),
                  ).paddingOnly(top: 8)
                ],
              ).paddingSymmetric(horizontal: 12),
            ),
          ],
        ).paddingAll(12),
      ),
    );
  }
}
