import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/utils/banner_utils.dart' show BannerTypes;
import 'package:smart_lunch/utils/dev_values.dart';
import 'package:smart_lunch/utils/openpay.dart' as openpay;
import 'package:smart_lunch/utils/urls.dart' as urls;
import 'package:webview_flutter/webview_flutter.dart';

class CardsInfoProvider with ChangeNotifier {
  TextEditingController holderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expirationMonthController = TextEditingController();
  TextEditingController expirationYearController = TextEditingController();
  TextEditingController cvv2Controller = TextEditingController();
  TextEditingController rechargeController = TextEditingController();

  String cardBrand = "";
  bool isRegisteringCard = false;
  bool isUpdatingCard = false;
  bool isLoadingPayment = false;
  bool isDeletingCard = false;
  bool isToppingUpBalance = false;
  bool isLoadingCardList = false;
  bool isUpdatingMainCardForSale = false;
  bool loadingCards = false;

  openpay.CardInfo? selectedCardForTopUp;
  String selectedCardToPaySaleId = "-1";
  int selectedCardToPaySaleInternalId = -2;

  late openpay.Openpay openPay;

  String mainCardId = "-1";
  bool isDirectCard = false;
  int selectedCardIdForPayment = -1;

  List<openpay.CardInfo?> cards = [];

  MethodChannel openpayPlatform = const MethodChannel("smart.lunch/openpay");

  String cardRegisterBannerType = "";
  String cardRegisterBannerMessage = "";

  String cardListBannerType = "";
  String cardListBannerMessage = "";

  String selectCardBannerType = "";
  String selectCardBannerMessage = "";

  String balanceTopUpBannerType = "";
  String balanceTopUpBannerMessage = "";

  String cardIdForUpdate = "";

  String rechargeFolio = "";
  String openpayFolio = "";
  String openpayRechargeStatus = "";

