import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:smart_lunch/common_providers/main_provider.dart';
import 'package:smart_lunch/common_providers/storage_provider.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/utils/save_user_info.dart';
import 'package:smart_lunch/utils/urls.dart' as urls;

class LoginProvider with ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;
  bool hasLoginError = false;

  void changePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<UserRole> login(MainProvider mainProvider,
      StorageProvider storageProvider) async {
    bool isValid = false;
    hasLoginError = false;
    UserRole userType = UserRole.none;
    await storageProvider.deleteAll();

    isLoading = true;
    notifyListeners();

    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      isLoading = false;
      hasLoginError = true;
      notifyListeners();
      developer.log("Returned false", name: "login_1");
      return userType;
    }
    await http
        .post(
      Uri.parse(urls.loginUrl),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: json.encode(
        <String, String>{
          "username": usernameController.text,
          "password": passwordController.text,
        },
      ),
    )
        .then(
      (response) async {
        developer.log(response.statusCode.toString(), name: "login_statusCode");
        developer.log("Login body ${response.body}");
        if (response.statusCode == 200) {
          isValid = true;
          Map<String, dynamic> responseMap = json.decode(response.body);
          String accessToken = responseMap["access"] ?? "";
          developer.log("Token $accessToken", name: "token devuelto");

          String refreshToken = responseMap["refresh"] ?? "";

          Map<String, dynamic> decodedAccessToken =
              JwtDecoder.decode(accessToken);

          bool isTutor = decodedAccessToken["groups"].contains("Tutor");
          bool isStudent = decodedAccessToken["groups"].contains("Student");
          bool isTeacher = decodedAccessToken["groups"].contains("Teacher");

          developer.log(decodedAccessToken.toString(), name: "login_body");

          if (isTeacher) {
            userType = UserRole.teacher;

            await saveUserInfo(
                storageProvider,
                accessToken,
                refreshToken,
                "Teacher",
                decodedAccessToken["tutor_id"].toString(),
                decodedAccessToken["family_id"].toString());
            usernameController.text = "";
            passwordController.text = "";
          } else if (isTutor) {
            userType = UserRole.tutor;

            await saveUserInfo(
                storageProvider,
                accessToken,
                refreshToken,
                "Tutor",
                decodedAccessToken["tutor_id"].toString(),
                decodedAccessToken["family_id"].toString());
            usernameController.text = "";
            passwordController.text = "";
          } else if (isStudent) {
            userType = UserRole.student;
            await saveUserInfo(
                storageProvider,
                accessToken,
                refreshToken,
                "Student",
                decodedAccessToken["student_id"].toString(),
                decodedAccessToken["family_id"].toString());
            usernameController.text = "";
            passwordController.text = "";
          } else {
            hasLoginError = true;
            developer.log("Returned false", name: "login");
          }
        } else {
          // Show error
          isLoading = false;
          hasLoginError = true;
          userType = UserRole.none;
          notifyListeners();
          developer.log("Returned false", name: "login_1");
          return userType;
        }
      },
    );
    developer.log("Returned ${isValid.toString()}", name: "login_2");
    return userType;
  }

  void resetLoadingButton() {
    isLoading = false;
    notifyListeners();
  }

  void resetError() {
    hasLoginError = false;
  }
}
