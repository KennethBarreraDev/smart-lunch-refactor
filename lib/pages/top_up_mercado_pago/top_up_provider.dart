import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_lunch/utils/urls.dart' as urls;

class TopUpProvider with ChangeNotifier {
  int buttonId = 0;
  bool setAmountFromInput = false;
  bool insertedAmountError = false;

  bool loadingRecharge = false;
  TextEditingController rechargeTotalInput = TextEditingController();
  //List<double> defaultRechargeValues = [100, 200, 300, 400, 500, 600];

  double rechargeTotal = 5;
  void selectButton(int selectedButton) {
    buttonId = selectedButton;
    notifyListeners();
  }

  void setRechargeTotal(double total) {
    print("Recbiendo $total");
    rechargeTotal = total;
    notifyListeners();
  }

  /*
  List<double> getValuesToRender(double minuminRechargeAmount){
    return defaultRechargeValues.where((element) => element>=minuminRechargeAmount).toList();

  }*/

  void setAmountFromInputValue(bool value) {
    setAmountFromInput = value;
    notifyListeners();
  }

  void setInsertedAmountError(bool value) {
    insertedAmountError = value;
    notifyListeners();
  }

  Future<String> recharge(String accessToken, String cafeteriaId,
      String tutorId, double amount) async {
    loadingRecharge = true;
    notifyListeners();
    String mercadoPagoReference = "";
    String rechargeDate = DateTime.now().toUtc().toString();
    developer.log("recharge", name: "topUpPage");
    developer.log("rechargeDate $rechargeDate", name: "rechargeDate");
    developer.log("Token $accessToken", name: "receivedAccessToken");
    developer.log("TutorId $tutorId", name: "receivedId");
    developer.log("Amount ${amount.toString()}", name: "receivedAmount");
    developer.log(cafeteriaId, name: "CafeteriaIdentifierRecharge");

    Map<String, dynamic> data = {
      "recharge_date:": rechargeDate,
      "amount": rechargeTotal,
      "user_recharger": tutorId,
      "payment_method": "MERCADO_PAGO",
    };
    await http
        .post(
      Uri.parse(urls.rechargeUrl),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId,
        "Device-Type": "Mobile"
      },
      body: json.encode(data),
    )
        .then(
      (response) {
        if (response.statusCode == 201) {
          Map<String, dynamic> responseMap = json.decode(response.body);
          mercadoPagoReference =
              responseMap['mercadopago_preference']["preference_url"] ?? "";

          developer.log("MercadoPagoUrl: $mercadoPagoReference",
              name: "MercadoPagoData");

          developer.log(responseMap.toString(), name: "recharge_body");
          notifyListeners();
          return mercadoPagoReference;
        } else {
          mercadoPagoReference = "";
          notifyListeners();
        }
        loadingRecharge = false;
        notifyListeners();
      },
    ).catchError((error){
      loadingRecharge = false;
      notifyListeners();
    });
    return mercadoPagoReference;
  }
}
