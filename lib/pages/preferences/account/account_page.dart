import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/pages/preferences/account/account_provider.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/custom_banner.dart';
import 'package:smart_lunch/widgets/custom_text_input.dart';
import 'package:smart_lunch/widgets/profile_picture_avatar.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransparentScaffold(
      selectedOption: "Ajustes",
      showDrawer: false,
      body: Column(
        children: [
          CustomAppBar(
            height: 160,
            showPageTitle: true,
            pageTitle: AppLocalizations.of(context)!.account_message,
            titleAlignment: Alignment.bottomRight,
            image: images.appBarShortImg,
            showDrawer: false,
          ),
          const SizedBox(
            height: 9,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    child: Consumer2<MainProvider, AccountProvider>(
                      builder:
                          (context, mainProvider, accountProvider, widget) =>
                              Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.student_information,
                            style: const TextStyle(
                              color: Color(0xff413931),
                              fontSize: 22.0,
                                fontFamily: "Comfortaa"
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ProfilePictureAvatar(
                            width: 160,
                            height: 160,
                            profileImageFile: accountProvider.profileImageFile,
                            profileImageUrl: mainProvider.tutor?.profilePictureUrl,
                            onPressed: accountProvider.selectProfilePicture,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          CustomTextInput(
                            label: AppLocalizations.of(context)!.user_name,
                            textInputType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            textEditingController:
                                accountProvider.firstNameController
                                  ..text = mainProvider.tutor?.firstName ?? "",
                          ),
                          CustomTextInput(
                            label:  AppLocalizations.of(context)!.user_lastname,
                            textInputType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            textEditingController:
                                accountProvider.lastNameController
                                  ..text = mainProvider.tutor?.lastName ?? "",
                          ),
                          CustomTextInput(
                            label: AppLocalizations.of(context)!.phone_numer,
                            textInputType: TextInputType.phone,
                            textEditingController: accountProvider
                                .phoneNumberController
                              ..text = mainProvider.tutor?.phoneNumber ?? "",
                          ),
                          CustomTextInput(
                            label: AppLocalizations.of(context)!.email,
                            textInputType: TextInputType.emailAddress,
                            initialValue: mainProvider.tutor?.email ?? "",
                            enabled: false,
                          ),
                          FractionallySizedBox(
                            widthFactor: 1,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 13,
                                  horizontal: 24,
                                ),
                                backgroundColor:
                                    colors.tuitionGreen.withOpacity(0.15),
                                shadowColor: Colors.transparent,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                mainProvider
                                    .updateTutor(
                                  accountProvider.firstNameController.text
                                      .trim(),
                                  accountProvider.lastNameController.text
                                      .trim(),
                                  accountProvider.phoneNumberController.text
                                      .trim(),
                                  base64Encode(
                                    accountProvider.profileImageFile
                                            ?.readAsBytesSync() ??
                                        [],
                                  ),
                                  mainProvider.tutor!.familyId,
                                  mainProvider.tutor!.birthDate
                                )
                                    .then(
                                  (bannerType) {
                                    accountProvider.resetImage();
                                    accountProvider.updateBanner(
                                      bannerType,
                                      AppLocalizations.of(context),
                                    );
                                  },
                                );
                              },
                              child: !mainProvider.isLoading
                                  ? Text(
                                      AppLocalizations.of(context)!.save_button,
                                      style: const TextStyle(
                                        color: colors.tuitionGreen,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0,
                                      ),
                                    )
                                  : const SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(
                                        color: colors.tuitionGreen,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Consumer<AccountProvider>(
                    builder: (context, accountProvider, widget) => CustomBanner(
                      bannerType: accountProvider.bannerType,
                      bannerMessage: accountProvider.bannerMessage,
                      hideBanner: accountProvider.hideBanner,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
