import 'dart:convert';

List<ProductCategory> productCategoryFromJson(String str) =>
    List<ProductCategory>.from(
        json.decode(str).map((x) => ProductCategory.fromJson(x)));

class ProductCategory {
  ProductCategory({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
