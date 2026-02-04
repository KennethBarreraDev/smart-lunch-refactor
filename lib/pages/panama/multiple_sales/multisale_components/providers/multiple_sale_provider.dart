import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/models/child_model.dart';
import 'package:smart_lunch/models/multisale_product_model.dart';
import 'package:smart_lunch/models/product_model.dart';
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/banner_utils.dart';
import 'package:smart_lunch/utils/urls.dart' as urls;
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class MultisaleProvider with ChangeNotifier {
  Child? selectedChild;
  double familyBalanceOriginal = 0;
  double familyBalance = 0;
  List<MultisaleProducts> multisaleProducts = [];
  Map<int, int> filterCart = {};
  List<Product> saleProducts = [];
  double totalPrice = 0;
  bool canBuy = false;
  TextEditingController commentController = TextEditingController();
  bool isSellingProducts = false;

  bool applyDisscount = false;
  double disccount = 0;

  String multisaleBannerType = "";
  String multisaleBannerMessage = "";

  void hideBalanceTopUpBanner() {
    multisaleBannerType = "";
    multisaleBannerMessage = "";
    notifyListeners();
  }

  void updateMultisaleBanner(
    String type,
    AppLocalizations? appLocalizations,
  ) {
    multisaleBannerType = type;
    if (type == BannerTypes.successBanner.type) {
      multisaleBannerMessage = appLocalizations!.succes_sale;
    } else {
      multisaleBannerMessage = appLocalizations!.try_again_later;
    }
  }

  MultisaleProducts selectedSaleDate = MultisaleProducts(
      saleDate: DateTime.now(),
      cart: {},
      cartProducts: [],
      totalPrice: 0,
      totalProducts: 0);

  void changeSelectedChild(Child child) {
    selectedChild = child;
    notifyListeners();
  }

  void resetValues() {
    familyBalanceOriginal = 0;
    familyBalance = 0;
    multisaleProducts = [];
    filterCart = {};
    saleProducts = [];
    totalPrice = 0;
    canBuy = false;
    applyDisscount = false;
    selectedSaleDate = MultisaleProducts(
        saleDate: DateTime.now(),
        cart: {},
        cartProducts: [],
        totalPrice: 0,
        totalProducts: 0);

    notifyListeners();
  }

  void setCurrentBalance(double balance) {
    familyBalance = balance;
    familyBalanceOriginal = balance;
    notifyListeners();
  }

  void saveSaleComment() {
    selectedSaleDate =
        selectedSaleDate.copyWith(comment: commentController.text);

    print(" Comentario es  1 ${selectedSaleDate.comment}");
    notifyListeners();
  }

  double getTotalPrice() {
    selectedSaleDate = selectedSaleDate.copyWith();
    double totalPrice = multisaleProducts.reduce((value, element) {
      return MultisaleProducts(
          saleDate: selectedSaleDate.saleDate,
          cart: selectedSaleDate.cart,
          cartProducts: selectedSaleDate.cartProducts,
          totalPrice: value.totalPrice + element.totalPrice);
    }).totalPrice;

    print("Total price $totalPrice");

    return totalPrice;
  }

  void returnBalanceToUser() {
    commentController.clear();
    familyBalance = familyBalance +
        (familyBalanceOriginal - familyBalance) -
        getTotalPrice();

    if (multisaleProducts.every((element) => element.cartProducts.isEmpty)) {
      print("Usuario no puede comprar");
      selectedSaleDate = selectedSaleDate.copyWith(selected: false);
      canBuy = false;
    }

    selectedSaleDate = MultisaleProducts(
        saleDate: DateTime.now(),
        cart: {},
        cartProducts: [],
        totalPrice: 0,
        totalProducts: 0,
        selected: false);
    notifyListeners();
  }

  void changeSelectedDate(
      DateTime saleDate,
      Map<int, int> cart,
      List<Product> cartProducts,
      double totalPrice,
      int totalProducts,
      bool selected,
      String comment) {
    print(
        "Data $saleDate $cart $cartProducts $totalPrice $totalProducts $selected");
    selectedSaleDate = MultisaleProducts(
        saleDate: saleDate,
        cart: {},
        cartProducts: [],
        totalPrice: 0,
        totalProducts: 0,
        selected: false,
        comment: '');

    selectedSaleDate = MultisaleProducts(
        saleDate: saleDate,
        cart: cart,
        cartProducts: cartProducts,
        totalPrice: totalPrice,
        totalProducts: totalProducts,
        selected: selected,
        comment: comment);

    commentController.text = comment;

    notifyListeners();
  }

  void setCurrentSaleInfo(
      DateTime saleDate,
      Map<int, int> cart,
      List<Product> cartProducts,
      double price,
      int totalProducts,
      bool selected,
      String commment) {
    int saleIndex = multisaleProducts
        .indexWhere((element) => element.saleDate == selectedSaleDate.saleDate);

    if (saleIndex != -1) {
      multisaleProducts[saleIndex] = MultisaleProducts(
          saleDate: saleDate,
          cart: cart,
          cartProducts: cartProducts,
          totalPrice: price,
          totalProducts: totalProducts,
          selected: selected,
          comment: commment);

      print(
          "Valores ${multisaleProducts.where((element) => element.cartProducts.isNotEmpty).length}");
      if (multisaleProducts
              .where((element) => element.cartProducts.isNotEmpty)
              .length >=
          16) {
        print("entro al if");
        disccount = -3.25;
        applyDisscount = true;
      } else {
        print("Entro al else");
        disccount = 0;
        applyDisscount = false;
      }

      totalPrice = multisaleProducts.reduce((value, element) {
            return MultisaleProducts(
                saleDate: saleDate,
                cart: cart,
                cartProducts: cartProducts,
                totalPrice: value.totalPrice + element.totalPrice);
          }).totalPrice +
          disccount;
    }

    selectedSaleDate = MultisaleProducts(
        saleDate: DateTime.now(),
        cart: {},
        cartProducts: [],
        totalPrice: 0,
        totalProducts: 0,
        selected: false,
        comment: '');
    if (multisaleProducts.every((element) => element.cartProducts.isEmpty)) {
      print("Usuario no puede comprar");
      selectedSaleDate = selectedSaleDate.copyWith(selected: false);
      canBuy = false;
    }

    notifyListeners();
  }

  void addItem(Product product) {
    selectedSaleDate = selectedSaleDate.copyWith();
    int productId = product.id;

    selectedSaleDate.totalPrice += product.price;
    familyBalance -= product.price;

    if (selectedSaleDate.cart.containsKey(productId)) {
      selectedSaleDate.cart.update(
          productId, (value) => (selectedSaleDate.cart[productId] ?? 0) + 1);
    } else {
      selectedSaleDate.cart.addAll({
        productId: 1,
      });
      selectedSaleDate.cartProducts.add(product);
    }

    selectedSaleDate.totalProducts += 1;

    if (!selectedSaleDate.selected) {
      print('Usuario puede comprar');
      selectedSaleDate = selectedSaleDate.copyWith(selected: true);
      canBuy = true;
    }

    notifyListeners();
  }

  void removeItem(Product product) {
    selectedSaleDate = selectedSaleDate.copyWith();
    int productId = product.id;

    if (selectedSaleDate.cart.containsKey(productId)) {
      selectedSaleDate.totalPrice -= product.price;
      selectedSaleDate.totalProducts--;
      familyBalance += product.price;
      selectedSaleDate.cart.update(
          productId, (value) => (selectedSaleDate.cart[productId] ?? 0) - 1);
      selectedSaleDate.cart.removeWhere((key, value) => value <= 0);
      if (!selectedSaleDate.cart.containsKey(productId)) {
        selectedSaleDate.cartProducts
            .removeWhere((element) => element.id == productId);
      }
    }

    if (selectedSaleDate.cartProducts.isEmpty) {
      selectedSaleDate = selectedSaleDate.copyWith(selected: false);
    }

    notifyListeners();
  }

  void generateSaleDays(String country) {
    DateTime now = DateTime.now();
    int startDay = 0;

    if (now.weekday == DateTime.saturday) {
      startDay = 2;
      now = now.add(Duration(days: startDay));
    } else if (now.weekday == DateTime.sunday && now.hour < 12) {
      startDay = 1;
      now = now.add(Duration(days: startDay));
    } else {
      startDay = now.hour > 12 ? 2 : 1;
      now = now.add(Duration(days: startDay));

      print("${now.weekday}");

      if (now.weekday == DateTime.saturday) {
        startDay = 2;

        now = now.add(Duration(days: startDay));
      } else if (now.weekday == DateTime.sunday) {
        startDay = 1;

        now = now.add(Duration(days: startDay));
      }
    }

    int i = 0;
    while (multisaleProducts.length < 20) {
      DateTime saleDay = now.add(Duration(days: i));

      if (saleDay.weekday != DateTime.saturday &&
          saleDay.weekday != DateTime.sunday) {
        multisaleProducts.add(MultisaleProducts(
            saleDate: saleDay,
            cart: {},
            cartProducts: [],
            totalPrice: 0,
            totalProducts: 0,
            selected: false));
      }

      i++;
    }
  }

  Future<bool> sellProducts(
    String accessToken,
    String cafeteriaId,
    String childUserId,
    AppLocalizations? appLocalizations,
  ) async {
    isSellingProducts = true;
    notifyListeners();
    bool wasSaleSuccessful = true;
    String url = urls.multisaleProducts;

    developer.log(url, name: "multisaleProductsURL");

    List<dynamic> sales = [];

    for (MultisaleProducts date in multisaleProducts) {
      List<Map<String, int>> orders = [];

      if (date.cart.isNotEmpty) {
        for (MapEntry<int, int> cartItem in date.cart.entries) {
          orders.add({
            "product": cartItem.key,
            "quantity": cartItem.value,
          });
        }

        sales.add(
          {
            "orders": orders,
            "comment": date.comment,
            "sale_type": "DI",
            "scheduled_date": DateFormat("yyyy-MM-dd'T'HH:mm:ss.'000Z'")
                .format(date.saleDate.toUtc())
          },
        );
      }
    }

    Map<String, dynamic> data = {};
    data = {
      "sales": sales,
      "user_buyer": childUserId,
      "payment_method": "SMART_COIN",
    };

    developer.log(data.toString(), name: "multisaleProductsBody");

    developer.log(cafeteriaId, name: "CafeteriaIdentifierMultisaleProductsBody");

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
          name: "multisale_statusCode",
        );
        developer.log(
          response.body,
          name: "multisalebody",
        );
        if (response.statusCode == 201) {
        } else {
          updateMultisaleBanner(
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
}
