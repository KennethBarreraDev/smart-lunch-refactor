import 'dart:convert';

List<Allergy> allergyFromJson(String str) =>
    List<Allergy>.from(json.decode(str).map((x) => Allergy.fromJson(x)));

String allergyToJson(List<Allergy> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Allergy {
  Allergy({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Allergy.fromJson(Map<String, dynamic> json) => Allergy(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
