import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_lunch/models/child_model.dart';
import 'package:smart_lunch/models/multisale_product_model.dart';
import 'package:smart_lunch/models/product_category_model.dart';
import 'package:smart_lunch/models/product_model.dart';
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:http/http.dart' as http;
import 'package:smart_lunch/utils/urls.dart' as urls;

class MultisaleProductsProvider with ChangeNotifier {
  List<ProductCategory> categories = [];

  List<Product> products = [];
  int pageSize = 50;
  int currentPage = 1;
  int maxPages = 1;
  bool fetchingData = true;
  bool loadingProducts = false;
  TextEditingController productFilter = TextEditingController();

  void resetInput() {
    productFilter.text = '';
    notifyListeners();
  }

  Future<void> getCategories(String accessToken, String cafeteriaId) async {
    developer.log(urls.getProductsCategoriesUrl,
        name: "getAllProductCategoriesMultisale");

    developer.log(cafeteriaId,
        name: "CafeteriaIdentifierGetAllProductCategoriesMultisale");

    await http.get(
      Uri.parse(urls.getProductsCategoriesUrl),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(response.statusCode.toString(),
            name: "getAllProductCategoriesMultisale_statusCode");
        developer.log(response.body,
            name: "getAllProductCategoriesMultisale_body");
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

  Future<void> initialLoad(String accessToken, String cafeteriaId,
      bool isPanama, DateTime saleDate) async {
    getCategories(accessToken, cafeteriaId).then(
      (value) {
        getProducts(accessToken, cafeteriaId, isPanama, saleDate,
            omitFilters: true);
      },
    );
  }

  Future<void> getProducts(String accessToken, String cafeteriaId,
      bool isPanama, DateTime selectedDate,
      {Child? selectedChild,
      bool incrementPage = false,
      bool isPresale = false,
      bool omitFilters = true,
      bool resetPage = false,
      bool loadData = false}) async {
    developer.log(
      cafeteriaId,
      name: "CafeteriaIdentifierGetAllProducts",
    );
    if (incrementPage) {
      currentPage++;
    } else {
      currentPage = 1;
    }

    if (resetPage) {
      currentPage = 1;
    }

    DateTime utcDateTime = selectedDate;
    DateTime customUtcDateTime = DateTime.utc(
      utcDateTime.year,
      utcDateTime.month,
      utcDateTime.day,
      6, 0, 0, 0, 0, // Establecer la hora a 06:00:00.000
    );

    String formattedDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(customUtcDateTime);

    DateTime now = selectedDate;
    String dayOfWeek = DateFormat('EEE').format(now).toUpperCase();

    String saleChannel = isPresale ? 'ONLINE_PRESALES' : 'ONLINE_SALES';
    print("Is panama $isPanama");

    if (isPanama) {
      if (omitFilters) {
        developer.log(
          "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage&name=${productFilter.text}",
          name: "getAllProductsMultisaleURLMultisaleIF",
        );
      } else {
        developer.log(
          "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage&available_day=$formattedDate,$dayOfWeek&sales_channel=$saleChannel&name=${productFilter.text}",
          name: "getAllProductsMultisaleURLMultisaleELSE",
        );
      }
    } else {
      developer.log(
        "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage&name=${productFilter.text}",
        name: "getAllProductsMultisaleURLMultisaleNormal",
      );
    }

    if (currentPage <= maxPages) {
      if (loadData) {
        fetchingData = true;
        notifyListeners();
      }
      loadingProducts = true;
      notifyListeners();
      await http.get(
        // Uri.parse(
        //     //TODO: Agregar linea
        //     //&available_day=$formattedDate&weekly_days=$dayOfWeek
        //     isPanama && omitFilters
        //         ? "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage&name=${productFilter.text}"
        //         : (isPanama && !omitFilters)
        //             ? "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage&available_day=$formattedDate,$dayOfWeek&sales_channel=$saleChannel&name=${productFilter.text}"
        //             : "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage&name=${productFilter.text}"),
        Uri.parse(omitFilters
            ? "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage&name=${productFilter.text}"
            : (!omitFilters)
                ? "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage&available_day=$formattedDate,$dayOfWeek&sales_channel=$saleChannel&name=${productFilter.text}"
                : "${urls.getProductsUrl}?page_size=$pageSize&page=$currentPage&name=${productFilter.text}"),
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
          "cafeteria": cafeteriaId
        },
      ).then(
        (response) {
          developer.log(
            response.statusCode.toString(),
            name: "getAllProductsMultisale_statusCode",
          );
          // developer.log(response.body, name: "getAllProductsMultisale_body");
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
                      sku: product?["sku"] ?? 0,
                      stock: product?["stock"] ?? 0,
                      id: product?["id"] ?? 0,
                      imageUrl: product?["image"] ?? "",
                      productName: product?["name"] ?? "",
                      inventariable: product?["inventariable"] ?? false,
                      category: categories.firstWhere(
                          (element) => element.id == product["category"],
                          orElse: () => categories[0]),
                      description: product?["description"] ?? "",
                      price: double.tryParse(product["price"]) ?? 0,
                      availableDays: product?["available_days"] ?? "1111111",
                      ingredients: productList),
                );
              }
            }
          }

          print("Products ${products.length}");

          // if (selectedChild != null) {
          //   filterProducts(selectedChild);
          // }

          if (loadData) {
            fetchingData = false;
            notifyListeners();
          }
          loadingProducts = false;
          notifyListeners();
        },
      );
    }
  }

  List<Product> filterProducts(Child? selectedChild, DateTime selectedDate) {
    print("Filtrando products");
    DateTime now = selectedDate;
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
}
