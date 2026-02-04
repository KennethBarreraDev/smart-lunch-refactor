import 'dart:convert';

List<Child> childFromJson(String str) =>
    List<Child>.from(json.decode(str).map((x) => Child.fromJson(x)));

String childToJson(List<Child> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Child {
  Child({
    required this.id,
    required this.imageUrl,
    required this.childName,
    required this.childLastName,
    required this.registrationNumber,
    required this.status,
    required this.userId,
    required this.dailySpendLimit,
    required this.allergies,
    required this.customAllergy,
    required this.forbiddenProducts,
    required this.limitedProducts,
    required this.debt,
    required this.school,
    required this.email,
    required this.username,
    required this.studentId,
    required this.birthDate,
    required this.isIndependent,
    required this.bands,
    required this.membership,
    required this.membershipExpiration
  });

  int id;
  final String imageUrl;
  final String birthDate;
  final String studentId;
  final String childName;
  final String childLastName;
  final String registrationNumber;
  final String status;
  final String userId;
  double dailySpendLimit;
  double debt;
  List<int> allergies;
  String customAllergy;
  List<int> forbiddenProducts;
  Map<int, int> limitedProducts;
  final String school;
  final String email;
  final String username;
  final bool isIndependent;
  String openpayId="";
 final List<dynamic>? bands;
 final String? membershipExpiration;
bool membership;

  factory Child.fromJson(Map<String, dynamic>? json) {
    List<int> jsonAllergies = [];
    Map<int, int> jsonLimitedProducts = {};
    List<int> jsonForbiddenProducts = [];

    for (dynamic allergy in json?["allergies"] ?? []) {
      jsonAllergies.add(allergy["allergy"]["id"]);
    }

    for (dynamic productRestriction in json?["product_restrictions"] ?? []) {
      if (productRestriction["restriction_type"] == "limit") {
        jsonLimitedProducts.addAll({
          productRestriction["product"]: productRestriction["quantity"],
        });
      } else {
        jsonForbiddenProducts.add(productRestriction["product"]);
      }
    }

    return Child(
      id: json?["id"] ?? -1,
      childName: json?["first_name"] ?? "",
      childLastName: json?["last_name"] ?? "",
      imageUrl: json?["picture"] ?? "",
      registrationNumber: json?["student_id"] ?? "",
      status: !(json?["archived"] ?? true) ? "Activo" : "Inactivo",
      school: json?["user"]?["school"].toString() ?? "",
      userId: json?["user"]?["id"].toString() ?? "",
      username: json?["user"]?["username"].toString() ?? "",
      email: json?["user"]?["email"].toString() ?? "",
      dailySpendLimit: double.tryParse(json?["daily_limit"] ?? "") ?? 0,
      allergies: jsonAllergies,
      customAllergy: json?["custom_allergy"] ?? "",
      forbiddenProducts: jsonForbiddenProducts,
      limitedProducts: jsonLimitedProducts,
      debt: double.tryParse(json?["debt"] ?? "") ?? 0,
      birthDate: json?["birth_date"] ?? "",
      studentId: json?["student_id"] ?? "",
      isIndependent: json?["self_sufficient"] ?? false,
      membershipExpiration: json?["membership_expiration"],
      bands: json?["user"]?["bands"] ?? [],
      membership: true
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "childName": childName,
        "imageUrl": imageUrl,
        "registrationNumber": registrationNumber,
        "status": status,
        "dailySpendLimit": dailySpendLimit,
        "allergies": allergies,
        "forbiddenProducts": forbiddenProducts,
        "limitedProducts": limitedProducts,
        "last_name": childLastName,
        "debt": debt,
        "student_id": studentId,
        "birth_date": birthDate,
        "self_sufficient":  isIndependent,
        "bands": bands
      };
}
