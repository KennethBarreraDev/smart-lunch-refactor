import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/models/product_model.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/utils/banner_utils.dart';
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/utils/urls.dart' as urls;
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/utils/banner_utils.dart' show BannerTypes;

class SaleProvider with ChangeNotifier {
  Map<int, int> cart = {};
  List<Product> cartProducts = [];
  int totalProducts = 0;
  int totalProductsCopy = 0;
  double totalPrice = 0;
  bool isSellingProducts = false;
  String saleType = "";
  double balance = 0;
  bool balanceLimitReached = false;

  bool paySaleWithBalance = true;

  bool validatingBalance = false;

  String saleBannerType = "";
  String saleBannerMessage = "";

  String successfulSaleId = "12345";
  String successfulSaleDate = "04 de Mayo, 2023";
  String successfulSaleCharge = "154.00";
  String successfulSaleChild = "Mario Huerta";

  bool cancelPresaleError = false;
  bool cancelPresaleSuccess = false;

  TextEditingController saleDateController = TextEditingController()
    ..text = "Seleccione una fecha";
  String selectedDateFormat =
      DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();

  late DateTime timeScheduled;
  String scheduledHour = "Seleccione una hora";

  DateTime selectedDate = DateTime.now();
  TextEditingController saleCommentsController = TextEditingController();

  bool hasSelectedDateInPresale = false;

  void resetCart() {
    cart = {};
    cartProducts = [];
    totalProducts = 0;
    totalPrice = 0;
    isSellingProducts = false;
    // saleType = "";
    notifyListeners();
  }



  void changePayWithCardOption(bool value) {
    paySaleWithBalance = value;
    notifyListeners();
  }

  void updateSaleDate(DateTime dateTime, bool isPresale) {
    selectedDate = dateTime;
    saleDateController.text = DateFormat("EEEE',' d 'de' MMMM  'de' y", 'es')
        .format(dateTime)
        .toString();
    selectedDateFormat = DateFormat("dd/MM/yyyy").format(dateTime).toString();
    if (isPresale) {
      notifyListeners();
    }
  }

  bool balanceLimitStatus() {
    return balanceLimitReached;
  }

  void changeValidateBalanceValue(bool value) {
    validatingBalance = value;
    notifyListeners();
  }

  void addItem(Product product) {
    int productId = product.id;
    totalPrice += product.price;
    if (cart.containsKey(productId)) {
      cart.update(productId, (value) => (cart[productId] ?? 0) + 1);
    } else {
      cart.addAll(
        {
          productId: 1,
        },
      );
      cartProducts.add(product);
      print("Productos son: $cartProducts");
    }
    totalProducts += 1;

    totalProductsCopy = totalProducts;
    //print("Carrito");
    //print(cart);
    //print(cartProducts);
    notifyListeners();
  }

  void removeItem(Product product) {
    int productId = product.id;

    if (cart.containsKey(productId)) {
      cart.update(productId, (value) => (cart[productId] ?? 0) - 1);
      cart.removeWhere((key, value) => value <= 0);
      totalPrice -= product.price;
      totalProducts -= 1;
      if (!cart.containsKey(productId)) {
        cartProducts.removeWhere((element) => element.id == productId);
      }
    }

    /*
    print("super id " + product.id.toString());
    for(var element in cartProducts){
      print("Id de producto" + element.id.toString());
    }*/

    totalProductsCopy = totalProducts;
    //print("Carrito");
    //print(cart);
    //print(cartProducts);
    notifyListeners();
  }

