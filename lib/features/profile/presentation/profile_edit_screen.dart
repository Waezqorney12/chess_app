import 'dart:io';

import 'package:chess_application/core/app_palette.dart';
import 'package:chess_application/core/app_text_style.dart';
import 'package:chess_application/core/utils/extension_utils.dart';
import 'package:chess_application/core/utils/image_utils.dart';
import 'package:chess_application/core/widget/appbar_widget.dart';
import 'package:chess_application/core/widget/field_widget.dart';
import 'package:chess_application/features/profile/domain/entities/profile_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileEditScreen extends StatefulWidget {
  final ProfileEntities profile;
  const ProfileEditScreen({super.key, required this.profile});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final statusController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();

  final countryController = TextEditingController();
  final locationController = TextEditingController();
  ValueNotifier<File?> imageFile = ValueNotifier(null);

  @override
  void dispose() {
    imageFile.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        onPressed: () => Navigator.pop(context),
        title: 'Edit Profile',
        style: AppTextStyle.montserrat20Bold,
        backgroundColor: AppPalette.appBarColor,
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () async => await pickImage().then((value) => imageFile.value = value),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                titleSection('Profile Picture'),
                ValueListenableBuilder(
                  valueListenable: imageFile,
                  builder: (context, value, child) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: widget.profile.profileImage != null && widget.profile.profileImage!.isNotEmpty
                          ? Image.network(widget.profile.profileImage!)
                          : imageFile.value != null
                              ? Image.file(imageFile.value!).sized(h: 52, w: 52)
                              : Image.asset('assets/default-profile.jpg').sized(h: 52, w: 52),
                    );
                  },
                )
              ],
            ).paddingSymmetric(horizontal: 16, vertical: 12),
          ),
          widgetField(
            context,
            icon: titleSection('Status'),
            hintText: '',
            controller: statusController,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            borderRadius: BorderRadius.zero,
            contentPadding: const EdgeInsets.only(left: 40),
            border: Border.symmetric(
              horizontal: BorderSide(color: AppPalette.appBarColor),
            ),
          ),
          widgetField(
            context,
            icon: titleSection('Username'),
            hintText: '',
            controller: usernameController,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            borderRadius: BorderRadius.zero,
            contentPadding: const EdgeInsets.only(left: 8),
            border: Border.symmetric(
              horizontal: BorderSide(color: AppPalette.appBarColor),
            ),
          ),
          widgetField(
            context,
            icon: titleSection('First Name'),
            hintText: '',
            controller: firstNameController,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            contentPadding: const EdgeInsets.only(left: 2),
            borderRadius: BorderRadius.zero,
            border: Border.symmetric(
              horizontal: BorderSide(color: AppPalette.appBarColor),
            ),
          ),
          widgetField(
            context,
            icon: titleSection('Last Name'),
            hintText: '',
            controller: lastNameController,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            contentPadding: const EdgeInsets.only(left: 4),
            borderRadius: BorderRadius.zero,
            border: Border.symmetric(
              horizontal: BorderSide(color: AppPalette.appBarColor),
            ),
          ),
          widgetField(
            context,
            icon: titleSection('Country'),
            hintText: '',
            controller: countryController,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            borderRadius: BorderRadius.zero,
            contentPadding: const EdgeInsets.only(left: 26),
            border: Border.symmetric(
              horizontal: BorderSide(color: AppPalette.appBarColor),
            ),
          ),
          widgetField(
            context,
            icon: titleSection('Location'),
            hintText: '',
            controller: locationController,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            borderRadius: BorderRadius.zero,
            contentPadding: const EdgeInsets.only(left: 22),
            border: Border.symmetric(
              horizontal: BorderSide(color: AppPalette.appBarColor),
            ),
          )
        ],
      ),
    );
  }

  Text titleSection(String title) {
    return Text(
      title,
      style: AppTextStyle.montserrat16Medium.copyWith(color: Colors.grey),
    );
  }
}
