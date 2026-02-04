import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/models/app_version.dart';
import 'package:smart_lunch/models/cafeteria_settings.dart';
import 'package:smart_lunch/models/child_model.dart';
import 'package:smart_lunch/models/presale_model.dart';
import 'package:smart_lunch/models/tutor_model.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/pages/panama/static_values.dart';
import 'package:smart_lunch/utils/banner_utils.dart' show BannerTypes;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/utils/save_user_info.dart';
import 'package:smart_lunch/utils/urls.dart' as urls;
import 'package:smart_lunch/pages/preferences/lang/languaje_provider.dart';

import 'dart:io' show Platform;

class MainProvider with ChangeNotifier {
  String accessToken = "";
  String refreshToken = "";
  String cafeteriaId = "";
  String tutorId = "";
  String studentId = "0";
  String familyBalance = "";
  CafeteriaSetting? cafeteriaSetting;
  UserRole userType = UserRole.none;
  double balance = 0;
  String familyId = "";
  bool appIsUpdated = false;
  bool membershipDebt = false;
  bool fetchingData = false;

  bool hideSalesForIndependentStudent = true;

  Tutor? tutor;
  Map<int, int> membershipCart = {};
  double membershipTotalPrice = 0;
  List<Child> children = [];
  List<Child> debtors = [];
  List<Child> membershipDebtors = [];
  List<Child> membershipDebtorsSelected = [];
  bool showMembershipModal = false;

  double totalDebt = 0;

  Child? selectedChild;
  bool isLoading = false;

  bool isUpdatingAllergies = false;
  bool isUpdatingLimitedProducts = false;
  bool isUpdatingForbiddenProducts = false;
  bool isUpdatingSpendingLimit = false;

  String allergyUpdateBannerType = "";
  String allergyUpdateBannerMessage = "";

  String spendingLimitUpdateBannerType = "";
  String spendingLimitUpdateBannerMessage = "";

  String limitedProductsUpdateBannerType = "";
  String limitedProductsUpdateBannerMessage = "";
  String limitedProductsFrecuency = "daily";

  String forbiddenProductsBannerType = "";
  String forbiddenProductsBannerMessage = "";

  List<String> limits = List<String>.generate(
    10,
    (index) => index == 0 ? "-" : (index).toString(),
  );

  TextEditingController dailySpendLimitController = TextEditingController();
  TextEditingController otherAllergiesController = TextEditingController();
  bool dailySpendHasLimit = false;

  void resetMembershipCart() {
    membershipCart = {};

    membershipTotalPrice = 0;
    fillDefaultMemberships();
    notifyListeners();
  }

  void setFrencuencyValue(String value) {
    notifyListeners();
    limitedProductsFrecuency = value;
    notifyListeners();
  }

  void hideMembershipModal(bool value) {
    showMembershipModal = value;
    notifyListeners();
  }

  void updateAllergyUpdateBanner(
    String type,
    AppLocalizations? appLocalizations,
  ) {
    allergyUpdateBannerType = type;
    if (type == BannerTypes.successBanner.type) {
      allergyUpdateBannerMessage =
          appLocalizations!.updated_allergies_successfully;
    } else {
      allergyUpdateBannerMessage = appLocalizations!.updated_allergies_error;
    }
  }

  void updateSpendingLimitUpdateBanner(
    String type,
    AppLocalizations? appLocalizations,
  ) {
    spendingLimitUpdateBannerType = type;
    if (type == BannerTypes.successBanner.type) {
      spendingLimitUpdateBannerMessage =
          appLocalizations!.balance_body_updated_succesfully;
    } else {
      spendingLimitUpdateBannerMessage =
          appLocalizations!.balace_body_updated_error;
    }
  }

  void updateLimitedProductsUpdateBanner(
    String type,
    AppLocalizations? appLocalizations,
  ) {
    limitedProductsUpdateBannerType = type;
    if (type == BannerTypes.successBanner.type) {
      limitedProductsUpdateBannerMessage =
          appLocalizations!.limited_products_succesfully;
    } else {
      limitedProductsUpdateBannerMessage =
          appLocalizations!.limited_products_error;
    }
  }

  void updateForbiddenProductsBanner(
    String type,
    AppLocalizations? appLocalizations,
  ) {
    forbiddenProductsBannerType = type;
    if (type == BannerTypes.successBanner.type) {
      forbiddenProductsBannerMessage =
          appLocalizations!.forbidden_products_succesfully;
    } else {
      forbiddenProductsBannerMessage =
          appLocalizations!.forbidden_products_error;
    }
  }

  void hideAllergyUpdateBanner() {
    allergyUpdateBannerType = "";
    allergyUpdateBannerMessage = "";
    notifyListeners();
  }

  void hideSpendingLimitUpdateBanner() {
    spendingLimitUpdateBannerType = "";
    spendingLimitUpdateBannerMessage = "";
    notifyListeners();
  }

  void hideLimitedProductsUpdateBanner() {
    limitedProductsUpdateBannerType = "";
    limitedProductsUpdateBannerMessage = "";
    notifyListeners();
  }

