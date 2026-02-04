import 'dart:convert';

import 'package:intl/intl.dart';

List<RechargeHistory> cafeteriaFromJson(String str) =>
    List<RechargeHistory>.from(
        json.decode(str).map((x) => RechargeHistory.fromJson(x)));

String cafeteriaToJson(List<RechargeHistory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RechargeHistory {
  RechargeHistory({
    required this.id,
    required this.rechargeUser,
    required this.rechargeDate,
    required this.rechargeTime,
    required this.total,
    required this.platform,
  });

  String id;
  String rechargeUser;
  String rechargeDate;
  String rechargeTime;
  String total;
  String platform;

  factory RechargeHistory.fromJson(Map<String, dynamic> json) {
    DateTime rechargeDate =
        DateTime.tryParse(json["recharge_date"])?.toLocal() ?? DateTime.now();

    return RechargeHistory(
      id: json["folio"],
      rechargeUser:
          "${json["user_recharger"]?["instance"]?["first_name"] ?? ""} ${json["user_recharger"]?["instance"]?["last_name"] ?? ""}",
      rechargeDate: DateFormat("dd/MM/yyyy").format(rechargeDate),
      rechargeTime: DateFormat("hh:mm a").format(rechargeDate),
      total: json["amount"],
      platform: json["payment_method"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
