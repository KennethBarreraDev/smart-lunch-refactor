import 'package:flutter/material.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/pages/preferences/change_password/change_password_provider.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/custom_banner.dart';
import 'package:smart_lunch/widgets/custom_text_input.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';


class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );

    return TransparentScaffold(
      selectedOption: "Ajustes",
      showDrawer: false,
      body: Column(
        children: [
          CustomAppBar(
            height: 160,
            showPageTitle: true,
            pageTitle: AppLocalizations.of(context)!.change_password,
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
                    child: Consumer<ChangePasswordProvider>(
                      builder: (context, changePasswordProvider, widget) =>
                          Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          CustomTextInput(
                            label: AppLocalizations.of(context)!.current_password,
                            textInputType: TextInputType.visiblePassword,
                            textEditingController: changePasswordProvider
                                .currentPasswordController,
                            obscurePassword:
                                changePasswordProvider.obscureCurrentPassword,
                            onVisibilityChange: changePasswordProvider
                                .changeCurrentPasswordVisibility,
                          ),
                          CustomTextInput(
                            label: AppLocalizations.of(context)!.new_password,
                            textInputType: TextInputType.visiblePassword,
                            textEditingController:
                                changePasswordProvider.newPasswordController,
                            obscurePassword:
                                changePasswordProvider.obscureNewPassword,
                            onVisibilityChange: changePasswordProvider
                                .changeNewPasswordVisibility,
                          ),
                          CustomTextInput(
                            label: AppLocalizations.of(context)!.confirm_password,
                            textInputType: TextInputType.visiblePassword,
                            textEditingController: changePasswordProvider
                                .newPasswordConfirmController,
                            obscurePassword:
                                changePasswordProvider.obscureConfirmPassword,
                            onVisibilityChange: changePasswordProvider
                                .changeConfirmPasswordVisibility,
                          ),
                          const SizedBox(
                            height: 24,
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

                                if(mainProvider.userType==UserRole.tutor){
                                  changePasswordProvider.updatePassword(
                                    mainProvider.accessToken,
                                    mainProvider.cafeteriaId,
                                    mainProvider.tutor?.school?? "",
                                    mainProvider.tutor?.username ?? "",
                                    mainProvider.tutor?.userId ?? "",
                                    mainProvider.tutor?.email ?? "",
                                    AppLocalizations.of(context),
                                  );
                                }
                                else if(mainProvider.userType==UserRole.student){
                                  changePasswordProvider.updatePassword(
                                    mainProvider.accessToken,
                                    mainProvider.cafeteriaId,
                                    mainProvider.selectedChild?.school?? "",
                                    mainProvider.selectedChild?.username ?? "",
                                    mainProvider.selectedChild?.userId ?? "",
                                    mainProvider.selectedChild?.email ?? "",
                                    AppLocalizations.of(context),
                                  );
                                }

                              },
                              child: !changePasswordProvider.isLoading
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.lock_reset,
                                          color: colors.tuitionGreen,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.update_password,
                                          style: const TextStyle(
                                            color: colors.tuitionGreen,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
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
                  Consumer<ChangePasswordProvider>(
                    builder: (context, changePasswordProvider, widget) =>
                        CustomBanner(
                      bannerType: changePasswordProvider.bannerType,
                      bannerMessage: changePasswordProvider.bannerMessage,
                      hideBanner: changePasswordProvider.hideBanner,
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
