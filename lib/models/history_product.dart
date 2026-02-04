import 'dart:convert';

List<HistoryProduct> historyProductFromJson(String str) =>
    List<HistoryProduct>.from(
        json.decode(str).map((x) => HistoryProduct.fromJson(x)));

String historyProductToJson(List<HistoryProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryProduct {
  HistoryProduct({
    required this.productName,
    required this.amount,
    required this.price,
  });

  final String productName;
  final int amount;
  final double price;

  factory HistoryProduct.fromJson(Map<String, dynamic> json) => HistoryProduct(
        productName: json["product"]?["name"] ?? "",
        amount: json["quantity"],
        price: double.tryParse(json["price"]) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "amount": amount,
        "price": price,
      };
}
