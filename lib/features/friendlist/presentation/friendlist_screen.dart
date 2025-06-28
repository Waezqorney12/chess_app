import 'package:chess_application/core/app_palette.dart';
import 'package:chess_application/core/app_text_style.dart';
import 'package:chess_application/core/routes_pages.dart';
import 'package:chess_application/core/utils/extension_utils.dart';
import 'package:chess_application/core/utils/positioned_utils.dart';
import 'package:chess_application/core/utils/string_utils.dart';
import 'package:chess_application/core/widget/appbar_widget.dart';
import 'package:chess_application/core/widget/field_widget.dart';
import 'package:flutter/material.dart';

class FriendlistScreen extends StatefulWidget {
  const FriendlistScreen({super.key});

  @override
  State<FriendlistScreen> createState() => _FriendlistScreenState();
}

class _FriendlistScreenState extends State<FriendlistScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context,
          actions: [
            IconButton(
                onPressed: () => Navigator.push(context, Routes.chat()),
                icon: const Icon(
                  Icons.inbox_rounded,
                  color: Colors.grey,
                ))
          ],
          onPressed: () => Navigator.pop(context),
          backgroundColor: AppPalette.appBarColor,
          title: 'Friends',
          style: AppTextStyle.montserrat20ExtraBold.copyWith(
            color: Colors.grey,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Challenge Link
            ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.link,
                          color: Colors.white,
                          size: 24,
                        ).paddingOnly(right: 8),
                        Text(
                          'Send Challenge Link',
                          style: AppTextStyle.montserrat16Bold,
                        )
                      ],
                    ))
                .styledButton(width: Dimensions.screenWidht(context), height: 50, color: AppPalette.appBarColor)
                .paddingSymmetric(vertical: 20),

            // Search Functions
            widgetField(
              context,
              hintText: 'Search by name or username',
              controller: searchController,
              icon: const Icon(
                Icons.search,
                color: Colors.grey,
              ).paddingOnly(left: 12),
            ),

            // Friends Text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Friends',
                      style: AppTextStyle.montserrat20Bold,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade700,
                      ),
                      child: Text(
                        '12',
                        style: AppTextStyle.montserrat12Semi,
                      ).paddingAll(4),
                    ).paddingSymmetric(horizontal: 8)
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bar_chart,
                    color: Colors.white,
                    size: 28,
                  ),
                )
              ],
            ),

            // Friendlist
            ...List.generate(
              8,
              (index) {
                return SizedBox(
                  height: 80,
                  width: Dimensions.screenWidht(context),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/thumbnail-chessboard.jpg'),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringUtils.exceededLength12('Asep Kurniawan'),
                            style: AppTextStyle.montserrat16Bold,
                          ),
                          Text(
                            StringUtils.exceededLength12('Asep Kurniawan'),
                            style: AppTextStyle.montserrat16Reguler.copyWith(color: Colors.grey),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset('assets/decoration-icon.png').sized(h: 16, w: 16).paddingOnly(top: 8),
                              Text(
                                '1200',
                                style: AppTextStyle.montserrat12Semi.copyWith(
                                  color: Colors.grey,
                                ),
                              ).paddingOnly(left: 4),
                            ],
                          )
                        ],
                      ).paddingOnly(left: 12),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_horiz_rounded,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppPalette.appBarColor,
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_alarm_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ).paddingSymmetric(vertical: 12);
              },
            )
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }
}
