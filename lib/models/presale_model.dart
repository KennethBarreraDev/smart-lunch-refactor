import 'dart:convert';

import 'package:intl/intl.dart';

import 'history_product.dart';

List<Presale> presaleFromJson(String str) =>
    List<Presale>.from(json.decode(str).map((x) => Presale.fromJson(x)));

String presaleToJson(List<Presale> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Presale {
  Presale({
    required this.childName,
    required this.childProfileImage,
    required this.orderNumber,
    required this.deliveryDate,
    required this.saleTotal,
    required this.products,
    required this.scheduledDate,
    required this.presaleId,
    required this.saleStatus,
    required this.userBuyer,
    required this.cafeteriaComment,
  });

  final String childName;
  final String childProfileImage;
  final String orderNumber;
  final String deliveryDate;
  final double saleTotal;
  final List<HistoryProduct> products;
  final String scheduledDate;
  final String presaleId;
  final String saleStatus;
  final int userBuyer;
  final String cafeteriaComment;

  factory Presale.fromJson(Map<String, dynamic> json) {
    DateTime saleDate =
        DateTime.tryParse(json["created_at"])?.toLocal() ?? DateTime.now();

    DateTime scheduledDate = DateTime.now();

    if (json["presale"] != null) {
      scheduledDate =
          DateTime.tryParse(json["presale"]?["scheduled_date"])?.toLocal() ??
              DateTime.now();
    }
    List<HistoryProduct> historyProducts = [];

    for (Map<String, dynamic> order in json["orders"]) {
      historyProducts.add(HistoryProduct.fromJson(order));
    }

    return Presale(
      childName:
          "${json["user_buyer"]?["instance"]?["first_name"] ?? ""} ${json["user_buyer"]?["instance"]?["last_name"] ?? ""}",
      childProfileImage: json["user_buyer"]?["instance"]?["picture"] ?? "",
      orderNumber: json["folio"] ?? "",
      deliveryDate: DateFormat("dd/MM/yyyy").format(saleDate),
      saleTotal: double.tryParse(json["final_price"]) ?? 0,
      products: historyProducts,
      scheduledDate: DateFormat("dd/MM/yyyy").format(scheduledDate),
      presaleId: json["id"]?.toString() ?? "",
      saleStatus: json["payment"]?["status"] ?? "",
      userBuyer: json["user_buyer"]?["instance"]?["id"] ?? 0,
      cafeteriaComment: json["cafeteria_comment"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "childName": childName,
        "childProfileImage": childProfileImage,
        "orderNumber": orderNumber,
        "deliveryDate": deliveryDate,
        "saleTotal": saleTotal,
        "products": products,
        "id": presaleId
      };
}
