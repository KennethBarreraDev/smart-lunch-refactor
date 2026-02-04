import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:http/http.dart' as http;
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/utils/banner_utils.dart' show BannerTypes;
import 'package:smart_lunch/utils/croem.dart' as croem;
import 'package:smart_lunch/utils/urls.dart' as urls;
import 'package:webview_flutter/webview_flutter.dart';

class CardsCroemProvider with ChangeNotifier {
  TextEditingController cvvController = TextEditingController();

  String cardBrand = "";
  bool paymentError = false;

  bool isRegisteringCard = false;
  bool isUpdatingCard = false;
  bool isLoadingPayment = false;
  bool isDeletingCard = false;
  bool isToppingUpBalance = false;
  bool isLoadingCardList = false;
  bool isUpdatingMainCardForSale = false;

  croem.CroemCardInfo? selectedCardForTopUp;
  String selectedCardToPaySaleId = "-1";
  int selectedCardToPaySaleInternalId = -2;

  late croem.Croem croemInstance = croem.Croem();

  String mainCardId = "-1";
  bool isDirectCard = false;
  int selectedCardIdForPayment = -1;

  List<croem.CroemCardInfo?> cards = [];

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

  String yappyUrl = "";
  String croemFolio = "";
  String croemRechargeStatus = "";
  String createCardToken = "";
  int user = 0;

  WebViewController croemController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..clearCache()
    ..setBackgroundColor(const Color(0x00000000));

  void assignToken(String token, int userID) {
    createCardToken = token;
    user = userID;
    notifyListeners();
  }

  Future<void> registerCard(
    String tokenizedCard,
    String userID,
    String cardNumber,
    String cardHolderName,
    String identifierName,
    String accessToken,
    String cafeteriaId,
    AppLocalizations? appLocalizations,
  ) async {
    isRegisteringCard = true;
    notifyListeners();

    try {
      croem.CroemCardInfo card = await croemInstance.createCard(
          croem.CroemCardInfo(
              id: 0,
              user: int.tryParse(userID) ?? 0,
              cardHolderName: cardHolderName,
              cardNumber: cardNumber,
              identifierName: identifierName,
              tokenizedCard: tokenizedCard,
              createdAt: ""),
          cards.length,
          accessToken,
          cafeteriaId);

      updateCardRegisterBanner(
        BannerTypes.successBanner.type,
        appLocalizations,
      );

      developer.log(card.toString(), name: "cardInfo");
      isRegisteringCard = false;
      getCardList(accessToken, cafeteriaId);

      notifyListeners();
      //developer.log(cardInfo.id.toString(), name: "registerCard_tokenInfo");
    } catch (exception) {
      developer.log(exception.toString(), name: "registerCroemCard_Exception");
      isRegisteringCard = false;
      updateCardRegisterBanner(
        BannerTypes.errorBanner.type,
        appLocalizations,
      );

      notifyListeners();
    }
  }