  Future<void> getCurrentBalance(UserRole userType) async {
    balanceLimitReached = false;

    

    late StorageProvider storageProvider = StorageProvider();
    String tutorId = await storageProvider.readValue("tutorId");
    String studentId = await storageProvider.readValue("studentId");
    String accessToken = await storageProvider.readValue("accessToken");
    String cafeteriaId = await storageProvider.readValue("cafeteriaId");
    //String refreshToken = await storageProvider.readValue("refreshToken");
    String url = "";
    developer.log(cafeteriaId, name: "CafeteriaIdentifierGetCurrentBalance");

    if (userType == UserRole.tutor || userType == UserRole.teacher) {
      url = "${urls.getTutorInfoUrl}$tutorId/";
    } else if (userType == UserRole.student) {
      url = "${urls.getStudentInfoUrl}$studentId/";
    }
    await http.get(
      Uri.parse(url),
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
          balance = double.parse(balanceString);
          if (balance < totalPrice) {
            balanceLimitReached = true;
          } else {
            balanceLimitReached = false;
          }
          notifyListeners();
        } else {
          // Show error
        }
      },
    );
  }

  void removeProductFromCar(int productId, double price) {
    int productAmount = 0;
    cart.forEach((key, value) {
      if (key == productId) {
        productAmount = value;
      }
    });

    totalProducts -= productAmount;
    totalProductsCopy = totalProducts;
    totalPrice -= (price * productAmount);
    cart.removeWhere((key, value) => key == productId);
    cartProducts.removeWhere((element) => element.id == productId);

    notifyListeners();
  }

  void updateSaleType(newSaleType) {
    print('Updating sale type:  $newSaleType');
    saleType = newSaleType;
    notifyListeners();
  }

  Future<bool> sellProducts(
    String accessToken,
    String cafeteriaId,
    String childUserId,
    bool isIndependentStudent,
    String cardId,
    String deviceSessionId,
    bool payWithBalance,
    AppLocalizations? appLocalizations,
  ) async {
    isSellingProducts = true;
    notifyListeners();
    bool wasSaleSuccessful = true;
    String url = "";

    if (saleType == "PS") {
      url = urls.preSellProducts;
    } else {
      if (!payWithBalance) {
        url = urls.sellProducts;
      } else {
        url = urls.sellProductsMobile;
      }
    }
    
    developer.log(url, name: "sellProductsBody");

    List<Map<String, int>> orders = [];

    for (MapEntry<int, int> cartItem in cart.entries) {
      orders.add({
        "product": cartItem.key,
        "quantity": cartItem.value,
      });
    }

    String comments = saleCommentsController.text;

    if (comments.isEmpty) {
      comments = "";
    }
    Map<String, dynamic> data = {};

    if (!payWithBalance) {
      if (saleType != "PS") {
        String formattedScheduledDate =
            DateFormat("yyyy-MM-dd'T'HH:mm:ss.'000Z'")
                .format(timeScheduled.add(const Duration(minutes: 2)).toUtc())
                .toString();
        data = {
          "orders": orders,
          "comment": comments,
          "user_buyer": childUserId,
          "sale_type": "IM",
          "payment_method": "OPENPAY",
          // "status": "MO",
          "card_id": cardId,
          "device_session_id": deviceSessionId,
          "scheduled_date": formattedScheduledDate
        };
      } else {
        data = {
          "orders": orders,
          "comment": comments,
          "user_buyer": childUserId,
          "sale_type": "PS",
          "payment_method": "OPENPAY",
          // "status": "MO",
          "card_id": cardId,
          "device_session_id": deviceSessionId,
        };
      }

      if (saleType == "PS") {
        print("Es precompra");
        DateTime dateScheduledRaw =
            DateFormat('dd/MM/yyyy').parse(selectedDateFormat);
        String formattedScheduledDate = dateScheduledRaw.toUtc().toString();
        print(formattedScheduledDate);
        data.addAll({"scheduled_date": formattedScheduledDate});
      }
    } else {
      data = {
        "orders": orders,
        "comment": comments,
        "user_buyer": childUserId,
        "sale_type": saleType == "PS" ? 'PS' : 'IM',
        "payment_method": "SMART_COIN",
      };

      if (saleType == "PS") {
        //print("Es precompra");
        DateTime dateScheduledRaw =
            DateFormat('dd/MM/yyyy').parse(selectedDateFormat);
        String formattedScheduledDate = dateScheduledRaw.toUtc().toString();
        //print(formattedScheduledDate);
        data.addAll({"scheduled_date": formattedScheduledDate});
      } else {
        String formattedScheduledDate =
            DateFormat("yyyy-MM-dd'T'HH:mm:ss.'000Z'")
                .format(DateTime.now().toUtc())
                .toString();
        data.addAll({"scheduled_date": formattedScheduledDate});
      }
    }

    developer.log(data.toString(), name: "sellProductsBody");
    developer.log(cafeteriaId, name: "CafeteriaIdentifiersellProductsBody");

    //developer.log(data.toString(), name: "sellProducts_body");

    await http
        .post(
      Uri.parse(url),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId,
        "Content-Type": "application/json",
      },
      body: json.encode(
        data,
      ),
    )
        .then(
      (response) async {
        developer.log(
          response.statusCode.toString(),
          name: "sellProducts_statusCode",
        );
        developer.log(
          response.body,
          name: "sellProducts_body",
        );
        if (response.statusCode == 201) {
          Map<String, dynamic> responseMap =
              json.decode(utf8.decode(response.bodyBytes));
          successfulSaleId = responseMap["folio"];
          successfulSaleDate = DateFormat("dd MMM, yyyy", 'es').format(
            selectedDate,
          );
          successfulSaleCharge = responseMap["final_price"];
          successfulSaleChild =
              "${responseMap["user_buyer"]["instance"]["first_name"]} ${responseMap["user_buyer"]["instance"]["last_name"]}";
          resetCart();
        } else {
          updateBalanceTopUpBanner(
            BannerTypes.errorBanner.type,
            appLocalizations,
          );
          wasSaleSuccessful = false;
        }
      },
    );
    isSellingProducts = false;
    notifyListeners();
    return wasSaleSuccessful;
  }

  Future<void> cancelPresale(saleId, accessToken, cafeteriaId, context) async {

    developer.log(cafeteriaId, name: "CafeteriaIdentifierCancelPresale");
    HomeProvider homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );

    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );

    Map<String, dynamic> data = {"sale_id": saleId};

    await http
        .post(
      Uri.parse(urls.cancelPresale),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId,
        "Content-Type": "application/json",
      },
      body: json.encode(
        data,
      ),
    )
        .then(
      (response) async {
        developer.log(
          response.statusCode.toString(),
          name: "cancelPresale_statusCode",
        );
        developer.log(
          response.body,
          name: "cancelPresale_body",
        );
        if (response.statusCode == 200) {
          cancelPresaleSuccess = true;
          homeProvider.presales
              .removeWhere((element) => element.presaleId == saleId);
          homeProvider.loadPresales(
              mainProvider.accessToken,
              mainProvider.cafeteriaId,
              int.parse(mainProvider.studentId),
              mainProvider.userType);
        } else {
          cancelPresaleError = true;
        }
      },
    );
    notifyListeners();
  }

  void updateScheduledHour(String hour) {
    scheduledHour = hour;
    notifyListeners();
  }

  void hideSaleTopUpBanner() {
    saleBannerType = "";
    saleBannerMessage = "";
    notifyListeners();
  }

  void updateBalanceTopUpBanner(
    String type,
    AppLocalizations? appLocalizations,
  ) {
    saleBannerType = type;
    if (type == BannerTypes.successBanner.type) {
      saleBannerMessage = appLocalizations!.succes_sale;
    } else {
      saleBannerMessage = appLocalizations!.try_again_later;
    }
  }
}
