import 'dart:convert';

import 'package:smart_lunch/models/product_category_model.dart';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product(
      {required this.id,
      required this.imageUrl,
      required this.productName,
      required this.category,
      required this.ingredients,
      required this.price,
      required this.availableDays,
      required this.description,
      required this.stock,
      required this.sku,
      required this.inventariable
      });

  final int id;
  final String imageUrl;
  final String productName;
  final ProductCategory category;
  final double price;
  final List<String> ingredients;
  final String availableDays;
  final String description;
  final int stock;
  final String sku;
  final bool inventariable;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["id"],
      imageUrl: json["image"] ?? "",
      productName: json["name"],
      category: ProductCategory.fromJson(json["category"]),
      description: json["description"],
      price: double.tryParse(json["price"]) ?? 0,
      availableDays: json["available_days"] ?? "",
      inventariable: json?["inventariable"] ?? false,
      ingredients: json["ingredients"] ?? [],
      stock: json["stock"] ?? 0,
      sku: json["sku"] ?? "");

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageUrl": imageUrl,
        "productName": productName,
        "category": category,
        "ingredients": ingredients,
        "available_days": availableDays,
        "description": description,
        "stock": stock,
        "inventariable": inventariable
      };
}
