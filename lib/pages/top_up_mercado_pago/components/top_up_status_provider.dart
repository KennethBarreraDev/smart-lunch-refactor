import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_lunch/utils/urls.dart' as urls;

class TopUpStatusProvider with ChangeNotifier {
  TopUpStatusProvider(
      {required this.paymentId,
      required this.merchantOrderId,
      required this.externalReference,
      required this.rechargeAmount,
      required this.folio,
      required this.paymentMethod,
      required this.yappyFolio,
      this.loadingInfo = false});
  String probe = "";
  String paymentId;
  String merchantOrderId;
  String externalReference;
  String folio;
  String rechargeAmount;
  String paymentMethod;
  String yappyFolio;

  bool loadingInfo;

  String get data => probe;

  Future<void> fetchData(
  String paymentId,
  String merchantOrderId,
  String externalReference,
  String accessToken,
  String cafeteriaId,
) async {
  try {
    developer.log("getRechargeInfo start", name: "getRechargeInfo");
    developer.log(cafeteriaId, name: "CafeteriaIdentifierGetRechargeInfo");

    final url =
        "${urls.rechargeDataUrl}?payment_id=$paymentId&merchant_order_id=$merchantOrderId&external_reference=$externalReference";

    developer.log(url, name: "getRechargeInfo");

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId,
      },
    );

    developer.log(
      response.statusCode.toString(),
      name: "getRechargeInfo_statusCode",
    );
  print("Response ${response.body.toString()}");
    if (response.statusCode == 200) {
      try {
        final responseMap = json.decode(utf8.decode(response.bodyBytes));

        var folioInfo = responseMap['folio'].toString().split('-');
        folio =
            '${folioInfo[folioInfo.length - 2]}-${folioInfo[folioInfo.length - 1]}';
        rechargeAmount = responseMap['amount'];
        paymentMethod = responseMap['payment_method'];
        this.paymentId =
            responseMap['mercadopago_preference']['payment_id'];

        developer.log(response.body.toString(), name: "getRechargeInfo_body");

      
        notifyListeners();
      } catch (parseError, stack) {
        developer.log(
          "Error parsing JSON: $parseError",
          name: "getRechargeInfo",
          error: parseError,
          stackTrace: stack,
        );
        print("JSON Parse Error: $parseError");
      }
    } else {
      developer.log(
        "Request failed with body: ${response.body}",
        name: "getRechargeInfo_body",
      );
      print("Request failed with status: ${response.statusCode}");
    }
  } catch (e, stack) {
    developer.log(
      "Error en fetchData: $e",
      name: "getRechargeInfo",
      error: e,
      stackTrace: stack,
    );
    print("Error is $e");
  }
}


  Future<void> yappyFetchInfo(String paymentId, String accessToken,
      String cafeteriaId, String endpoint) async {
    loadingInfo = true;
    notifyListeners();
    developer.log(
      "getRechargeYappyInfo start",
      name: "getRechargeYappyInfo",
    );
    developer.log(
      "${urls.baseUrl}/smartlunch/$endpoint/$paymentId",
      name: "getRechargeYappyInfo",
    );
    developer.log(
      cafeteriaId,
      name: "CafeteriaIdentifierGetRechargeYappyInfo",
    );
    await http.get(
      Uri.parse(
        "${urls.baseUrl}/smartlunch/$endpoint/$paymentId",
      ),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "getRechargeYappyInfo_statusCode",
        );
        if (response.statusCode == 200) {
          developer.log(
            response.body.toString(),
            name: "getRechargeYappyInfo_body",
          );

          Map<String, dynamic> responseMap =
              json.decode(utf8.decode(response.bodyBytes));
          yappyFolio = responseMap['folio'].toString();
          rechargeAmount = responseMap['amount'].toString();
          paymentMethod = "Yappy";

          loadingInfo = false;
          notifyListeners();
        } else {
          loadingInfo = false;
          developer.log(
            response.body.toString(),
            name: "getRechargeInfo_body",
          );
        }
      },
    );
  }
}
