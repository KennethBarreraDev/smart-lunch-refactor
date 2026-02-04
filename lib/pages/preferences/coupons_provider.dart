import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_lunch/models/coupon_model.dart';
import 'package:smart_lunch/utils/urls.dart' as urls;
import 'package:url_launcher/url_launcher.dart';

class CouponsProvider with ChangeNotifier {
  List<Coupon> coupons = [];
  Coupon? selectedCoupon;

  Future<void> getCoupons(String accessToken, String cafeteriaId, {String state = ""}) async {
    notifyListeners();
    developer.log("${urls.getCouponsUrl}?state=$state", name: "getCoupons");
     developer.log(cafeteriaId, name: "CafeteriaIdentifierGetCoupons");
    // TODO filtrar por estado del cupón
    await http.get(
      Uri.parse("${urls.getCouponsUrl}?state=$state"),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
         "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(response.statusCode.toString(),
            name: "getCoupons_statusCode");
        developer.log(response.body.toString(), name: "getCoupons_body");
        coupons = [];
        if (response.statusCode == 200) {
          List<dynamic> body =
              json.decode(utf8.decode(response.bodyBytes))["results"];
          for (dynamic message in body) {
            coupons.add(Coupon.fromJson(message));
            developer.log(message.toString(), name: "getCoupons_body");
          }
          notifyListeners();
        } else {
          // Show error
        }
      },
    );
  }

  void selectCoupon(Coupon coupon) {
    selectedCoupon = coupon;
    notifyListeners();
  }

  Future<void> openMap(String mapUrl) async {
    await launchUrl(
      Uri.parse(
        mapUrl,
      ),
      mode: LaunchMode.externalNonBrowserApplication,
    ).catchError(
      (error, stackTrace) {
        developer.log("error", name: "openMap");
        return false;
      },
    );
  }

  Future<void> openCompanyUrl(String companyUrl) async {
    await launchUrl(
      Uri.parse(
        companyUrl,
      ),
      mode: LaunchMode.inAppWebView,
    ).catchError(
      (error, stackTrace) {
        developer.log("error", name: "openMap");
        return false;
      },
    );
  }
}
