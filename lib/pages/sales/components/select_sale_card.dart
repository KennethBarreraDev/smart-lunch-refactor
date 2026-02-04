import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/models/register_card_page_arguments.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/components/sale_card_list/sale_card_list_component.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/custom_banner.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';

class SelectCardToPaySalePage extends StatelessWidget {
  const SelectCardToPaySalePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double appBarHeight = 250;

    return TransparentScaffold(
      selectedOption: "Inicio",
      showDrawer: false,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomAppBar(
                      height: appBarHeight,
                      showPageTitle: true,
                      showDrawer: false,
                      image: images.appBarLongImg,
                      titleTopPadding: 0.3,
                      secondaryColor: true,
                    ),
                    Container(
                      color: const Color(0xFFf6f6f7),
                      height: 120,
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: (appBarHeight * 0.4) / 2.2,
                      )),
                      Text(
                        AppLocalizations.of(context)!.choose_card,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 110,
                      ),
                      child: Consumer4<CardsInfoProvider, CardsCroemProvider,
                              MainProvider, HomeProvider>(
                          builder: (context,
                                  cardsInfoProvider,
                                  cardsCroemProvider,
                                  mainProvider,
                                  homeProvider,
                                  widget) =>
                              Container(
                                height: (cardsInfoProvider.cards.length == 1 ||
                                        cardsCroemProvider.cards.length == 1)
                                    ? 300
                                    : (cardsInfoProvider.cards.length == 2 ||
                                            cardsCroemProvider.cards.length ==
                                                2)
                                        ? 370
                                        : 400,
                                width: 340,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10, left: 8),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .cards_message,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Comfortaa"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Divider(
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                    ),
                                    Container(
                                      constraints: BoxConstraints(
                                        maxHeight: (cardsInfoProvider
                                                        .cards.length ==
                                                    1 ||
                                                cardsCroemProvider
                                                        .cards.length ==
                                                    1)
                                            ? 100
                                            : (cardsInfoProvider.cards.length ==
                                                        2 ||
                                                    cardsCroemProvider
                                                            .cards.length ==
                                                        2)
                                                ? 170
                                                : 250, // Establece la altura máxima a 200 píxeles
                                      ),
                                      child: mainProvider.userType ==
                                                  UserRole.tutor &&
                                              (homeProvider.cafeteria?.school
                                                          .country ??
                                                      "") ==
                                                  Contries.panama
                                          ? ListView(
                                              shrinkWrap: false,
                                              padding: EdgeInsets.zero,
                                              children: cardsCroemProvider.cards
                                                  .map((card) => SaleCardComponent(
                                                      cardId:
                                                          card!.id.toString(),
                                                      cardNumber:
                                                          card.cardNumber ?? "",
                                                      holderName:
                                                          card.cardHolderName ??
                                                              "",
                                                      internalId:
                                                          card.internalId,
                                                      cardBrand: cardsCroemProvider
                                                          .getCardBrand(
                                                              card.cardNumber ??
                                                                  "")))
                                                  .toList(),
                                            )
                                          : ListView(
                                              shrinkWrap: false,
                                              padding: EdgeInsets.zero,
                                              children: cardsInfoProvider.cards
                                                  .map((card) =>
                                                      SaleCardComponent(
                                                          cardId:
                                                              card!.id ?? "",
                                                          cardNumber:
                                                              card.cardNumber,
                                                          holderName:
                                                              card.holderName,
                                                          internalId:
                                                              card.internalId,
                                                          cardBrand:
                                                              card.brand ?? ""))
                                                  .toList(),
                                            ),
                                    ),
                                    mainProvider.userType == UserRole.tutor &&
                                            (homeProvider.cafeteria?.school
                                                        .country ??
                                                    "") ==
                                                Contries.panama
                                        ? Column(
                                            children: [
                                              !cardsCroemProvider
                                                      .isUpdatingMainCardForSale
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 5,
                                                                left: 20,
                                                                right: 20),
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: OutlinedButton(
                                                          onPressed: () {
                                                            cardsCroemProvider
                                                                .selectMainCardInSalePage(
                                                                    mainProvider
                                                                        .accessToken,
                                                                    AppLocalizations.of(
                                                                        context));
                                                          },
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                colors
                                                                    .tuitionGreen
                                                                    .withOpacity(
                                                                        0.2),
                                                            side: BorderSide(
                                                                color: colors
                                                                    .tuitionGreen
                                                                    .withOpacity(
                                                                        0.2)),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .credit_score_outlined,
                                                                color: colors
                                                                    .tuitionGreen,
                                                                size: 24,
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .select_button,
                                                                style: const TextStyle(
                                                                    color: colors
                                                                        .tuitionGreen),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ))
                                                  : const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CircularProgressIndicator(
                                                          color: colors
                                                              .tuitionGreen,
                                                        )
                                                      ],
                                                    ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              !cardsInfoProvider
                                                      .isUpdatingMainCardForSale
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 5,
                                                                left: 20,
                                                                right: 20),
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: OutlinedButton(
                                                          onPressed: () {
                                                            cardsInfoProvider.selectMainCardInSalePage(
                                                                mainProvider
                                                                    .accessToken,
                                                                mainProvider
                                                                    .cafeteriaId,
                                                                AppLocalizations
                                                                    .of(context));
                                                          },
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                colors
                                                                    .tuitionGreen
                                                                    .withOpacity(
                                                                        0.2),
                                                            side: BorderSide(
                                                                color: colors
                                                                    .tuitionGreen
                                                                    .withOpacity(
                                                                        0.2)),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .credit_score_outlined,
                                                                color: colors
                                                                    .tuitionGreen,
                                                                size: 24,
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .select_button,
                                                                style: const TextStyle(
                                                                    color: colors
                                                                        .tuitionGreen),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ))
                                                  : const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CircularProgressIndicator(
                                                          color: colors
                                                              .tuitionGreen,
                                                        )
                                                      ],
                                                    ),
                                            ],
                                          ),
                                    (((homeProvider.cafeteria?.school.country ??
                                                        "") !=
                                                    Contries.panama &&
                                                !cardsInfoProvider
                                                    .isUpdatingMainCardForSale &&
                                                cardsInfoProvider.cards.length <
                                                    3) ||
                                            ((homeProvider.cafeteria?.school
                                                            .country ??
                                                        "") ==
                                                    Contries.panama &&
                                                !cardsCroemProvider
                                                    .isUpdatingMainCardForSale &&
                                                cardsCroemProvider
                                                        .cards.length <
                                                    3))
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10, left: 8),
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10, left: 20, right: 20),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: OutlinedButton(
                                                onPressed: () {
                                                  if (mainProvider.userType ==
                                                          UserRole.tutor &&
                                                      (homeProvider
                                                                  .cafeteria
                                                                  ?.school
                                                                  .country ??
                                                              "") ==
                                                          Contries.panama) {
                                                    Navigator.of(context)
                                                        .pushNamed(router
                                                            .createCroemCardRoute);
                                                  } else {
                                                    Navigator.pushNamed(
                                                      context,
                                                      router.registerCardRoute,
                                                      arguments:
                                                          RegisterCardPageArguments(
                                                        isNewCard: true,
                                                      ),
                                                    );
                                                  }
                                                },
                                                style: OutlinedButton.styleFrom(
                                                  backgroundColor: colors
                                                      .lightBlue
                                                      .withOpacity(0.2),
                                                  side: BorderSide(
                                                      color: colors.lightBlue
                                                          .withOpacity(0.2)),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.add_card_outlined,
                                                      color: colors.lightBlue,
                                                      size: 24,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .add_card,
                                                      style: const TextStyle(
                                                          color:
                                                              colors.lightBlue),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ))
                                        : Container(),
                                  ],
                                ),
                              )),
                    ),
                  ],
                ),
                Consumer<CardsInfoProvider>(
                  builder: (context, cardsInfoProvider, widget) => Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: CustomBanner(
                      bannerType: cardsInfoProvider.selectCardBannerType,
                      bannerMessage: cardsInfoProvider.selectCardBannerMessage,
                      hideBanner: cardsInfoProvider.hideSelectCardBanner,
                    ),
                  ),
                ),
                Consumer<CardsCroemProvider>(
                  builder: (context, cardsCroemProvider, widget) => Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: CustomBanner(
                      bannerType: cardsCroemProvider.selectCardBannerType,
                      bannerMessage: cardsCroemProvider.selectCardBannerMessage,
                      hideBanner: cardsCroemProvider.hideSelectCardBanner,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