  void hideForbiddenProductsBanner() {
    forbiddenProductsBannerType = "";
    forbiddenProductsBannerMessage = "";
    notifyListeners();
  }

  void resetFields() {
    accessToken = "";
    refreshToken = "";
    cafeteriaId = "";
    tutorId = "";
    familyId = "";

    tutor = null;

    children = [];
    selectedChild = null;
    otherAllergiesController.clear();
    isLoading = false;
  }

  Future<String> getCafeteria(StorageProvider storageProvider) async {
    cafeteriaId = await storageProvider.readValue("cafeteriaId");
    print("La cafeteria es " + cafeteriaId);
    return cafeteriaId;
  }

  void setCafeteriaID(int cafeteriaID) {
    cafeteriaId = cafeteriaID.toString();
    notifyListeners();
  }

  Future<void> updateLoginInfo(StorageProvider storageProvider) async {
    String storedRole = "";
    accessToken = await storageProvider.readValue("accessToken");
    refreshToken = await storageProvider.readValue("refreshToken");
    tutorId = await storageProvider.readValue("tutorId");
    storedRole = await storageProvider.readValue("userType");
    familyId = await storageProvider.readValue("familyId");

    switch (storedRole) {
      case "Tutor":
        userType = UserRole.tutor;
        break;
      case "Student":
        userType = UserRole.student;
        break;
      case "Teacher":
        userType = UserRole.teacher;
        break;
    }

    if (userType == UserRole.student) {
      studentId = await storageProvider.readValue("studentId");
      developer.log(studentId, name: "updateLoginInfo_userId");
    } else {
      studentId = await storageProvider.readValue("tutorId");
    }

    /*
    if(userType=="Tutor"){
      await loadDebtorsChildren();
    }*/

    developer.log("Updated refreshAccessToken info", name: "updateLoginInfo");
    developer.log(accessToken, name: "updateLoginInfo_accessToken");
    developer.log(refreshToken, name: "updateLoginInfo_refreshToken");
    developer.log(cafeteriaId, name: "updateLoginInfo_cafeteriaId");
    developer.log(tutorId, name: "updateLoginInfo_tutorId");
    developer.log(userType.toString(), name: "updateLoginInfo_userType");
    developer.log(familyId, name: "updateLoginInfo_familyId");

    notifyListeners();
  }

  Future<String> refreshAccessToken(StorageProvider storageProvider) async {
    await storageProvider.deleteAll();
    accessToken = "";

    await http
        .post(
      Uri.parse(urls.refreshTokenUrl),
      headers: <String, String>{
        "Content-Type": "application/json",
        "cafeteria": cafeteriaId
      },
      body: json.encode(
        <String, String>{
          "refresh": refreshToken,
        },
      ),
    )
        .then(
      (response) async {
        developer.log(response.statusCode.toString(),
            name: "refreshAccessToken_statusCode");
        if (response.statusCode == 200) {
          Map<String, dynamic> responseMap = json.decode(response.body);
          accessToken = responseMap["access"] ?? "";
          refreshToken = responseMap["refresh"] ?? "";

          Map<String, dynamic> decodedAccessToken =
              JwtDecoder.decode(accessToken);

          await storageProvider.deleteAll();

          bool isTutor = decodedAccessToken["groups"].contains("Tutor");
          bool isStudent = decodedAccessToken["groups"].contains("Student");
          bool isTeacher = decodedAccessToken["groups"].contains("Teacher");

          developer.log(decodedAccessToken.toString(), name: "refresh_body");

          if (isTeacher) {
            cafeteriaId = decodedAccessToken["cafeteria_id"]?.toString() ?? "";
            tutorId = decodedAccessToken["tutor_id"]?.toString() ?? "";
            familyId = decodedAccessToken["family_id"]?.toString() ?? "";
            userType = UserRole.teacher;
            await saveUserInfo(
                storageProvider,
                accessToken,
                refreshToken,
                "Teacher",
                decodedAccessToken["tutor_id"].toString(),
                decodedAccessToken["family_id"].toString());
          } else if (isTutor) {
            cafeteriaId = decodedAccessToken["cafeteria_id"]?.toString() ?? "";
            tutorId = decodedAccessToken["tutor_id"]?.toString() ?? "";
            familyId = decodedAccessToken["family_id"]?.toString() ?? "";
            userType = UserRole.tutor;
            await saveUserInfo(
                storageProvider,
                accessToken,
                refreshToken,
                "Tutor",
                decodedAccessToken["tutor_id"].toString(),
                decodedAccessToken["family_id"].toString());
          } else if (isStudent) {
            cafeteriaId = decodedAccessToken["cafeteria_id"]?.toString() ?? "";
            studentId = decodedAccessToken["student_id"]?.toString() ?? "";
            familyId = decodedAccessToken["familiy_id"]?.toString() ?? "";
            userType = UserRole.student;
            await saveUserInfo(
                storageProvider,
                accessToken,
                refreshToken,
                "Student",
                decodedAccessToken["student_id"].toString(),
                decodedAccessToken["family_id"].toString());
          }
        } else {}
      },
    );
    developer.log("Returned $accessToken", name: "refreshAccessToken_2");
    loadCafeteriaSetting();
    loadBalance();

    /*
    if(userType=="Tutor"){
      loadDebtorsChildren();
    }*/

    loadDebtorsChildren();
    notifyListeners();
    return accessToken;
  }

