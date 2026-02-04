import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/models/cafeteria_model.dart';
import 'package:smart_lunch/models/presale_model.dart';
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/utils/save_user_info.dart';
import 'package:smart_lunch/utils/urls.dart' as urls;
import 'package:webview_flutter/webview_flutter.dart';

class HomeProvider with ChangeNotifier {
  List<Presale> presales = [];

  List<Presale> dailySales = [];

  List<Cafeteria?> userCafeterias = [];

  Cafeteria? cafeteria;

  int selectedCafeteriaId = 0;

  bool changingCafeteria = false;

  WebViewController filePreviewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  Future<void> changeCurrentCafeteria(StorageProvider storageProvider,
      MainProvider mainProvider, int cafeteriaID) async {
    cafeteria = userCafeterias
        .firstWhere((element) => (element?.id ?? 0) == cafeteriaID);
    selectedCafeteriaId = cafeteria?.id ?? 0;
    mainProvider.setCafeteriaID(selectedCafeteriaId);
    await saveUserCafeteria(storageProvider, cafeteriaID.toString());

    notifyListeners();
  }

  void resetCafeterias() {
    userCafeterias = [];
    cafeteria = null;
    notifyListeners();
  }

  void changeCafeteriaStatus(bool value) {
    changingCafeteria = value;
    notifyListeners();
  }

  void setCafeteria(Cafeteria? cafeteria) {
    selectedCafeteriaId = cafeteria?.id ?? 0;
    notifyListeners();
  }

  Future<void> loadCafeteria(
    String accessToken,
    MainProvider mainProvider,
    StorageProvider storageProvider,
  ) async {
    developer.log(
      "${urls.getCafeteriaInfoUrl}/",
      name: "loadSchool",
    );

    await http.get(
      Uri.parse("${urls.getCafeteriaInfoUrl}/"),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
      },
    ).then(
      (response) async {
        developer.log(
          response.statusCode.toString(),
          name: "loadSchool_statusCode",
        );
        developer.log(
          json.decode(response.body).toString(),
          name: "loadSchool_body",
        );

        if (response.statusCode == 200) {
          List<dynamic> cafeterias = json.decode(
            utf8.decode(response.bodyBytes),
          )["results"];

          for (dynamic cafeteria in cafeterias) {
            userCafeterias.add(Cafeteria.fromJson(cafeteria));
          }

          String cacheCafeteria =
              await mainProvider.getCafeteria(storageProvider);

          if (cacheCafeteria.isNotEmpty &&
              userCafeterias.any(
                  (element) => (element?.id) == int.parse(cacheCafeteria))) {
            cafeteria = userCafeterias.firstWhere(
                (element) => element?.id == int.parse(cacheCafeteria));
            selectedCafeteriaId = cafeteria?.id ?? 0;
          } else {
            print("User cafeterias is ${userCafeterias.length}");
            cafeteria = userCafeterias[0];
            selectedCafeteriaId = cafeteria?.id ?? 0;
          }

          await saveUserCafeteria(
              storageProvider, cafeteria?.id.toString() ?? "");
          mainProvider.getCafeteria(storageProvider);

          if (cafeteria?.menu.isNotEmpty ?? false) {
            filePreviewController.loadRequest(
              Uri.parse(cafeteria?.menu ?? ""),
            );
          }
          notifyListeners();
        } else {
          // Show error
        }
      },
    );
  }

  Future<void> loadSales(String accessToken, String cafeteriaId, int studentId,
      UserRole userType, bool isAutosuficient) async {
    String saleType = "MO";

    if (isAutosuficient || userType == UserRole.teacher) {
      saleType = "IM";
    } else {
      saleType = "MO";
    }
    String today = DateFormat("yyyy-MM-dd").format(DateTime.now().toUtc());
    developer.log(today, name: "saleDate");
    developer.log(
      "${urls.getProductHistoryUrl}?page_size=100&created_at__gte=$today",
      name: "loadSales",
    );
    developer.log(
      cafeteriaId,
      name: "CafeteriaIdentifierLoadSales",
    );

    await http.get(
      Uri.parse(
        "${urls.getProductHistoryUrl}?page_size=100&created_at__gte=$today",
      ),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "loadSales_statusCode",
        );
        developer.log(response.body, name: "loadSales_body");
        dailySales = [];
        if (response.statusCode == 200) {
          List<dynamic> body =
              json.decode(utf8.decode(response.bodyBytes))["results"];

          if ((userType == UserRole.tutor || userType == UserRole.teacher)) {
            for (dynamic saleElement in body) {
              //print(Presale.fromJson(saleElement));
              if (saleElement["sale_type"] != "PS") {
                dailySales.add(Presale.fromJson(saleElement));
              }
            }
          } else if (userType == UserRole.student) {
            for (dynamic saleElement in body) {
              if (saleElement["user_buyer"]["instance"]["id"].toString() ==
                      studentId.toString() &&
                  saleElement["sale_type"] != "PS") {
                dailySales.add(Presale.fromJson(saleElement));
              }
            }
          }
        }
        notifyListeners();
      },
    );
  }

  Future<void> loadPresales(String accessToken, String cafeteriaId,
      int studentId, UserRole userType) async {
    String today = DateFormat("yyyy-MM-dd").format(DateTime.now().toUtc());
    developer.log(
      "${urls.getProductHistoryUrl}?page_size=100&created_at__gte=$today&sale_type=PS",
      name: "loadPresales",
    );

    developer.log(
      cafeteriaId,
      name: "CafeteriaIdentifierLoadPresales",
    );

    await http.get(
      Uri.parse(
        "${urls.getProductHistoryUrl}?page_size=100&created_at__gte=$today&sale_type=PS",
      ),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "loadPresales_statusCode",
        );
        developer.log(response.body, name: "loadPresales_body");
        //print(response.statusCode );
        presales = [];
        if (response.statusCode == 200) {
          List<dynamic> body =
              json.decode(utf8.decode(response.bodyBytes))["results"];
          if (userType == UserRole.tutor || userType == UserRole.teacher) {
            for (dynamic saleElement in body) {
              Presale presale = Presale.fromJson(saleElement);

              //if(presale.saleStatus!="CANCELED"){
              presales.add(presale);
              //}
            }
          } else if (userType == UserRole.student) {
            for (dynamic saleElement in body) {
              Presale presale = Presale.fromJson(saleElement);
              //presale.saleStatus!="CANCELED"
              if (saleElement["user_buyer"]["instance"]["id"].toString() ==
                  studentId.toString()) {
                presales.add(presale);
              }
            }
          }
        }
        notifyListeners();
      },
    );
  }

  Future<void> initialLoad(String accessToken, String cafeteriaId,
      int studentId, UserRole userType, bool isAutosuficient) async {
    await homePageRefresh(
        accessToken, cafeteriaId, studentId, userType, isAutosuficient);
    // await loadPresales(accessToken, cafeteriaId, studentId, userType);
    // await loadSales(accessToken, cafeteriaId, studentId, userType, isAutosuficient);
  }

  Future<void> homePageRefresh(String accessToken, String cafeteriaId,
      int studentId, UserRole userType, bool isAutosuficient) async {
    loadPresales(accessToken, cafeteriaId, studentId, userType);
    loadSales(accessToken, cafeteriaId, studentId, userType, isAutosuficient);
  }
}
