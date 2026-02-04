import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_lunch/models/allergy_model.dart';
import 'package:smart_lunch/utils/urls.dart' as urls;

class AllergyProvider with ChangeNotifier {
  List<Allergy> allergies = [];

  Future<void> getAllergies(String accessToken, String cafeteriaId) async {
    developer.log(urls.getAllergiesUrl, name: "getAllergies");
    developer.log(cafeteriaId, name: "CafeteriaIdentifiergetCafeteriaAllergies");

    await http.get(
      Uri.parse(urls.getAllergiesUrl),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "getAllergies_statusCode",
        );
        developer.log(
          response.body,
          name: "getAllergies_body",
        );
        allergies = [];
        if (response.statusCode == 200) {
          List<dynamic> body =
              json.decode(utf8.decode(response.bodyBytes))["results"];

          for (dynamic allergy in body) {
            allergies.add(Allergy.fromJson(allergy));
          }
        }
        notifyListeners();
      },
    );
  }
}