  Future<void> getCardList(String accessToken, String cafeteriaId) async {
    isLoadingCardList = true;
    notifyListeners();

    developer.log("Get tutor info start", name: "getCroemCardList");
    developer.log(cafeteriaId, name: "CafeteriaIdentifierGetCroemCardList");
    developer.log(
      urls.croemCardsUrl,
      name: "getCardList_url",
    );
    await http.get(
      Uri.parse(urls.croemCardsUrl),
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
              in json.decode(utf8.decode(response.bodyBytes))["results"]) {
            cards.add(croem.CroemCardInfo.fromBackend(card, internalId));
            internalId += 1;
          }
        } else {
          // Show error
        }
      },
    );

    if (cards.isNotEmpty) {
      selectedCardForTopUp = cards[0];
      selectedCardToPaySaleId = selectedCardForTopUp?.id.toString() ?? "";
      try {
        // selectedCardForTopUp =
        //     cards.firstWhere((card) => card!.id == mainCardId);
      } catch (error) {}
    } else {
      selectedCardIdForPayment = -1;
    }
    isLoadingCardList = false;
    notifyListeners();
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
      "${urls.croemCardsUrl}$cardId/",
      name: "deleteCard_url",
    );
    developer.log(cafeteriaId, name: "CafeteriaIdentifierDeleteCard");
    await http.delete(
      Uri.parse(
        "${urls.croemCardsUrl}$cardId/",
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

  Future<int> topUpBalance(
      String accessToken,
      String cafeteriaId,
      String tutorUserId,
      AppLocalizations? appLocalizations,
      String value,
      String paymentMethod) async {
    Map<String, dynamic> rechargeBody = {
      "amount": (double.tryParse(value) ?? 0),
      "cvv": cvvController.text,
      "user_recharger": tutorUserId,
      "tokenized_card": selectedCardForTopUp?.tokenizedCard ?? "",
      "current_card": selectedCardForTopUp?.cardNumber ?? "",
      "payment_method": paymentMethod,
    };
    developer.log(
      "${rechargeBody}",
      name: "topUpBalanceCROEM_body",
    );

    developer.log(
      cafeteriaId,
      name: "CafeteriaIdentifierTopUpBalanceCROEM_body",
    );

    paymentError = false;

    if (paymentMethod == "CROEM") {
      if (cvvController.text.isEmpty || cvvController.text.length < 3) {
        paymentError = true;
        notifyListeners();
        return -1;
      }
    }

    int topUpBalanceResult = 0;
    isToppingUpBalance = true;
    notifyListeners();

    await http
        .post(
      Uri.parse(urls.topUpBalanceUrl),
      headers: <String, String>{
        "Authorization": "Bearer $accessToken",
        "cafeteria": cafeteriaId,
        "Device-Type": "Mobile",
        "Content-Type": "application/json",
      },
      body: json.encode(
        {
          "amount": (double.tryParse(value) ?? 0),
          "cvv": cvvController.text,
          "payment_method": paymentMethod,
          "user_recharger": tutorUserId,
          "tokenized_card": selectedCardForTopUp?.tokenizedCard ?? "",
        },
      ),
    )
        .then(
      (response) {
        developer.log(
          response.statusCode.toString(),
          name: "topUpBalanceCROEM_statusCode",
        );
        developer.log(
          response.body.toString(),
          name: "topUpBalanceCROEM_body",
        );
        if (response.statusCode == 201) {
          Map<String, dynamic> responseMap = json.decode(
            utf8.decode(response.bodyBytes),
          );
          developer.log(
            responseMap.toString(),
            name: "respuesta de croem",
          );

          if (paymentMethod == "CROEM") {
            rechargeFolio = responseMap["folio"] ?? "";
            croemFolio =
                responseMap["croem_recharge"]?["transaction_croem_id"] ?? "";
            croemRechargeStatus =
                responseMap["status"]?.toString().toUpperCase() ?? "";
          } else {
            yappyUrl = responseMap["url"] ?? "";
          }

          notifyListeners();
        } else {
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

  void hideRegisterBanner() {
    cardRegisterBannerType = "";
    cardRegisterBannerMessage = "";
    notifyListeners();
  }

  void hideSelectCardBanner() {
    selectCardBannerType = "";
    selectCardBannerMessage = "";
    notifyListeners();
  }

  void hideBalanceTopUpBanner() {
    balanceTopUpBannerType = "";
    balanceTopUpBannerMessage = "";
    notifyListeners();
  }

  void resetPaymentError() {
    paymentError = false;
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
      cardRegisterBannerMessage = appLocalizations!.error_registering_card;
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

  void updateBalanceTopUpBanner(
    String type,
    AppLocalizations? appLocalizations,
  ) {
    balanceTopUpBannerType = type;
    if (type == BannerTypes.successBanner.type) {
      balanceTopUpBannerMessage = appLocalizations!.successful_recharge;
    } else {
      balanceTopUpBannerMessage = appLocalizations!.recharge_error;
    }
  }

  void loadPage({
    bool isNewCard = true,
    int internalCardId = -1,
  }) {}

  String getCardBrand(String cardNumber) {
    String cardBrand = cardNumber[0];

    if (cardBrand.isNotEmpty) {
      switch (cardBrand) {
        case "2":
        case "5":
          return "mastercard";

        case "4":
          return "visa";

        case "3":
          return "american_express";

        default:
          return "";
      }
    } else {
      return "";
    }
  }

  void updateSaleCard(String cardId, int internalId) {
    selectedCardToPaySaleId = cardId;
    notifyListeners();
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

  void selectMainCardInSalePage(
      String token, AppLocalizations? appLocalizations) async {
    try {
      isUpdatingMainCardForSale = true;

      notifyListeners();
      selectedCardForTopUp = cards.firstWhere(
        (card) => (card?.id.toString() == selectedCardToPaySaleId),
      );
      isUpdatingMainCardForSale = false;

      updateCardSelectionBanner(
        BannerTypes.successBanner.type,
        appLocalizations,
      );

      print("Actualizó tarjeta");
    } catch (e) {
      updateCardSelectionBanner(
        BannerTypes.errorBanner.type,
        appLocalizations,
      );
    }

    notifyListeners();
  }

  void hideListBanner() {
    cardListBannerType = "";
    cardListBannerMessage = "";
    notifyListeners();
  }

  void launchURL(BuildContext context, String url) async {
    try {
      final theme = Theme.of(context);
      try {
        await launchUrl(
          Uri.parse(url),
          customTabsOptions: CustomTabsOptions(
            colorSchemes: CustomTabsColorSchemes.defaults(
              toolbarColor: theme.colorScheme.surface,
              navigationBarColor: theme.colorScheme.surface,
            ),
            shareState: CustomTabsShareState.on,
            urlBarHidingEnabled: true,
            showTitle: true,
          ),
          safariVCOptions: SafariViewControllerOptions(
            preferredBarTintColor: theme.colorScheme.surface,
            preferredControlTintColor: theme.colorScheme.onSurface,
            barCollapsingEnabled: true,
            entersReaderIfAvailable: false,
          ),
        );
      } catch (e) {
        // An exception is thrown if browser app is not installed on Android device.
        debugPrint(e.toString());
      }
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}
