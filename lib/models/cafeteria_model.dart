import 'dart:convert';

import 'package:smart_lunch/models/school_model.dart';

List<Cafeteria> cafeteriaFromJson(String str) =>
    List<Cafeteria>.from(json.decode(str).map((x) => Cafeteria.fromJson(x)));

String cafeteriaToJson(List<Cafeteria> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cafeteria {
  Cafeteria({
    required this.id,
    required this.name,
    required this.menu,
    required this.logo,
    required this.school,
    required this.email,
    required this.phone
  });

  int id;
  String name;
  String menu;
  String logo;
  School school;
  String phone;
  String email;

  factory Cafeteria.fromJson(Map<String, dynamic> json) => Cafeteria(
        id: json["id"],
        logo: json["logo"] ?? "",
        name: json["name"],
        menu: json["menu"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        school: School.fromJson(json["school"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo": logo,
        "name": name,
        "menu": menu,
        "school": school.toString(),
      };
}
