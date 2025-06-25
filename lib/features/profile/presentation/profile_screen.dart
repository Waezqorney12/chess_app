import 'package:chess_application/core/app_palette.dart';
import 'package:chess_application/core/app_text_style.dart';
import 'package:chess_application/core/routes_pages.dart';
import 'package:chess_application/core/utils/extension_utils.dart';
import 'package:chess_application/core/utils/positioned_utils.dart';
import 'package:chess_application/core/utils/string_utils.dart';
import 'package:chess_application/core/widget/appbar_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, onPressed: () => Navigator.pop(context), backgroundColor: AppPalette.appBarColor, actions: [
        IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    backgroundColor: Colors.transparent,
                    content: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 0,
                          right: Dimensions.minWidht80(context),
                          child: Container(
                            height: 100,
                            width: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppPalette.appBarColor,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                optionsEdit(
                                  onTap: () => Navigator.push(context, Routes.profileEdit()).then(
                                    (_) => Navigator.pop(context),
                                  ),
                                  title: 'Edit',
                                ),
                                optionsEdit(
                                  onTap: () {},
                                  title: 'Share Profile',
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              );
            },
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.grey,
              size: 28,
            ))
      ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              color: AppPalette.appBarColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/default-profile.jpg').sized(h: 100, w: 100),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringUtils.exceededLength18('Asep Kurniawan'),
                            style: AppTextStyle.montserrat20ExtraBold,
                          ),
                          Text(
                            'firstName lastName',
                            style: AppTextStyle.montserrat12Semi.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ).paddingOnly(left: 12)
                    ],
                  ).sized(h: 100, w: Dimensions.screenWidht(context)),
                  Text(
                    'Joined Jun 2, 2022',
                    style: AppTextStyle.montserrat16Reguler.copyWith(color: Colors.grey),
                  ).paddingSymmetric(vertical: 12)
                ],
              ).paddingSymmetric(horizontal: 16),
            ),

            // Stats Section
            Text(
              'Stats',
              style: AppTextStyle.montserrat20Semi,
            ).paddingSymmetric(horizontal: 16, vertical: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: stats.asMap().entries.map(
                (stats) {
                  return Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppPalette.appBarColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          stats.value['title'],
                          style: AppTextStyle.poppins16.copyWith(
                            color: Colors.grey,
                          ),
                        ).paddingOnly(bottom: 8),
                        stats.value['icon'] == Icon ? stats.value['icon'] : stats.value['icon'],
                        Text(
                          stats.value['score'].toString(),
                          style: AppTextStyle.montserrat16Bold,
                        ).paddingOnly(top: 8)
                      ],
                    ),
                  ).paddingSymmetric(horizontal: 16);
                },
              ).toList(),
            ),

            // Recent Games Section
            section('Recent Games', 196).paddingSymmetric(vertical: 16),
            ...List.generate(
              5,
              (index) {
                return InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        color: AppPalette.greenColor,
                        size: 28,
                      ),
                      Container(
                        clipBehavior: Clip.antiAlias,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Image.asset('assets/default-profile.jpg'),
                      ).paddingSymmetric(horizontal: 16),
                      Text(
                        StringUtils.exceededLength12('potpothospottt'),
                        style: AppTextStyle.montserrat16Medium,
                      ),
                      Text(
                        ' (696)',
                        style: AppTextStyle.montserrat16Reguler,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.add_box_rounded,
                        color: Colors.green,
                      ),
                      Text(
                        '70.8',
                        style: AppTextStyle.montserrat16Reguler,
                      ).paddingSymmetric(horizontal: 16)
                    ],
                  ).paddingSymmetric(vertical: 12),
                );
              },
            ),

            // Friends Section
            section('Friends', 12).paddingSymmetric(vertical: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  8,
                  (index) {
                    return Column(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Image.asset('assets/default-profile.jpg'),
                        ).paddingSymmetric(horizontal: 8),
                        Text(
                          StringUtils.exceededLength8('Asep Kurniawan'),
                          style: AppTextStyle.poppins12.copyWith(color: Colors.grey.shade400),
                        )
                      ],
                    );
                  },
                ),
              ),
            )
            // Awards Section
          ],
        ),
      ),
    );
  }

  Widget optionsEdit({required String title, required void Function()? onTap}) {
    return TextButton(
        style: TextButton.styleFrom(
            minimumSize: const Size(double.infinity, 50), // Make the button fill the row
            alignment: Alignment.centerLeft, // Align text to the left
            splashFactory: InkRipple.splashFactory,
            shape: const BeveledRectangleBorder() // Ensure ripple effect
            ),
        onPressed: onTap,
        child: Text(
          title,
          style: AppTextStyle.poppins16,
        ));
  }

  Container section(String title, int length) {
    return Container(
      color: AppPalette.appBarColor,
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyle.montserrat20Semi,
          ).paddingSymmetric(horizontal: 16, vertical: 16),
          space(),
          Text(
            length.toString(),
            style: AppTextStyle.montserrat16Medium.copyWith(
              color: Colors.grey,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
            size: 20,
          ).paddingSymmetric(horizontal: 8)
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> stats = [
  {
    "title": "Bullet",
    "icon": Image.asset('assets/bullet-icon.png').sized(
      h: 40,
      w: 40,
    ),
    "score": 1312
  },
  {
    "title": "Rapid",
    "icon": Icon(
      Icons.timer_outlined,
      color: AppPalette.greenColor,
      size: 36,
    ),
    "score": 1191
  }
];
