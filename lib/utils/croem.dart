// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;

import 'package:smart_lunch/utils/urls.dart' as urls;

class Croem {
  Croem();

  /// Create a card
  Future<CroemCardInfo> createCard(
    CroemCardInfo cardInfo,
     int internalId,
    String accessToken,
    String cafeteriaId
  ) async {
    Map<String, dynamic> requestBody = {
      "tokenized_card": cardInfo.tokenizedCard,
      "user": cardInfo.user,
      "card_number": cardInfo.cardNumber,
      "card_holder_name": cardInfo.cardHolderName,
      "identifier_name": cardInfo.identifierName
    };
    developer.log(requestBody.toString(), name: "Create_CroemCard_Body");
     developer.log(cafeteriaId, name: "CafeteriaIdentifier_Create_CroemCard_Body");

    http.Response createCardResponse = await http.post(
      Uri.parse(urls.croemCardsUrl),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
          "cafeteria": cafeteriaId,
        "Content-Type": "application/json",
      },
      body: json.encode(requestBody),
    );
    developer.log(
      createCardResponse.statusCode.toString(),
      name: "createCard",
    );
    developer.log(createCardResponse.body.toString(), name: "Croem_createCard");

    if (createCardResponse.statusCode == 201) {
      return CroemCardInfo.fromBackend(jsonDecode(createCardResponse.body), internalId);
    } else {
      throw Exception(
          'Error ${createCardResponse.statusCode}, ${createCardResponse.body}');
    }
  }
}

class CroemCardInfo {
  final int? id;
  final String? tokenizedCard;
  final int? user;
  final String? cardNumber;
  final String? cardHolderName;
  final String? identifierName;
  final String? createdAt;
   final int internalId;


  // CardInfo(
  //   this.cardNumber,
  //   this.holderName,
  //   this.expirationYear,
  //   this.expirationMonth,
  //   String this.cvv2,
  // )   : brand = null,
  //       creationDate = null;

  CroemCardInfo({
    required this.id,
    required this.user,
    required this.cardHolderName,
    required this.cardNumber,
    required this.identifierName,
    required this.tokenizedCard,
    required this.createdAt,
    this.internalId=-1
  });

  factory CroemCardInfo.fromBackend(Map data, int internalId) {
    return CroemCardInfo(
      id: data["id"],
      user: data["user"],
      tokenizedCard: data["tokenized_card"],
      cardNumber: data["card_number"],
      cardHolderName: data["card_holder_name"],
      identifierName: data["identifier_name"],
      createdAt: data["created_at"],
    );
  }

  @override
  String toString() {
    return 'CroemCardInfo(id: $id, tokenizedCard: $tokenizedCard, user: $user, cardNumber: $cardNumber, cardHolderName: $cardHolderName, identifierName: $identifierName, createdAt: $createdAt)';
  }
}