  Future<void> getChildren() async {
    membershipDebtors.clear();
    showMembershipModal = false;
    developer.log("Get children start", name: "getChildren");
    developer.log(urls.getChildrenUrl, name: "getChildren_url");
    developer.log(cafeteriaId, name: "CafeteriaIdentifierGetChildren");
    await http.get(
      Uri.parse(urls.getChildrenUrl),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) async {
        developer.log(
          response.statusCode.toString(),
          name: "getChildren_statusCode",
        );
        if (response.statusCode == 200) {
          developer.log(
            utf8.decode(response.bodyBytes),
            name: "getChildren_info",
          );
          children = [];
          List<dynamic> body =
              json.decode(utf8.decode(response.bodyBytes))["results"];

          if (userType == UserRole.tutor) {
            for (dynamic child in body) {
              developer.log(child.toString(), name: "getChildren_child");
              Child student = Child.fromJson(child);
              print(
                  "Info ${student.membership} ${student.membershipExpiration}");

              if (student.membership == true &&
                  student.membershipExpiration != null) {
                membershipDebtors.add(student);
              }
              children.add(student);
            }

            selectedChild = children.isNotEmpty ? children[0] : null;
            otherAllergiesController.text = selectedChild?.customAllergy ?? "";
          } else if (userType == UserRole.student) {
            for (dynamic child in body) {
              developer.log(child.toString(), name: "getChildren_child");
              Child student = Child.fromJson(child);
              if (student.id == int.parse(studentId)) {
                if (student.membership == true &&
                    student.membershipExpiration != null) {
                  membershipDebtors.add(student);
                }
                children.add(student);

                selectedChild = student;
                otherAllergiesController.text =
                    selectedChild?.customAllergy ?? "";
              }
            }
            await getStudentInfo(int.parse(studentId));
          }

          //selectedChild = children[0];

          //getForbiddenProductsByChild();

          fillDefaultMemberships();
          notifyListeners();
        } else {
          // Show error
        }
      },
    );
    notifyListeners();
  }

  void fillDefaultMemberships() {
    if (membershipDebtors.any((element) => element.membership)) {
      showMembershipModal = membershipDebtors.any((student) =>
          (DateTime.parse(student.membershipExpiration ?? "")
              .isBefore(DateTime.now())));

      membershipDebtors
          .where((student) =>
              (DateTime.parse(student.membershipExpiration ?? "")
                  .isBefore(DateTime.now())))
          .toList()
          .forEach((e) {
        membershipCart.addAll(
          {
            e.id: 1,
          },
        );
        membershipTotalPrice += YappyValues.membershipPrice;
      });
    }

    print("Carrito es: $membershipCart");

    notifyListeners();
  }

  Future<void> loadCafeteriaSetting() async {
    late StorageProvider storageProvider = StorageProvider();
    String cafeteriaId = await storageProvider.readValue("cafeteriaId");
    String accessToken = await storageProvider.readValue("accessToken");
    //String refreshToken = await storageProvider.readValue("refreshToken");

    developer.log(
      cafeteriaId,
      name: "CafeteriaIdentifierLoadCafeteriaSetting",
    );
    developer.log(
      cafeteriaId,
      name: "cafeteriaLoadSetting",
    );
    await http.get(
      Uri.parse("${urls.getCafeteriaSettingsUrl}?cafeteria=$cafeteriaId/"),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "loadCafeteriaSetting_statusCode",
        );
        developer.log(
          json.decode(response.body).toString(),
          name: "loadCafeteriaSetting_body",
        );

        if (response.statusCode == 200) {
          cafeteriaSetting = CafeteriaSetting.fromJson(
              json.decode((utf8.decode(response.bodyBytes))));
          notifyListeners();
        } else {
          // Show error
        }
      },
    );
  }

  Future<void> updateSpendingLimit(AppLocalizations? appLocalizations) async {
    isUpdatingSpendingLimit = true;
    notifyListeners();
    developer.log(
      "${urls.updateSpendingLimitUrl}${selectedChild?.id}/",
      name: "updateSpendingLimit",
    );

    developer.log(
      cafeteriaId,
      name: "CafeteriaIdentifierUpdateSpendingLimit",
    );

    await http
        .patch(
      Uri.parse("${urls.updateSpendingLimitUrl}${selectedChild?.id}/"),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId,
        "Content-Type": "application/json",
      },
      body: json.encode(
        {
          "daily_limit":
              dailySpendHasLimit ? dailySpendLimitController.text : "0",
        },
      ),
    )
        .then(
      (response) async {
        developer.log(
          response.statusCode.toString(),
          name: "updateSpendingLimit_statusCode",
        );
        developer.log(
          response.body,
          name: "updateSpendingLimit_body",
        );
        if (response.statusCode == 200) {
          if (dailySpendHasLimit) {
            selectedChild?.dailySpendLimit =
                double.tryParse(dailySpendLimitController.text) ?? 0;
          } else {
            selectedChild?.dailySpendLimit = 0;
          }
          updateSpendingLimitUpdateBanner(
            BannerTypes.successBanner.type,
            appLocalizations,
          );
        } else {
          updateSpendingLimitUpdateBanner(
            BannerTypes.errorBanner.type,
            appLocalizations,
          );
        }
      },
    );
    isUpdatingSpendingLimit = false;
    notifyListeners();
  }

  Future<void> saveAllergies(AppLocalizations? appLocalizations) async {
    isUpdatingAllergies = true;
    notifyListeners();
    developer.log(
      "${urls.updateAllergiesPrefixUrl}${selectedChild?.id}${urls.updateAllergiesPostfixUrl}",
      name: "saveAllergies",
    );

    developer.log(
      cafeteriaId,
      name: "CafeteriaIdentifierSaveAllergies",
    );

    await http
        .post(
      Uri.parse(
        "${urls.updateAllergiesPrefixUrl}${selectedChild?.id}${urls.updateAllergiesPostfixUrl}",
      ),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId,
        "Content-Type": "application/json",
      },
      body: json.encode(
        {
          "allergies": selectedChild?.allergies ?? [],
          "student": selectedChild?.id ?? -1,
          "custom_allergy": otherAllergiesController.text,
        },
      ),
    )
        .then(
      (response) async {
        developer.log(
          response.statusCode.toString(),
          name: "saveAllergies_statusCode",
        );
        developer.log(
          response.body,
          name: "saveAllergies_body",
        );
        if (response.statusCode == 200) {
          selectedChild?.customAllergy = otherAllergiesController.text;
          updateAllergyUpdateBanner(
            BannerTypes.successBanner.type,
            appLocalizations,
          );
        } else {
          updateAllergyUpdateBanner(
            BannerTypes.errorBanner.type,
            appLocalizations,
          );
        }
      },
    );
    isUpdatingAllergies = false;
    notifyListeners();
  }

  Future<void> getTutorInfo(UserRole userType) async {
    if (userType == UserRole.tutor || userType == UserRole.teacher) {
      developer.log("Get tutor info start", name: "getTutorInfo");
      developer.log("${urls.getTutorInfoUrl}$tutorId/",
          name: "getTutorInfo_url");
      developer.log(cafeteriaId, name: "CafeteriaIdentifierGetTutorInfo");

      await http.get(
        Uri.parse("${urls.getTutorInfoUrl}$tutorId/"),
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
          "cafeteria": cafeteriaId
        },
      ).then(
        (response) {
          developer.log(response.statusCode.toString(),
              name: "getTutorInfo_statusCode");
          if (response.statusCode == 200) {
            developer.log(response.body.toString(), name: "getTutorInfo_body");
            Map<String, dynamic> responseMap =
                json.decode(utf8.decode(response.bodyBytes));
            tutor = Tutor.fromJson(responseMap);
            familyBalance = responseMap["family"]?["balance"] ?? "0.00";

            notifyListeners();
          } else {
            // Show error
          }
        },
      );
    }
  }

  Future<void> loadBalance() async {
    developer.log(urls.getFamilyBalanceUrl, name: "loadBalance");
    developer.log(cafeteriaId, name: "CafeteriaIdentifierloadBalance");
    await http.get(
      Uri.parse(urls.getFamilyBalanceUrl),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "loadBalance_statusCode",
        );
        developer.log(response.body.toString(), name: "loadBalance_body");
        if (response.statusCode == 200) {
          Map<String, dynamic> responseMap =
              json.decode(utf8.decode(response.bodyBytes))["results"][0];

          familyBalance = responseMap["balance"] ?? "0.00";
          notifyListeners();
        } else {
          developer.log(response.body.toString(), name: "loadBalance_body");
        }
      },
    );
  }

  Future<void> loadDebtorsChildren() async {
    developer.log("${urls.getFamilyDebtorsUrl}$familyId/balance/",
        name: "loadDebtorsChildren");
    developer.log(cafeteriaId, name: "CefteriaIdentifierLoadDebtorsChildren");
    await http.get(
      Uri.parse("${urls.getFamilyDebtorsUrl}$familyId/balance/"),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "loadDebtorsChildren_statusCode",
        );
        developer.log(response.body.toString(),
            name: "loadDebtorsChildren_body");
        if (response.statusCode == 200) {
          Map<String, dynamic> responseMap =
              json.decode(utf8.decode(response.bodyBytes));
          totalDebt = responseMap["all_debt"];
          debtors.clear();

          for (dynamic child in responseMap["students"]) {
            developer.log(child.toString(), name: "getDebtors_child");
            Child student = Child.fromJson(child);
            debtors.add(student);
          }

          notifyListeners();
          //familyBalance = responseMap["balance"] ?? "0.00";
        } else {
          // Show error
        }
      },
    );
  }

  Future<void> createOpenPayCustomer() async {
    developer.log(
      "create open pay customer start",
      name: "createOpenPayCustomer",
    );
    developer.log(
      urls.createOpenPayCustomerUrl,
      name: "createOpenPayCustomer_url",
    );
    developer.log(
      cafeteriaId,
      name: "CafeteriaIdentifierCreateOpenPayCustomer_url",
    );

    await http.get(
      Uri.parse(urls.createOpenPayCustomerUrl),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "createOpenPayCustomer_statusCode",
        );
        developer.log(
          response.body,
          name: "createOpenPayCustomer_Body",
        );
      },
    );
  }

  Future<void> getFamilyBalance() async {
    developer.log("Get FamilyBalance info start", name: "getFamilyBalance");
    developer.log(
      "${urls.getFamilyBalanceUrl}${tutor?.familyId}/",
      name: "getFamilyBalance_url",
    );
    developer.log(
      cafeteriaId,
      name: "CafeteriaIdentifierGetFamilyBalance_url",
    );
    await http.get(
      Uri.parse("${urls.getFamilyBalanceUrl}${tutor?.familyId}/"),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "getFamilyBalance_statusCode",
        );
        if (response.statusCode == 200) {
          developer.log(
            response.body.toString(),
            name: "getFamilyBalance_body",
          );
          Map<String, dynamic> responseMap = json.decode(
            utf8.decode(response.bodyBytes),
          );
          familyBalance = responseMap["balance"] ?? "0.00";

          notifyListeners();
        } else {
          // Show error
        }
      },
    );
  }

  Future<void> getForbiddenProductsByChild() async {
    developer.log(
      "Get tutor info start",
      name: "getForbiddenProductsByChild",
    );
    developer.log(
      "${urls.getProductRestrictionsUrl}?student=${selectedChild?.id}&restriction_type=prohibited",
      name: "getForbiddenProductsByChild_url",
    );
    developer.log(
      cafeteriaId,
      name: "CafeteriaIdentifierGetForbiddenProductsByChild_url",
    );
    await http.get(
      Uri.parse(
        "${urls.getProductRestrictionsUrl}?student=${selectedChild?.id}&restriction_type=prohibited",
      ),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "getForbiddenProductsByChild_statusCode",
        );
        if (response.statusCode == 200) {
          developer.log(
            response.body.toString(),
            name: "getForbiddenProductsByChild_body",
          );
          List<dynamic> forbiddenProducts = json.decode(
            utf8.decode(response.bodyBytes),
          )["results"];
          selectedChild?.forbiddenProducts = [];

          for (dynamic forbiddenProduct in forbiddenProducts) {
            selectedChild?.forbiddenProducts.add(forbiddenProduct["product"]);
          }

          notifyListeners();
        } else {
          // Show error
        }
      },
    );
  }

  Future<void> saveRestrictedProducts(
    String originPage,
    AppLocalizations? appLocalizations,
  ) async {
    if (originPage == "limit") {
      isUpdatingLimitedProducts = true;
    } else {
      isUpdatingForbiddenProducts = true;
    }
    notifyListeners();
    developer.log(
      "${urls.updateProductRestrictionsPrefixUrl}${selectedChild?.id}${urls.updateProductRestrictionsPostfixUrl}",
      name: "saveRestrictedProducts",
    );
    List<Map<String, dynamic>> restrictedProducts = [];

    for (int forbiddenProductId in selectedChild?.forbiddenProducts ?? []) {
      restrictedProducts.add({
        "id": forbiddenProductId,
        "quantity": 0,
        "frequency": "daily",
        "restriction_type": "prohibited",
      });
    }

    for (MapEntry<int, int> limitedProduct
        in selectedChild?.limitedProducts.entries ?? {}) {
      restrictedProducts.add({
        "id": limitedProduct.key,
        "quantity": limitedProduct.value,
        "frequency": limitedProductsFrecuency.toString(),
        "restriction_type": "limit",
      });
    }

    developer.log(
      restrictedProducts.toString(),
      name: "saveRestrictedProducts",
    );

    developer.log(
      cafeteriaId,
      name: "CafeteriaIdentifierSaveRestrictedProducts",
    );

    await http
        .post(
      Uri.parse(
        "${urls.updateProductRestrictionsPrefixUrl}${selectedChild?.id}${urls.updateProductRestrictionsPostfixUrl}",
      ),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
      body: json.encode(
        {
          "products": restrictedProducts,
        },
      ),
    )
        .then(
      (response) async {
        developer.log(
          response.statusCode.toString(),
          name: "saveRestrictedProducts_statusCode",
        );
        developer.log(
          response.body,
          name: "saveRestrictedProducts_body",
        );
        if (response.statusCode == 201) {
          selectedChild?.customAllergy = otherAllergiesController.text;
          if (originPage == "limit") {
            updateLimitedProductsUpdateBanner(
              BannerTypes.successBanner.type,
              appLocalizations,
            );
          } else {
            updateForbiddenProductsBanner(
              BannerTypes.successBanner.type,
              appLocalizations,
            );
          }
        } else {
          if (originPage == "limit") {
            updateLimitedProductsUpdateBanner(
              BannerTypes.errorBanner.type,
              appLocalizations,
            );
          } else {
            updateForbiddenProductsBanner(
              BannerTypes.errorBanner.type,
              appLocalizations,
            );
          }
        }
      },
    );
    if (originPage == "limit") {
      isUpdatingLimitedProducts = false;
    } else {
      isUpdatingForbiddenProducts = false;
    }
    notifyListeners();
  }

  Future<void> getLimitedProductsByChild() async {
    fetchingData = true;
    developer.log(
      "Get tutor info start",
      name: "getLimitedProductsByChild",
    );
    developer.log(
      "${urls.getProductRestrictionsUrl}?student=${selectedChild?.id}&restriction_type=limit",
      name: "getLimitedProductsByChild_url",
    );
    developer.log(
      cafeteriaId,
      name: "CafeteriaIdentifierGetLimitedProductsByChild_url",
    );
    await http.get(
      Uri.parse(
        "${urls.getProductRestrictionsUrl}?student=${selectedChild?.id}&restriction_type=limit",
      ),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "getLimitedProductsByChild_statusCode",
        );
        if (response.statusCode == 200) {
          developer.log(
            response.body.toString(),
            name: "getLimitedProductsByChild_body",
          );
          List<dynamic> limitedProducts = json.decode(
            utf8.decode(response.bodyBytes),
          )["results"];
          selectedChild?.limitedProducts = {};

          for (dynamic limitedProduct in limitedProducts) {
            selectedChild?.limitedProducts.addAll(
              {
                limitedProduct["product"]: limitedProduct["quantity"],
              },
            );
          }
        } else {
          // Show error
        }

        fetchingData = false;
        notifyListeners();
      },
    );
  }

  void selectChild(Child? child) async {
    selectedChild = child;
    dailySpendHasLimit = child?.dailySpendLimit != 0;
    dailySpendLimitController.text =
        child?.dailySpendLimit.toStringAsFixed(2) ?? "0.00";
    otherAllergiesController.text = child?.customAllergy ?? "";
    await getLimitedProductsByChild();
    await getForbiddenProductsByChild();

    notifyListeners();
  }

  void selectedChildHasDailySpendLimitChange(bool value) {
    dailySpendHasLimit = !value;
    notifyListeners();
  }

  void changeAllergy(int allergyId) {
    if (selectedChild?.allergies.contains(allergyId) ?? false) {
      selectedChild?.allergies.remove(allergyId);
    } else {
      selectedChild?.allergies.add(allergyId);
    }
    developer.log(selectedChild?.allergies.toString() ?? "Error",
        name: "changeAllergy");
    notifyListeners();
  }

  void changeForbiddenProduct(int productId) {
    if (selectedChild?.forbiddenProducts.contains(productId) ?? false) {
      selectedChild?.forbiddenProducts.remove(productId);
    } else {
      selectedChild?.forbiddenProducts.add(productId);
    }
    developer.log(selectedChild?.forbiddenProducts.toString() ?? "Error",
        name: "changeForbiddenProduct");
    notifyListeners();
  }

  void changeDailyLimit(AppLocalizations? appLocalizations) {
    if (dailySpendHasLimit) {
      selectedChild?.dailySpendLimit =
          double.tryParse(dailySpendLimitController.text) ?? 0;
    } else {
      selectedChild?.dailySpendLimit = 0;
    }
    notifyListeners();
  }

  void changeLimitedProduct(int productId, String value) {
    int limit = int.tryParse(value) ?? -1;
    if (limit == -1) {
      selectedChild?.limitedProducts.remove(productId);
    } else if (selectedChild?.limitedProducts.containsKey(productId) ?? false) {
      selectedChild?.limitedProducts.update(productId, (value) => limit);
    } else {
      selectedChild?.limitedProducts.addAll({
        productId: limit,
      });
    }
    notifyListeners();
  }

  Future<String> updateTutor(
      String firstName,
      String lastName,
      String phoneNumber,
      String base64Image,
      String family,
      String birthDate) async {
    isLoading = true;
    notifyListeners();
    String bannerType = "";
    // developer.log(base64Image, name: "updateTutor_base64Image");
    if (firstName.isEmpty || lastName.isEmpty || phoneNumber.isEmpty) {
      isLoading = false;
      return BannerTypes.warningBanner.type;
    }
    developer.log("Update tutor info start", name: "updateTutor");
    developer.log("${urls.updateTutorUrl}$tutorId/", name: "updateTutor_url");

    Map<String, dynamic> data = {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phoneNumber,
      "family": int.parse(family),
      "birth_date": birthDate
    };
    if (base64Image.isNotEmpty) {
      data.addAll(
        {
          "picture": "data:image/jpg;base64,$base64Image",
        },
      );
    }
    developer.log(
      data.toString(),
      name: "updateTutor_data",
    );
    developer.log(
      cafeteriaId,
      name: "CafeteriaIdentifierUpdateTutor_data",
    );

    await http
        .patch(
      Uri.parse("${urls.updateTutorUrl}$tutorId/"),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
        "cafeteria": cafeteriaId
      },
      body: json.encode(
        data,
      ),
    )
        .then(
      (response) async {
        developer.log(response.statusCode.toString(),
            name: "updateTutor_statusCode");
        developer.log(response.body.toString(), name: "updateTutor_body");
        if (response.statusCode == 200) {
          isLoading = false;
          await getTutorInfo(userType);
          notifyListeners();
          bannerType = BannerTypes.successBanner.type;
        } else {
          // Show error
          bannerType = BannerTypes.errorBanner.type;
        }
      },
    ).onError(
      (error, stackTrace) {
        isLoading = false;
        notifyListeners();
        bannerType = BannerTypes.infoBanner.type;
      },
    );
    return bannerType;
  }

  Future<String> updateStudent(int studentId, String firstName, String lastName,
      String base64Image) async {
    isLoading = true;
    notifyListeners();
    String bannerType = "";
    // developer.log(base64Image, name: "updateTutor_base64Image");
    if (firstName.isEmpty || lastName.isEmpty) {
      isLoading = false;
      return BannerTypes.warningBanner.type;
    }
    developer.log("Update student info start", name: "updateStudent");
    developer.log("${urls.updateStudentInfo}$studentId/",
        name: "updateTutor_url");

    Map<String, dynamic> data = {
      "first_name": firstName,
      "last_name": lastName
    };
    if (base64Image.isNotEmpty) {
      data.addAll(
        {
          "picture": "data:image/jpg;base64,$base64Image",
        },
      );
    }
    developer.log(
      data.toString(),
      name: "updateStudent_data",
    );
    developer.log(
      cafeteriaId,
      name: "CafeteriaIdentifierUpdateStudent_data",
    );

    await http
        .patch(
      Uri.parse("${urls.updateStudentInfo}$studentId/"),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
        "cafeteria": cafeteriaId
      },
      body: json.encode(
        data,
      ),
    )
        .then(
      (response) async {
        developer.log(response.statusCode.toString(),
            name: "updateStudent_statusCode");
        developer.log(response.body.toString(), name: "updateStudent_body");
        if (response.statusCode == 200) {
          isLoading = false;
          await getStudentInfo(studentId);
          notifyListeners();
          bannerType = BannerTypes.successBanner.type;
        } else {
          // Show error
          bannerType = BannerTypes.errorBanner.type;
        }
      },
    ).onError(
      (error, stackTrace) {
        isLoading = false;
        notifyListeners();
        bannerType = BannerTypes.infoBanner.type;
      },
    );
    return bannerType;
  }

  Future<void> getStudentInfo(int studentId) async {
    developer.log("Get student info start", name: "getStudentInfo");
    developer.log("${urls.getStudentInfoUrl}$studentId/",
        name: "getStudentInfo_url");
    developer.log(cafeteriaId, name: "CafeteriaIdentifierGetStudentInfo_url");
    await http.get(
      Uri.parse("${urls.getStudentInfoUrl}$studentId/"),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(response.statusCode.toString(),
            name: "getStudentInfo_statusCode");
        if (response.statusCode == 200) {
          developer.log(response.body.toString(), name: "getStudentInfo_body");
          Map<String, dynamic> responseMap =
              json.decode(utf8.decode(response.bodyBytes));
          //selectedChild = Child.fromJson(responseMap);

          var item = children.firstWhere(
              (element) => element.id == studentId); // getting the item
          var index = children.indexOf(item); // Item index
          children[index] = selectedChild!;
          familyBalance = responseMap["family"]?["balance"] ?? "0.00";

          bool membership = responseMap["membership"] ?? true;
          children[index].membership = membership;

          notifyListeners();
        } else {
          // Show error
        }
      },
    );
  }

  Future<bool> isSessionValid(StorageProvider storageProvider,
      LanguageProvider languageProvider) async {
    developer.log("Start", name: "isSessionValid");

    languageProvider.loadLocale(storageProvider);
    await getCafeteria(storageProvider);
    await updateLoginInfo(storageProvider);

    if (accessToken != "" && !JwtDecoder.isExpired(accessToken)) {
      developer.log(accessToken, name: "isSessionValid_accessTokenValid");
      await loadDebtorsChildren();
      await loadCafeteriaSetting();
      await loadBalance();
      return true;
    }
    developer.log(accessToken, name: "isSessionValid_accessTokenValid");
    if (refreshToken == "") {
      developer.log(refreshToken, name: "isSessionValid_accessTokenValid");
      return false;
    }
    developer.log("", name: "isSessionValid_accessTokenValid");

    String refreshResponse = await refreshAccessToken(storageProvider);

    developer.log(refreshResponse,
        name: "isSessionValid_refreshAccessTokenResponse");

    return refreshResponse.isNotEmpty;

    // await Future.delayed(
    //   const Duration(
    //     seconds: 5,
    //   ),
    // );
    // return false;
  }

  Future<void> checkAppVersion() async {
    StorageProvider storageProvider = StorageProvider();
    appIsUpdated = false;
    String accessToken = await storageProvider.readValue("accessToken");

    await http.get(
      Uri.parse(urls.getAppVersion),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then((response) async {
      developer.log(response.statusCode.toString(),
          name: "checkAppVersion_statusCode");
      if (response.statusCode == 200) {
        developer.log(response.body.toString(), name: "checkAppVersion_body");
        Map<String, dynamic> responseMap =
            json.decode(utf8.decode(response.bodyBytes));
        AppVersion appVersion = AppVersion.fromJson(responseMap["results"]);
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String buildNumber = packageInfo.buildNumber;

        if (Platform.isAndroid) {
          if (appVersion.androidVersion == buildNumber) {
            appIsUpdated = true;
          } else {
            appIsUpdated = false;
          }
        } else if (Platform.isIOS) {
          if (appVersion.iosVersion == buildNumber) {
            appIsUpdated = true;
          } else {
            appIsUpdated = false;
          }
        }

        notifyListeners();
      } else {
        appIsUpdated = false;
      }
    });
  }

  void saveTutorOpenPayId(String openPayId) {
    tutor?.openPayId = openPayId;
    notifyListeners();
  }

  void saveStudentOpenPayId(String openPayId) {
    selectedChild?.openpayId = openPayId;
    notifyListeners();
  }

  Future<void> logout(StorageProvider storageProvider, HomeProvider homeProvider) async {
    resetFields();
    homeProvider.resetCafeterias();
    await storageProvider.deleteAll();
  }

  NumberFormat numberFormat = NumberFormat("###,##0.00");

  Future<void> getCurrentBalance() async {
    StorageProvider storageProvider = StorageProvider();
    String tutorId = await storageProvider.readValue("tutorId");
    String accessToken = await storageProvider.readValue("accessToken");
    //String refreshToken = await storageProvider.readValue("refreshToken");

    developer.log(cafeteriaId, name: "CafeteriaIdentifierGetBalance");

    await http.get(
      Uri.parse("${urls.getTutorInfoUrl}$tutorId/"),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(response.statusCode.toString(),
            name: "getCurrentBalance_statusCode");
        if (response.statusCode == 200) {
          developer.log(response.body.toString(),
              name: "getCurrentBalance_body");
          Map<String, dynamic> responseMap =
              json.decode(utf8.decode(response.bodyBytes));
          String balanceString = responseMap["family"]?["balance"] ?? "0.00";
          //balance = double.parse(balanceString);
          familyBalance = balanceString;
          notifyListeners();
        } else {
          // Show error
        }
      },
    );
  }

  /*
  Future<void> getInitialAsyncData( SourceValues source, UserRole userType) async{

    await checkAppVersion();
    await getChildren();
    await loadDebtorsChildren();
    await loadCafeteriaSetting();
    await loadBalance();
    if(userType==UserRole.tutor){
      await getTutorInfo();
    }

    if(source==SourceValues.fromLogin){
      await createOpenPayCustomer();
    }
  }

  Future<void> initialCallsAfterLogin(
      SourceValues source,
      MainProvider mainProvider,
      HomeProvider homeProvider,
      CardsInfoProvider cardsInfoProvider,
      AllergyProvider allergyProvider,
      HistoryProvider historyProvider,
      LoginProvider loginProvider,
      ProductsProvider productsProvider
      ) async{
    homeProvider.initialLoad(
        mainProvider.accessToken,
        mainProvider.cafeteriaId,
        int.parse(mainProvider.studentId),
        mainProvider.userType,
        mainProvider.userType==UserRole.tutor ? false : mainProvider.selectedChild?.isIndependent ?? false
    );

    cardsInfoProvider.getOpenPayCredentials(
      mainProvider.accessToken,
    );

    cardsInfoProvider.getTutorOpenPayAccount(
      mainProvider.accessToken,
      mainProvider.saveStudentOpenPayId,
    );

    allergyProvider
        .getAllergies(mainProvider.accessToken);
    productsProvider
        .initialLoad(mainProvider.accessToken);

    historyProvider.initialLoad(mainProvider.accessToken, int.parse(mainProvider.studentId), mainProvider.userType );

    if(source==SourceValues.fromLogin){
      loginProvider.resetLoadingButton();
    }

  }*/

  void showSales() {
    hideSalesForIndependentStudent = !hideSalesForIndependentStudent;
    notifyListeners();
  }

  void addItem(int studentId) {
    if (membershipCart.containsKey(studentId)) {
      if ((membershipCart[studentId] ?? 0) < 12) {
        membershipCart.update(
            studentId, (value) => (membershipCart[studentId] ?? 0) + 1);
        membershipTotalPrice += YappyValues.membershipPrice;
      }
    } else {
      membershipCart.addAll(
        {
          studentId: 1,
        },
      );
      membershipTotalPrice += YappyValues.membershipPrice;
    }

    notifyListeners();
  }

  void removeItem(int minAmount, int studentId) {
    if (membershipCart.containsKey(studentId)) {
      membershipTotalPrice -= YappyValues.membershipPrice;
      membershipCart.update(
          studentId, (value) => (membershipCart[studentId] ?? 0) - 1);
      membershipCart.removeWhere((key, value) => value <= 0);
    }

    notifyListeners();
  }
}
