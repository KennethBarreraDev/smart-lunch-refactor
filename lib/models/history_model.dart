import 'dart:convert';

import 'package:intl/intl.dart';

import 'history_product.dart';

List<ProductHistory> historyFromJson(String str) => List<ProductHistory>.from(
    json.decode(str).map((x) => ProductHistory.fromJson(x)));

String historyToJson(List<ProductHistory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductHistory {
  ProductHistory({
    required this.childName,
    required this.saleDate,
    required this.saleTime,
    required this.saleId,
    required this.saleType,
    required this.saleTotal,
    required this.products,
    required this.cafeteriaComment,
    required this.saleStatus
  });

  final String childName;
  final String saleDate;
  final String saleTime;
  final String saleId;
  final String saleType;
  final double saleTotal;
  final List<HistoryProduct> products;
  final String cafeteriaComment;
  final String saleStatus;
  

  factory ProductHistory.fromJson(Map<String, dynamic> json) {
    DateTime saleDate =
        DateTime.tryParse(json["created_at"])?.toLocal() ?? DateTime.now();
    List<HistoryProduct> historyProducts = [];
    for (Map<String, dynamic> order in json["orders"]) {
      historyProducts.add(HistoryProduct.fromJson(order));
    }

    return ProductHistory(
      childName:
          "${json["user_buyer"]?["instance"]?["first_name"] ?? ""} ${json["user_buyer"]?["instance"]?["last_name"] ?? ""}",
      saleDate: DateFormat("dd/MM/yyyy").format(saleDate),
      saleTime: DateFormat("hh:mm a").format(saleDate),
      saleId: json["folio"] ?? "",
      saleType: json["sale_type"] == "PS" ? "Preventa" : "Venta",
      saleTotal: double.tryParse(json["final_price"]) ?? 0,
      products: historyProducts,
      cafeteriaComment: json["cafeteria_comment"] ?? "",
        saleStatus: json["payment"]?["status"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "childName": childName,
        "saleDate": saleDate,
        "saleTime": saleTime,
        "saleId": saleId,
        "saleType": saleType,
        "saleTotal": saleTotal,
        "products": products,
      };
}
