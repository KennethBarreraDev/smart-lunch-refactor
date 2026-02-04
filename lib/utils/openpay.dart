import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;
import 'package:smart_lunch/utils/urls.dart' as urls;

const _sandboxUrl = "https://sandbox-api.openpay.mx";
const _productionUrl = "https://api.openpay.mx";

class Openpay {
  /// enable sandox or production mode
  /// False by default
  final bool isProductionMode;

  /// Your merchant id
  final String merchantId;

  /// Your public API Key
  final String apiKey;

  Openpay(this.merchantId, this.apiKey, {this.isProductionMode = false});

  String get _merchantBaseUrl => '$baseUrl/v1/$merchantId';

  String get baseUrl => isProductionMode ? _productionUrl : _sandboxUrl;

  /// Create a card
  Future<CardInfo> createCard(
    CardInfo card,
    String customerId,
    String deviceSessionId,
    String accessToken,
    String cafeteriaId,
    int internalId,
  ) async {
    String basicAuth = 'Basic ${base64.encode(utf8.encode("$apiKey:"))}';
    final cardInfo = [
      card.brand, card.cardNumber, card.creationDate, card.cvv2, card.expirationMonth, card.expirationYear, card.holderName, card.id, card.internalId,
      customerId, deviceSessionId, accessToken, cafeteriaId, internalId
    ];



    developer.log(
        {
          "holder_name": card.holderName,
          "card_number": card.cardNumber,
          "cvv2": card.cvv2 ?? "",
          "expiration_month": card.expirationMonth,
          "expiration_year": card.expirationYear,
          "device_session_id": deviceSessionId,
        }.toString(),
      name: "cardBody",
    );   
    
    developer.log(
      '$_merchantBaseUrl/tokens',
      name: "createCard_Url",
    );
    developer.log(
      apiKey,
      name: "createCard_ApiKey",
    );
    developer.log(
      merchantId,
      name: "createCard_MerchantId",
    );
    developer.log(
      basicAuth,
      name: "createCard_BasicAuth",
    );
    http.Response response = await http.post(
      Uri.parse('$_merchantBaseUrl/tokens'),
      headers: {
        'Content-type': 'application/json',
        'Authorization': basicAuth,
      },
      body: json.encode(
        {
          "holder_name": card.holderName,
          "card_number": card.cardNumber,
          "cvv2": card.cvv2 ?? "",
          "expiration_month": card.expirationMonth,
          "expiration_year": card.expirationYear,
          "device_session_id": deviceSessionId,
        },
      ),
    );
    print("Respuesta es ${response.body}");
    String tokenId = jsonDecode(response.body)["id"];
    developer.log(response.statusCode.toString(), name: "createCard1");
    developer.log(response.body.toString(), name: "createCard1");

   developer.log(cafeteriaId, name: "CafeteriaIdentifierCreateCard1");

    if (response.statusCode == 201) {
      http.Response createCardResponse = await http.post(
        Uri.parse(urls.registerCardUrl),
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
            "cafeteria": cafeteriaId,
          "Content-Type": "application/json",
          
        },
        body: json.encode(
          {
            "card_token_id": tokenId,
            "device_session_id": deviceSessionId,
          },
        ),
      );
      developer.log(
        createCardResponse.statusCode.toString(),
        name: "createCard",
      );
      developer.log(createCardResponse.body.toString(), name: "createCard");

      if (createCardResponse.statusCode == 200) {
        return CardInfo.fromBackend(
          jsonDecode(response.body),
          internalId,
        );
      } else {
        throw Exception('Error ${response.statusCode}, ${response.body}');
      }
    } else {
      throw Exception('Error ${response.statusCode}, ${response.body}');
    }
  }

  Future<bool> updateCard(
    CardInfo card,
    String customerId,
  ) async {
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$apiKey:'))}';
    http.Response response = await http.put(
      Uri.parse('$_merchantBaseUrl/customers/$customerId/cards/${card.id}'),
      headers: {
        'Content-type': 'application/json',
        'Authorization': basicAuth,
        'Accept': 'application/json',
      },
      body: json.encode(
        {
          "holder_name": card.holderName,
          "expiration_month": card.expirationMonth,
          "expiration_year": card.expirationYear,
        },
      ),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Error ${response.statusCode}, ${response.body}');
    }
  }
}

class CardInfo {
  final String cardNumber;
  final String holderName;
  final String expirationYear;
  final String expirationMonth;
  final String? cvv2;
  final String? brand;
  final String? creationDate;
  final String? id;
  final int internalId;

  // CardInfo(
  //   this.cardNumber,
  //   this.holderName,
  //   this.expirationYear,
  //   this.expirationMonth,
  //   String this.cvv2,
  // )   : brand = null,
  //       creationDate = null;

  CardInfo({
    required this.cardNumber,
    required this.holderName,
    required this.expirationYear,
    required this.expirationMonth,
    this.id,
    this.cvv2,
    this.brand,
    this.creationDate,
    this.internalId = -1,
  });

  factory CardInfo.fromBackend(Map data, int internalId) {
    return CardInfo(
      id: data["id"],
      brand: data['brand'] ?? "",
      cardNumber:
          data['card_number']?.substring(data['card_number'].length - 4) ?? "",
      holderName: data['holder_name'] ?? "",
      expirationYear: data['expiration_year'] ?? "",
      expirationMonth: data['expiration_month'] ?? "",
      creationDate: data['creationDate'] ?? "",
      cvv2: data['cvv2'] ?? "",
      internalId: internalId,
    );
  }

  @override
  String toString() {
    return 'CardInfo{cardNumber: ${cardNumber.contains('XX') ? cardNumber : 'hidden'}, holderName: $holderName, expirationYear: $expirationYear, expirationMonth: $expirationMonth, cvv2: ${cvv2 == null ? null : '***'}, brand: $brand, creationDate: $creationDate, id: $id, internalId: $internalId}';
  }
}
