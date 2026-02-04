import 'dart:convert';

List<School> schoolFromJson(String str) =>
    List<School>.from(json.decode(str).map((x) => School.fromJson(x)));

String schoolToJson(List<School> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class School {
  School({
    required this.id,
    required this.name,
    required this.address,
    required this.logo,
    required this.country,
    required this.currency
  });

  int id;
  String name;
  String address;
  String logo;
  String? country;
  String? currency;

  factory School.fromJson(Map<String, dynamic> json) => School(
        id: json["id"],
        logo: json["logo"] ?? "",
        name: json["name"],
        address: json["address"] ?? "",
        country: json["country"] ?? "",
        currency: json["currency"] ?? ""
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo": logo,
        "name": name,
        "address": address,
        "country": country,
        "currency": currency
      };
}
