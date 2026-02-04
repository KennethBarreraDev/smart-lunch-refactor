import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_lunch/models/history_model.dart';
import 'package:smart_lunch/models/recharge_history_model.dart';
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/utils/urls.dart' as urls;

class HistoryProvider with ChangeNotifier {
  List<ProductHistory> productHistory = [];
  List<RechargeHistory> rechargeHistory = [];

  void initialLoad(String accessToken, String cafeteriaId, int studentId, UserRole userType) {
    getProductHistory(accessToken, cafeteriaId, studentId, userType);
    getRechargeHistory(accessToken, cafeteriaId, studentId, userType);
  }

  Future<void> getProductHistory(String accessToken, String cafeteriaId, int studentId, UserRole userType) async {
    developer.log(
      "${urls.getProductHistoryUrl}?page_size=100",
      name: "getProductHistory",
    );

  developer.log(
      cafeteriaId,
      name: "CafeteriaIdentifierGetProductHistory",
    );

    await http.get(
      Uri.parse(
        "${urls.getProductHistoryUrl}?page_size=100",
      ),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
         "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "getProductHistory_statusCode",
        );
        developer.log(response.body, name: "getProductHistory_body");
        productHistory = [];
        if (response.statusCode == 200) {
          List<dynamic> body =
              json.decode(utf8.decode(response.bodyBytes))["results"];

          if(userType==UserRole.tutor || userType==UserRole.teacher ) {
            for (dynamic historyElement in body) {
              productHistory.add(ProductHistory.fromJson(historyElement));
            }
          }

        else if(userType==UserRole.student){
          for (dynamic historyElement in body) {
            if(historyElement["user_buyer"]["instance"]["id"].toString()==studentId.toString()){
              productHistory.add(ProductHistory.fromJson(historyElement));
            }
          }
        }
        }
        notifyListeners();
      },
    );
  }

  Future<void> getRechargeHistory(String accessToken, String cafeteriaId, int studentId, UserRole userType) async {
    developer.log(
      "${urls.getRechargeHistoryUrl}?page_size=100",
      name: "getRechargeHistory",
    );
      developer.log(
      cafeteriaId,
      name: "CafeteriaIdenttifierGetRechargeHistory",
    );

    await http.get(
      Uri.parse(
        "${urls.getRechargeHistoryUrl}?page_size=100",
      ),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
         "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "getRechargeHistory_statusCode",
        );
        developer.log(response.body, name: "getRechargeHistory_body");
        rechargeHistory = [];
        if (response.statusCode == 200) {
          List<dynamic> body =
              json.decode(utf8.decode(response.bodyBytes))["results"];
          if(userType==UserRole.tutor || userType==UserRole.teacher ) {
            for (dynamic historyElement in body) {
              rechargeHistory.add(RechargeHistory.fromJson(historyElement));
            }
          }

          else if(userType==UserRole.student){
            for (dynamic historyElement in body) {
              if(historyElement["user_recharger"]["instance"]["id"].toString()==studentId.toString()){
                rechargeHistory.add(RechargeHistory.fromJson(historyElement));
              }
            }
          }
        }
        notifyListeners();
      },
    );
  }
}
