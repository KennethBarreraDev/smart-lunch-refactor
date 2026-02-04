import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/models/child_model.dart';
import 'package:smart_lunch/models/presale_model.dart';
import 'package:smart_lunch/utils/banner_utils.dart';
import 'package:smart_lunch/utils/urls.dart' as urls;
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class MembershipProvider with ChangeNotifier {
  bool isBuyingMembership = false;
  bool paymentError = false;
  String yappyUrl = "";
  String rechargeFolio = "1234567890123";
  String croemFolio = "";
  String croemRechargeStatus = "";

  TextEditingController cvvController = TextEditingController();
  String membershipPaymentStatus = "";
  String membershipPaymentBannerMessage = "";

  String homeBannerStatus = "";
  String homeBannerMessage = "";

  void hideBanner() {
    membershipPaymentStatus = "";
    membershipPaymentBannerMessage = "";
    notifyListeners();
  }

  void hideHomeBanner() {
    homeBannerStatus = "";
    homeBannerMessage = "";
    notifyListeners();
  }

  void updateBannerType(
    String type,
    AppLocalizations? appLocalizations,
  ) {
    membershipPaymentStatus = type;
    if (type == BannerTypes.successBanner.type) {
      membershipPaymentBannerMessage = appLocalizations!.successful_recharge;
    } else {
      membershipPaymentBannerMessage = appLocalizations!.try_again_later;
    }
  }

  void updateHomeBannerType(
    String type,
    AppLocalizations? appLocalizations,
  ) {
    homeBannerStatus = type;
    if (type == BannerTypes.successBanner.type) {
      homeBannerMessage = appLocalizations!.succes_membership_payment;
    } else {
      homeBannerMessage = appLocalizations!.error_membership_payment;
    }
    notifyListeners();
  }

  Future<int> payMembership(
    String accessToken,
    Map<int, int> membershipConcepts,
    String paymentMethod,
    String cardId,
    String cardCVV,
    String totalAmount,
    String cafeteriaId,
    AppLocalizations? appLocalizations,
    String value,
  ) async {
    isBuyingMembership = true;
    notifyListeners();

    developer.log((urls.payMembership), name: "payMembership");
    paymentError = false;

    List<Map<String, dynamic>> memberships =
        membershipConcepts.entries.map((entry) {
      return {
        "student": entry.key,
        "months": entry.value,
      };
    }).toList();

    Map<String, dynamic> body = {};

    if ((paymentMethod == "CROEM")) {
      body = {
        "students": memberships,
        "payment_method": paymentMethod,
        "croem": {"card_id": cardId, "cvv": cardCVV}
      };
    } else {
      body = {
        "students": memberships,
        "payment_method": "YAPPY",
      };
    }
    developer.log("${body.toString()} ${cafeteriaId} ${membershipConcepts}",
        name: "payMembershipBody");

    developer.log(cafeteriaId, name: "CafeteriaIdentifierPayMembershipBody");

    int topUpBalanceResult = 0;

    notifyListeners();

    await http
        .post(
      Uri.parse(urls.payMembership),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId,
        "Content-Type": "application/json",
      },
      body: json.encode(body),
    )
        .then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "payMembership_statusCode",
        );
        developer.log(
          response.body.toString(),
          name: "payMembership_body",
        );
        if (response.statusCode == 200) {
          if ((paymentMethod == "CROEM")) {
            croemRechargeStatus = "APPROVED";
            notifyListeners();
          } else {
            Map<String, dynamic> responseMap =
                json.decode(utf8.decode(response.bodyBytes));
            if (responseMap.containsKey("url")) {
              yappyUrl = responseMap["url"];
              topUpBalanceResult = 1;
            } else {
              topUpBalanceResult = -1;
            }
          }
          notifyListeners();
        } else {
          updateBannerType(
            BannerTypes.errorBanner.type,
            appLocalizations,
          );
          topUpBalanceResult = -1;
          notifyListeners();
        }
      },
    );
    isBuyingMembership = false;
    if (topUpBalanceResult == 0) {
      //rechargeController.clear();
    }
    notifyListeners();
    developer.log(
      (topUpBalanceResult != -1).toString(),
      name: "isRechargeSuccessful",
    );
    return topUpBalanceResult;
  }

  void launchURL(BuildContext context, String url) async {
    final theme = Theme.of(context);
    try {
      await launchUrl(
        Uri.parse(url),
        customTabsOptions: CustomTabsOptions(
          colorSchemes: CustomTabsColorSchemes.defaults(
            toolbarColor: theme.colorScheme.surface,
            navigationBarColor: theme.colorScheme.surface,
          ),
          shareState: CustomTabsShareState.on,
          urlBarHidingEnabled: true,
          showTitle: true,
        ),
        safariVCOptions: SafariViewControllerOptions(
          preferredBarTintColor: theme.colorScheme.surface,
          preferredControlTintColor: theme.colorScheme.onSurface,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}