  WebViewController openPayController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  Future<void> getOpenPayCredentials(
      String accessToken, String cafeteriaId) async {
    developer.log("Get tutor info start", name: "getOpenPayCredentials");
    developer.log(cafeteriaId, name: "CafeteriaIdentifierGetOpenPayCredentials");
    developer.log(
      urls.openPayCredentialsUrl,
      name: "getOpenPayCredentials_url",
    );
    await http.get(
      Uri.parse(urls.openPayCredentialsUrl),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "getOpenPayCredentials_statusCode",
        );

        
        if (response.statusCode == 200) {
          developer.log(
            response.body.toString(),
            name: "getOpenPayCredentials_body",
          );
          Map<String, dynamic> responseMap = json.decode(
            utf8.decode(response.bodyBytes),
          );
          developer.log(
            responseMap.toString(),
            name: "getOpenPayCredentials_responseMap",
          );

          //TODO: Cambiar modo de producción
          initializeOpenPay(
            responseMap["merchant_id"] ?? "",
            responseMap["public_key"] ?? "",
            isInProductionMode,
          );

          notifyListeners();
        } else {
          developer.log(response.body.toString(),
              name: "getOpenPayCredentials_body");
        }
      },
    );
  }

  Future<void> getTutorOpenPayAccount(
    String accessToken,
    String cafeteriaId,
    Function(String) updateTutorOpenPayId,
  ) async {
    developer.log("Get tutor info start", name: "getOpenPayCredentials");
      developer.log(cafeteriaId, name: "CafeteriaIdentifierFetOpenPayCredentials");
    developer.log(
      urls.openPayTutorUrl,
      name: "getOpenPayCredentials_url",
    );
    await http.get(
      Uri.parse(urls.openPayTutorUrl),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "getOpenPayCredentials_statusCode",
        );
        if (response.statusCode == 200) {
          developer.log(
            response.body.toString(),
            name: "getOpenPayCredentials_body_probe",
          );
          Map<String, dynamic> responseMap = json.decode(
            utf8.decode(response.bodyBytes),
          );

          mainCardId = responseMap["main_payment_token"] ?? "-1";
          updateTutorOpenPayId.call(responseMap["openpay_id"]);

          notifyListeners();
        } else {
          developer.log(response.body.toString(),
              name: "getOpenPayCredentials_body");
        }
      },
    );
  }

  void cleanCardRegistrationFields() {
    holderNameController.text = "";
    cardNumberController.text = "";
    expirationMonthController.text = "";
    expirationYearController.text = "";
    cvv2Controller.text = "";
  }

  void initializeFields(openpay.CardInfo? cardInfo) {
    holderNameController.text = cardInfo?.holderName ?? "";
    cardNumberController.text = "•••• ${cardInfo?.cardNumber}";
    expirationMonthController.text = cardInfo?.expirationMonth ?? "";
    expirationYearController.text = cardInfo?.expirationYear ?? "";
    cvv2Controller.text =
        cardInfo?.brand != "american_express" ? "•••" : "••••";
    cardIdForUpdate = cardInfo?.id ?? "";
  }

  void loadPage({
    bool isNewCard = true,
    int internalCardId = -1,
  }) {
    cleanCardRegistrationFields();
    if (!isNewCard) {
      openpay.CardInfo? tempCard = cards.firstWhere(
        (card) => (card?.internalId == internalCardId),
      );
      initializeFields(tempCard);
    }
    notifyListeners();
  }

  void updateCardRegisterBanner(
    String type,
    AppLocalizations? appLocalizations,
  ) {
    cardRegisterBannerType = type;
    if (type == BannerTypes.successBanner.type) {
      cardRegisterBannerMessage = appLocalizations!.register_card_succesfull;
    } else if (type == BannerTypes.warningBanner.type) {
      cardRegisterBannerMessage = appLocalizations!.verify_information;
    } else if (type == BannerTypes.errorBanner.type) {
      cardRegisterBannerMessage = appLocalizations!.error_registering_card;
    } else {
      cardRegisterBannerMessage = appLocalizations!.try_again_later;
    }
   
  }

  void updateCardSelectionBanner(
    String type,
    AppLocalizations? appLocalizations,
  ) {
    selectCardBannerType = type;
    if (type == BannerTypes.successBanner.type) {
      selectCardBannerMessage = appLocalizations!.selected_card_succesfully;
    } else if (type == BannerTypes.errorBanner.type) {
      selectCardBannerMessage = appLocalizations!.error_selecting_card;
    } else {
      selectCardBannerMessage = appLocalizations!.try_again_later;
    }
  }

  void updateCardUpdateBanner(
    String type,
    AppLocalizations? appLocalizations,
  ) {
    cardRegisterBannerType = type;
    if (type == BannerTypes.successBanner.type) {
      cardRegisterBannerMessage = appLocalizations!.succesfully_updated_card;
    } else if (type == BannerTypes.warningBanner.type) {
      cardRegisterBannerMessage = appLocalizations!.verify_information;
    } else if (type == BannerTypes.errorBanner.type) {
      cardRegisterBannerMessage = appLocalizations!.error_registering_card;
    } else {
      cardRegisterBannerMessage = appLocalizations!.try_again_later;
    }
  }

  void updateCardListBanner(
    String type,
    AppLocalizations? appLocalizations,
  ) {
    cardListBannerType = type;
    if (type == BannerTypes.successBanner.type) {
      cardListBannerMessage = appLocalizations!.delete_card_successfully;
    } else {
      cardListBannerMessage = appLocalizations!.removing_card_error;
    }
  }

  void updateBalanceTopUpBanner(
    String type,
    AppLocalizations? appLocalizations,
  ) {
    balanceTopUpBannerType = type;
    if (type == BannerTypes.successBanner.type) {
      balanceTopUpBannerMessage = appLocalizations!.successful_recharge;
    } else {
      balanceTopUpBannerMessage =
          appLocalizations!.recharge_error;
    }
  }

  void hideRegisterBanner() {
    cardRegisterBannerType = "";
    cardRegisterBannerMessage = "";
    notifyListeners();
  }

  void hideUpdateBanner() {
    cardRegisterBannerType = "";
    cardRegisterBannerMessage = "";
    notifyListeners();
  }

  void hideSelectCardBanner() {
    selectCardBannerType = "";
    selectCardBannerMessage = "";
    notifyListeners();
  }

  void hideListBanner() {
    cardListBannerType = "";
    cardListBannerMessage = "";
    notifyListeners();
  }

  void hideBalanceTopUpBanner() {
    balanceTopUpBannerType = "";
    balanceTopUpBannerMessage = "";
    notifyListeners();
  }

  void initializeOpenPay(
    String merchantId,
    String publicApiKey,
    bool isProductionMode,
  ) async {
    developer.log(
      "Before",
      name: "openpay_initialize",
    );
    openPay = openpay.Openpay(
      merchantId,
      publicApiKey,
      isProductionMode: isProductionMode,
    );
    developer.log(
      "After",
      name: "openpay_initialize",
    );

    try {
      await openpayPlatform.invokeMethod('initialize', {
        'merchantId': merchantId,
        'publicApiKey': publicApiKey,
        'isProductionMode': isProductionMode,
      });

      //String result2 = await openpayPlatform.invokeMethod('getDeviceSessionId');
      //print('Result from Native: ${result2.toString()}');

      developer.log(
        "End",
        name: "openpay_initialize",
      );
    } on PlatformException catch (e) {
      developer.log(
        "Platform exception ${e.toString()}",
        name: "openpay_initialize_exception",
      );
    }
  }

  openpay.CardInfo? getSelectedCardForPayment() {
    developer.log(
      selectedCardForTopUp.toString(),
      name: "getSelectedCardForPayment",
    );

    try {
      selectedCardForTopUp = cards.firstWhere(
        (card) => (card?.id == selectedCardForTopUp?.id),
      );
      // notifyListeners();
      return selectedCardForTopUp;
    } catch (exception) {
      return null;
    }
  }

  void selectMainCardInSalePage(
      String token, String cafeteriaId, AppLocalizations? appLocalizations) async {
    isUpdatingMainCardForSale = true;

    notifyListeners();
    selectedCardForTopUp = cards.firstWhere(
      (card) => (card?.id == selectedCardToPaySaleId),
    );

    await onChangedMainCard(token, cafeteriaId, selectedCardToPaySaleId,
        selectedCardToPaySaleInternalId, appLocalizations);
    isUpdatingMainCardForSale = false;
    notifyListeners();
  }

  Future<void> onChangedMainCard(
    String accessToken,
    String cafeteriaId,
    String cardId,
    int internalCardId,
    AppLocalizations? appLocalizations,
  ) async {
    if (mainCardId != cardId) {
      mainCardId = cardId;
      selectedCardIdForPayment = internalCardId;
       developer.log(
           cafeteriaId,
            name: "CafeteriaIdentifierOnChangedMainCard_statusCode",
          );

      http
          .put(
        Uri.parse(urls.openPayTutorUrl),
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
          "cafeteria": cafeteriaId,
          "Content-Type": "application/json",
        },
        body: json.encode(
          {
            "main_payment_token": mainCardId,
          },
        ),
      )
          .then(
        (response) {
          developer.log(
            response.statusCode.toString(),
            name: "onChangedMainCard_statusCode",
          );
          if (response.statusCode == 200) {
            developer.log(
              response.body.toString(),
              name: "onChangedMainCard_body",
            );
            updateCardSelectionBanner(
              BannerTypes.successBanner.type,
              appLocalizations,
            );

            notifyListeners();
          } else {
            updateCardSelectionBanner(
              BannerTypes.errorBanner.type,
              appLocalizations,
            );
            notifyListeners();
          }
        },
      );
    }
  }

  void onChangeDirectCard(bool value) {
    isDirectCard = value;
    notifyListeners();
  }

  void onChangedSelectedCardForPayment(int? cardId) {
    selectedCardIdForPayment = cardId ?? -1;
    notifyListeners();
  }

  void onCardNumberChange(String cardNumber) {
    developer.log(cardNumber, name: "onCardNumberChange");
    if (cardBrand.isEmpty) {
      switch (cardNumber) {
        case "2":
        case "5":
          cardBrand = "mastercard";
          notifyListeners();
          return;
        case "4":
          cardBrand = "visa";
          notifyListeners();
          return;
        case "3":
          cardBrand = "american_express";
          notifyListeners();
          return;
      }
    } else {
      if (cardNumber.isEmpty) {
        cardBrand = "";
        notifyListeners();
      }
    }
  }

  Future<void> getCardList(String accessToken, String cafeteriaId) async {
    isLoadingCardList = true;
    notifyListeners();

    developer.log("Get tutor info start", name: "getCardList");
    developer.log(cafeteriaId, name: "CafeteriaIdentifierGetCardList");
    developer.log(
      urls.openPayTutorCardsUrl,
      name: "getCardList_url",
    );
    await http.get(
      Uri.parse(urls.openPayTutorCardsUrl),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "getCardList_statusCode",
        );
        cards = [];
        int internalId = 0;
        if (response.statusCode == 200) {
          developer.log(
            response.body.toString(),
            name: "getCardList_body",
          );
          for (dynamic card
              in json.decode(utf8.decode(response.bodyBytes))["data"]) {
            cards.add(openpay.CardInfo.fromBackend(card, internalId));
            internalId += 1;
          }
        } else {
          // Show error
        }
      },
    );

    if (cards.isNotEmpty) {
      try {
        selectedCardForTopUp =
            cards.firstWhere((card) => card!.id == mainCardId);
      } catch (error) {
        selectedCardForTopUp = cards[0];
      }
      selectedCardIdForPayment = selectedCardForTopUp?.internalId ?? -1;
      selectedCardToPaySaleId = selectedCardForTopUp!.id!;
    } else {
      selectedCardIdForPayment = -1;
    }
    isLoadingCardList = false;
    notifyListeners();
  }

  Future<void> registerCard(
    String accessToken,
    String cafeteriaId,
    String customerId,
    AppLocalizations? appLocalizations,
  ) async {
    print("Registrando tarjeta");
    isRegisteringCard = true;
    notifyListeners();
    if (cardNumberController.text.isEmpty ||
        holderNameController.text.isEmpty ||
        expirationMonthController.text.isEmpty ||
        expirationYearController.text.isEmpty ||
        cvv2Controller.text.isEmpty) {
      isRegisteringCard = false;
      updateCardRegisterBanner(
        BannerTypes.warningBanner.type,
        appLocalizations,
      );
      notifyListeners();
      return;
    }

    String deviceSessionId = "";

    try {
      deviceSessionId =
          await openpayPlatform.invokeMethod('getDeviceSessionId');
    } on PlatformException catch (e) {
      developer.log("Platform exception ${e.toString()}",
          name: "openpay_getDeviceToken");
      updateCardRegisterBanner(
        BannerTypes.errorBanner.type,
        appLocalizations,
      );
      notifyListeners();
      return;
    }
    developer.log(deviceSessionId, name: "openpay_getDeviceSessionId");

    try {
      openpay.CardInfo cardInfo = await openPay.createCard(
        openpay.CardInfo(
          cardNumber: cardNumberController.text,
          holderName: holderNameController.text,
          expirationMonth: expirationMonthController.text,
          expirationYear: expirationYearController.text,
          cvv2: cvv2Controller.text,
        ),
        customerId,
        deviceSessionId,
        accessToken,
        cafeteriaId,
        cards.length,
      );
      developer.log("cardInfo.toString()", name: "cardInfo");
      developer.log(cardInfo.toString(), name: "cardInfo");
      developer.log("cardInfo.toString()", name: "cardInfo");
      isRegisteringCard = false;
      cleanCardRegistrationFields();
      updateCardRegisterBanner(
        BannerTypes.successBanner.type,
        appLocalizations,
      );
      if (mainCardId.length < 3) {
        onChangedMainCard(accessToken, cafeteriaId, cardInfo.id ?? "", cardInfo.internalId,
            appLocalizations);
      }
      getCardList(
        accessToken,
        cafeteriaId
      );
      notifyListeners();
      developer.log(cardInfo.id.toString(), name: "registerCard_tokenInfo");
    } catch (exception) {
      developer.log(exception.toString(), name: "registerCard_Exception");
      isRegisteringCard = false;
      updateCardRegisterBanner(
        BannerTypes.errorBanner.type,
        appLocalizations,
      );
      notifyListeners();
    }
  }

  Future<void> updateCard(
    String accessToken,
    String cafeteriaId,
    String customerId,
    AppLocalizations? appLocalizations,
  ) async {
    isUpdatingCard = true;
    notifyListeners();
    if (holderNameController.text.isEmpty ||
        expirationMonthController.text.isEmpty ||
        expirationYearController.text.isEmpty) {
      isUpdatingCard = false;
      updateCardRegisterBanner(
        BannerTypes.warningBanner.type,
        appLocalizations,
      );
      notifyListeners();
      return;
    }

    try {
      bool isUpdateSuccessful = await openPay.updateCard(
        openpay.CardInfo(
          cardNumber: "",
          holderName: holderNameController.text,
          expirationMonth: expirationMonthController.text,
          expirationYear: expirationYearController.text,
          id: cardIdForUpdate,
        ),
        customerId,
      );
      isUpdatingCard = false;
      updateCardUpdateBanner(
        BannerTypes.successBanner.type,
        appLocalizations,
      );
      notifyListeners();
      getCardList(accessToken, cafeteriaId);
      developer.log(
        isUpdateSuccessful.toString(),
        name: "updateCard_isUpdateSuccessful",
      );
    } catch (exception) {
      isUpdatingCard = false;
      updateCardUpdateBanner(
        BannerTypes.successBanner.type,
        appLocalizations,
      );
    }
  }

  Future<void> deleteCard(
    String accessToken,
    String cafeteriaId,
    String cardId,
    String customerId,
    AppLocalizations? appLocalizations,
  ) async {
    isDeletingCard = true;
    notifyListeners();
    developer.log("Get tutor info start", name: "deleteCard");
    developer.log(cafeteriaId, name: "CafeteriaIdentifierDeleteCard");
    developer.log(
      "${urls.openPayTutorCardsUrl}delete/$cardId/",
      name: "deleteCard_url",
    );
    await http.delete(
      Uri.parse(
        "${urls.openPayTutorCardsUrl}delete/$cardId/",
      ),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId,
        "Content-Type": "application/json",
      },
    ).then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "deleteCard_statusCode",
        );
        if (response.statusCode == 200) {
          developer.log(
            response.body.toString(),
            name: "deleteCard_body",
          );
          if (mainCardId == cardId) {
            mainCardId = "-1";
          }
          updateCardListBanner(
            BannerTypes.successBanner.type,
            appLocalizations,
          );
          getCardList(accessToken, cafeteriaId);
        } else {
          updateCardListBanner(
            BannerTypes.errorBanner.type,
            appLocalizations,
          );
        }
      },
    );

    isDeletingCard = false;

    notifyListeners();
  }

  void changeCardForTopUpBalance(String? cardId) {
    selectedCardForTopUp = cards.firstWhere(
      (card) => (card?.id == cardId),
    );
    developer.log(cardId ?? "", name: "changeCardForTopUpBalance");
    developer.log(
      selectedCardForTopUp?.cardNumber ?? "-----",
      name: "changeCardForTopUpBalance",
    );
    developer.log(
      selectedCardForTopUp?.id ?? "-----",
      name: "changeCardForTopUpBalance",
    );
    notifyListeners();
  }

  Future<int> topUpBalance(String accessToken, String cafeteriaId, String tutorUserId,
      AppLocalizations? appLocalizations, String value) async {
    String deviceSessionId = "";
    int topUpBalanceResult = 0;
    isToppingUpBalance = true;
    notifyListeners();

    if (value.isEmpty || (double.tryParse(value) ?? 15000) >= 10000) {
      topUpBalanceResult = -1;
      isToppingUpBalance = false;
      notifyListeners();
      return topUpBalanceResult;
    }

    try {
      deviceSessionId =
          await openpayPlatform.invokeMethod('getDeviceSessionId');
    } on PlatformException catch (e) {
      topUpBalanceResult = -1;
      developer.log(
        "Platform exception ${e.toString()}",
        name: "openpay_getDeviceToken",
      );
      notifyListeners();
      return topUpBalanceResult;
    }
    developer.log(deviceSessionId, name: "openpay_getDeviceSessionId");
    ;

    developer.log(cafeteriaId, name: "CafeteriaIdentifieropenpay_getDeviceSessionId");

    await http
        .post(
      Uri.parse(urls.topUpBalanceUrl),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
         "cafeteria": cafeteriaId,
        "Content-Type": "application/json",
      },
      body: json.encode(
        {
          "amount": (double.tryParse(value) ?? 0),
          "user_recharger": tutorUserId,
          "payment_method": "OPENPAY",
          "card_id": selectedCardForTopUp?.id ?? "",
          "device_session_id": deviceSessionId,
        },
      ),
    )
        .then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "topUpBalance_statusCode",
        );
        developer.log(
          response.body.toString(),
          name: "topUpBalance_body",
        );
        if (response.statusCode == 201) {
          Map<String, dynamic> responseMap = json.decode(
            utf8.decode(response.bodyBytes),
          );

          developer.log(
            responseMap.toString(),
            name: "respuesta de openpay",
          );

          if (responseMap.containsKey("id")) {
            rechargeFolio = responseMap["folio"] ?? "";
            openpayFolio =
                responseMap["openpay_recharge"]["transaction_openpay_id"] ?? "";
            openpayRechargeStatus =
                responseMap["status"]?.toString().toUpperCase() ?? "";
            /*
            updateBalanceTopUpBanner(
              BannerTypes.successBanner.type,
              appLocalizations,
            );*/
          } else {
            openPayController.loadRequest(
              Uri.parse(
                responseMap["openpay_recharge"]["url_three_d_secure"],
              ),
            );
            topUpBalanceResult = 1;
          }

          notifyListeners();
        } 
        else if(response.statusCode == 401){
           topUpBalanceResult =401;
          notifyListeners();
        }
        else {
          updateBalanceTopUpBanner(
            BannerTypes.errorBanner.type,
            appLocalizations,
          );
          topUpBalanceResult = -1;
          notifyListeners();
        }
      },
    );
    isToppingUpBalance = false;
    if (topUpBalanceResult == 0) {
      //rechargeController.clear();
    }
    notifyListeners();
    developer.log(
      (topUpBalanceResult != -1).toString(),
      name: "isRechargeSuccessful",
    );
    return topUpBalanceResult;
  }

  Future<bool> confirm3dSecure(
    String accessToken,
    String cafeteriaId,
    String confirmationId,
    AppLocalizations? appLocalizations,
  ) async {
    bool isConfirmationSuccessful = true;
    developer.log("Confirm 3d secure start", name: "CafeteriaIdentifierConfirm3dSecure");
     developer.log(cafeteriaId, name: "confirm3dSecure");
    developer.log(
      "${urls.confirm3dSecurePrefixUrl}$cafeteriaId${urls.confirm3dSecurePostfixUrl}?id=$confirmationId",
      name: "confirm3dSecure_url",
    );
    await http.get(
      Uri.parse(
        "${urls.confirm3dSecurePrefixUrl}$cafeteriaId${urls.confirm3dSecurePostfixUrl}?id=$confirmationId",
      ),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
         "cafeteria": cafeteriaId
      },
    ).then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "confirm3dSecure_statusCode",
        );
        developer.log(
          response.body.toString(),
          name: "confirm3dSecure_body",
        );
        if (response.statusCode == 200) {
          updateBalanceTopUpBanner(
            BannerTypes.successBanner.type,
            appLocalizations,
          );
          notifyListeners();
        } else {
          updateBalanceTopUpBanner(
            BannerTypes.errorBanner.type,
            appLocalizations,
          );
          isConfirmationSuccessful = false;
        }
      },
    );
    return isConfirmationSuccessful;
  }

  void updateSaleCard(String cardId, int internalId) {
    selectedCardToPaySaleId = cardId;
    selectedCardToPaySaleInternalId = internalId;
    notifyListeners();
  }
}
