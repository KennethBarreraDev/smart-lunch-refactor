import 'dart:convert';

List<Coupon> couponFromJson(String str) =>
    List<Coupon>.from(json.decode(str).map((x) => Coupon.fromJson(x)));

String couponToJson(List<Coupon> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Coupon {
  Coupon({
    required this.name,
    required this.address,
    required this.logo,
    required this.backgroundColor,
    required this.description,
    required this.expiryDate,
    required this.companyName,
    required this.mapUrl,
    required this.state,
    required this.companyUrl,
  });

  String name;
  String address;
  String logo;
  String backgroundColor;
  String description;
  String expiryDate;
  String companyName;
  String mapUrl;
  String state;
  String companyUrl;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        logo: json["image"],
        name: json["name"],
        address: json["address"],
        backgroundColor: json["color"],
        description: json["description"],
        expiryDate: json["expiry_date"],
        companyName: json["company"],
        mapUrl: json["map_url"],
        state: json["state"],
        companyUrl: json["company_url"],
      );

  Map<String, dynamic> toJson() => {
        "logo": logo,
        "name": name,
        address: address,
      };
}
