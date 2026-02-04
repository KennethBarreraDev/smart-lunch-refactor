import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:smart_lunch/utils/banner_utils.dart' show BannerTypes;
import 'package:smart_lunch/utils/urls.dart' as urls;

class ChangePasswordProvider with ChangeNotifier {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordConfirmController = TextEditingController();

  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  bool isLoading = false;

  String bannerType = "";
  String bannerMessage = "";

  void changeCurrentPasswordVisibility() {
    obscureCurrentPassword = !obscureCurrentPassword;
    notifyListeners();
  }

  void changeNewPasswordVisibility() {
    obscureNewPassword = !obscureNewPassword;
    notifyListeners();
  }

  void changeConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  void resetFields() {
    currentPasswordController.clear();
    newPasswordController.clear();
    newPasswordConfirmController.clear();
  }

  Future<bool> verifyCurrentPassword(
      String accessToken, String username) async {
    developer.log("Start verify", name: "verifyCurrentPassword");
    bool isCurrentPasswordValid = true;
    await http
        .post(
      Uri.parse(urls.loginUrl),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: json.encode(
        <String, String>{
          "username": username,
          "password": currentPasswordController.text,
        },
      ),
    )
        .then(
      (response) {
        isCurrentPasswordValid = (response.statusCode == 200);
      },
    );
    return isCurrentPasswordValid;
  }

  Future<void> updatePassword(
    String accessToken,
    String cafeteriaId,
    String school,
    String username,
    String userId,
    String email,
    AppLocalizations? appLocalizations
  ) async {
    isLoading = true;
    notifyListeners();
    String currentPassword = currentPasswordController.text.trim();
    String newPassword = newPasswordController.text.trim();
    String newPasswordConfirm = newPasswordConfirmController.text.trim();

    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        newPasswordConfirm.isEmpty ||
        (newPassword != newPasswordConfirm)) {
      updateBanner(
        BannerTypes.warningBanner.type,
        appLocalizations,
      );
      isLoading = false;
      return;
    }
    bool isCurrentPasswordValid = await verifyCurrentPassword(
      accessToken,
      username,
    );
    if (!isCurrentPasswordValid) {
      isLoading = false;
      updateBanner(
        BannerTypes.errorBanner.type,
        appLocalizations,
      );
      return;
    }

    await http
        .patch(
      Uri.parse(
        "${urls.updateUser}$userId/",
      ),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
         "cafeteria": cafeteriaId,
        "Content-Type": "application/json",
      },
      body: json.encode(
        {
          "school": school,
          "password": newPassword,
          "username": username,
          "email": email
        },
      ),
    )
        .then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "updatePassword_statusCode",
        );
        developer.log(
          response.body.toString(),
          name: "updatePassword_body",

        );
        if (response.statusCode == 200) {
          isLoading = false;
          resetFields();
          updateBanner(
            BannerTypes.successBanner.type,
            appLocalizations,
          );
        } else {
          updateBanner(
            BannerTypes.unknownError.type,
            appLocalizations,
          );
        }
      },
    ).onError(
      (error, stackTrace) {
        isLoading = false;
        updateBanner(
          BannerTypes.unknownError.type,
          appLocalizations,
        );
      },
    );

    isLoading = false;
    notifyListeners();
  }

  void updateBanner(String type, AppLocalizations? appLocalizations) {
    bannerType = type;
    if (type == BannerTypes.successBanner.type) {
      bannerMessage = appLocalizations!.password_updated;
    } else if (type == BannerTypes.warningBanner.type) {
      bannerMessage = appLocalizations!.verify_information;
    } else if (type == BannerTypes.errorBanner.type) {
      bannerMessage = appLocalizations!.wrong_current_password;
    } else {
      bannerMessage = appLocalizations!.try_again_later;
    }
    notifyListeners();
  }

  void hideBanner() {
    bannerType = "";
    bannerMessage = "";
    notifyListeners();
  }
}
