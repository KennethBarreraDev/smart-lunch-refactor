import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_lunch/utils/urls.dart' as urls;
import 'package:intl/intl.dart';
import 'package:smart_lunch/models/child_model.dart';
import 'package:smart_lunch/models/product_category_model.dart';
import 'package:smart_lunch/models/product_model.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> products = [];
  List<ProductCategory> categories = [];
  bool loadingProducts = false;
  bool gettingNewProducts = false;
  int pageSize = 50;
  int currentPage = 1;
  int maxPages = 1;
  TextEditingController searchInputController = TextEditingController();

  Future<void> initialLoad(
      String accessToken, String cafeteriaId, bool isPanama) async {
    getCategories(accessToken, cafeteriaId).then(
      (value) {
        getProducts(accessToken, cafeteriaId, isPanama, omitFilters: true);
      },
    );
  }

  void resetInput() {
    searchInputController.text = '';
    notifyListeners();
  }

  Future<void> getCategories(String accessToken, String cafeteriaId) async {
    developer.log(urls.getProductsCategoriesUrl,
        name: "getAllProductCategories");
    developer.log(cafeteriaId,
        name: "CafeteriaIdentifierGetAllProductCategories");

    await http.get(
      Uri.parse(urls.getProductsCategoriesUrl),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(response.statusCode.toString(),
            name: "getAllProductCategories_statusCode");
        developer.log(response.body, name: "getAllProductCategories_body");
        categories = [];
        if (response.statusCode == 200) {
          List<dynamic> body =
              json.decode(utf8.decode(response.bodyBytes))["results"];

          for (dynamic product in body) {
            categories.add(ProductCategory.fromJson(product));
          }
        }
        notifyListeners();
      },
    );
  }

  Future<void> getProducts(
    String accessToken,
    String cafeteriaId,
    bool isPanama, {
    Child? selectedChild,
    bool incrementPage = false,
    bool isPresale = false,
    bool omitFilters = true,
    DateTime? replaceDate = null,
  }) async {
    developer.log(
      cafeteriaId,
      name: "CafeteriaIdentifierGetAllProductsURLELSE",
    );

    if (incrementPage) {
      currentPage++;
    } else {
      gettingNewProducts = true;
      currentPage = 1;
      notifyListeners();
    }

    DateTime utcDateTime = replaceDate ?? DateTime.now().toUtc();
    DateTime customUtcDateTime = DateTime.utc(
      utcDateTime.year,
      utcDateTime.month,
      utcDateTime.day,
      6, 0, 0, 0, 0, // Establecer la hora a 06:00:00.000
    );

    String formattedDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(customUtcDateTime);

    DateTime now = replaceDate ?? DateTime.now();
    String dayOfWeek = DateFormat('EEE').format(now).toUpperCase();

    String saleChannel = isPresale ? 'ONLINE_PRESALES' : 'ONLINE_SALES';

    if (true) {
      if (omitFilters) {
        developer.log(
          "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage",
          name: "getAllProductsURLIF",
        );
      } else {
        developer.log(
          "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage&available_day=$formattedDate,$dayOfWeek&sales_channel=$saleChannel",
          name: "getAllProductsURLELSE",
        );
      }
    }

    print("Real url ${ isPanama && omitFilters
                ? "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage"
                : (isPanama && !omitFilters)
                    ? "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage&available_day=$formattedDate,$dayOfWeek&sales_channel=$saleChannel"
                    : "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage"}");
    // } else {

    //   developer.log(
    //     "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage&available_day=$formattedDate,$dayOfWeek&sales_channel=$saleChannel",
    //     name: "getAllProductsURLNormal",
    //   );
    // }

    if (currentPage <= maxPages) {
      loadingProducts = true;
      notifyListeners();
      await http.get(
        Uri.parse(
            //TODO: Agregar linea
            //&available_day=$formattedDate&weekly_days=$dayOfWeek
           (!isPanama && !omitFilters) ?
           "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage&available_day=$formattedDate,$dayOfWeek&sales_channel=$saleChannel":
            (!isPanama && omitFilters) ? "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage" :
            (isPanama && omitFilters)
                ? "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage"
                : (isPanama && !omitFilters)
                    ? "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage&available_day=$formattedDate,$dayOfWeek&sales_channel=$saleChannel"
                    : "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage"),
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
          "cafeteria": cafeteriaId
        },
      ).then(
        (response) {
          developer.log(
            response.statusCode.toString(),
            name: "getAllProducts_statusCode",
          );
          developer.log(response.body, name: "getAllProducts_body");
          if (response.statusCode == 200) {
            if (currentPage == 1) {
              print("Eliminando productos");
              products = [];
            }
            Map<String, dynamic> body =
                json.decode(utf8.decode(response.bodyBytes));

            if (maxPages == 1) {
              maxPages = int.tryParse(body['total_pages'].toString()) ?? 0;
            }
            DateTime now = DateTime.now();
            int currentDay = now.weekday;
            if (currentDay == 7) {
              currentDay = 0;
            }
            for (dynamic product in body["results"]) {
              List<dynamic> productDynamicList = product?["ingredients"] ?? [];
              List<String> productList =
                  productDynamicList.map((e) => e.toString()).toList();

              if (true) {
                products.add(
                  Product(
                      sku: product?["sku"] ?? "",
                      stock: product?["stock"] ?? 0,
                      id: product?["id"] ?? 0,
                      imageUrl: product?["image"] ?? "",
                      productName: product?["name"] ?? "",
                      inventariable: product["inventariable"] ?? false,
                      category: categories.firstWhere(
                          (element) => element.id == product?["category"],
                          orElse: () => categories[0]),
                      description: product?["description"] ?? "",
                      price: double.tryParse(product["price"]) ?? 0,
                      availableDays: product?["available_days"] ?? "1111111",
                      ingredients: productList),
                );
              }
            }
          }

          // if (selectedChild != null) {
          //   filterProducts(selectedChild);
          // }
          gettingNewProducts = false;
          loadingProducts = false;
          notifyListeners();
        },
      );
    }
  }

  List<Product> getProductFromCategory(
      ProductCategory category, Child? selectedChild) {
    DateTime now = DateTime.now();
    int currentDay = now.weekday;
    if (currentDay == 7) {
      currentDay = 0;
    }

    if (selectedChild == null) {
      return products;
    }
    return products
        .where((product) =>
            product.category == category &&
            (product.stock > 0 || !product.inventariable) &&
            !(selectedChild.forbiddenProducts.contains(product.id)))
        .toList();
  }

  List<Product> filterProducts(Child? selectedChild) {
    DateTime now = DateTime.now();
    int currentDay = now.weekday;
    if (currentDay == 7) {
      currentDay = 0;
    }

    if (selectedChild == null) {
      return products;
    }
    return products
        .where((product) =>
            (product.stock > 0 || !product.inventariable) &&
            !(selectedChild.forbiddenProducts.contains(product.id) &&
                product.sku.toUpperCase() != "MEMBERSHIP"))
        .toList();
  }

  Future<void> productsRefresh(String accessToken, String cafeteriaId,
      Child selectedChild, bool isPanama) async {
    getProducts(accessToken, cafeteriaId, isPanama, omitFilters: true);
  }
}
