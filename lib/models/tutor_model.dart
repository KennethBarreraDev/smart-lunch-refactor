import 'dart:convert';

List<Tutor> tutorFromJson(String str) =>
    List<Tutor>.from(json.decode(str).map((x) => Tutor.fromJson(x)));

String tutorToJson(List<Tutor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tutor {
  Tutor({
    required this.firstName,
    required this.lastName,
    required this.profilePictureUrl,
    required this.phoneNumber,
    required this.email,
    required this.openPayId,
    required this.username,
    required this.userId,
    required this.familyId,
    required this.birthDate,
    required this.school,
    required this.bands
  });

  String firstName;
  String lastName;
  String profilePictureUrl;
  String phoneNumber;
  String email;
  String openPayId;
  String username;
  String userId;
  String familyId;
  String birthDate;
  String school;
   final List<dynamic>? bands;

  factory Tutor.fromJson(Map<String, dynamic> json) => Tutor(
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        profilePictureUrl: json["picture"] ?? "",
        phoneNumber: json["phone"] ?? "",
        email: json["user"]?["email"] ?? "",
        school: json["user"]?["school"].toString() ?? "",
        openPayId: "",
        username: json["user"]?["username"] ?? "",
        birthDate: json["birth_date"] ?? "",
        userId: json["user"]?["id"].toString() ?? "",
        familyId: json["family"]?["id"].toString() ?? "",
        bands: json["user"]?["bands"] ?? []
      
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
      };
}
