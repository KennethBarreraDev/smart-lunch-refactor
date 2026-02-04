import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/models/register_card_page_arguments.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';

class SelectCardComponent extends StatelessWidget {
  const SelectCardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer4<CardsInfoProvider, CardsCroemProvider, MainProvider,
            HomeProvider>(
        builder: (context, cardsInfoProvider, cardsCroemProvider, mainProvider,
                homeProvider, widget) =>
            (cardsInfoProvider.cards.isNotEmpty ||
                    (cardsCroemProvider.cards.isNotEmpty &&
                        (homeProvider.cafeteria?.school.country ?? "") ==
                            Contries.panama))
                ? GestureDetector(
                    onTap: () {
                      cardsCroemProvider.hideSelectCardBanner();
                      cardsInfoProvider.hideSelectCardBanner();
                      Navigator.of(context)
                          .pushNamed(router.selectCardToPaySale);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.card_message,
                              style: const TextStyle(
                                color: colors.darkBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0,
                              ),
                            ),
                            mainProvider.userType == UserRole.tutor &&
                                    (homeProvider.cafeteria?.school.country ??
                                            "") ==
                                        Contries.panama
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                cardsCroemProvider
                                                        .selectedCardForTopUp!
                                                        .cardHolderName ??
                                                    "",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(right: 5)),
                                      Text(
                                          " ${cardsCroemProvider.selectedCardForTopUp!.cardNumber}",
                                          style: const TextStyle(fontSize: 10)),
                                      cardsCroemProvider
                                              .getCardBrand(cardsCroemProvider
                                                      .selectedCardForTopUp
                                                      ?.cardNumber ??
                                                  "")
                                              .isNotEmpty
                                          ? Image.asset(
                                              images.getCardBrandImage(
                                                  cardsCroemProvider.getCardBrand(
                                                      cardsCroemProvider
                                                              .selectedCardForTopUp
                                                              ?.cardNumber ??
                                                          "visa")),
                                            )
                                          : Image.asset(
                                              images.getCardBrandImage("visa"),
                                            ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 20,
                                      )
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                cardsInfoProvider
                                                    .selectedCardForTopUp!
                                                    .holderName,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(right: 5)),
                                      Text(
                                          "●●●● ${cardsInfoProvider.selectedCardForTopUp!.cardNumber}",
                                          style: const TextStyle(fontSize: 10)),
                                      cardsInfoProvider.selectedCardForTopUp!
                                              .brand!.isNotEmpty
                                          ? Image.asset(
                                              images.getCardBrandImage(
                                                  cardsInfoProvider
                                                          .selectedCardForTopUp
                                                          ?.brand ??
                                                      "visa"),
                                            )
                                          : Image.asset(
                                              images.getCardBrandImage("visa"),
                                            ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 20,
                                      )
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      if (mainProvider.userType == UserRole.tutor &&
                          (homeProvider.cafeteria?.school.country ?? "") ==
                              Contries.panama) {
                        Navigator.of(context)
                            .pushNamed(router.createCroemCardRoute);
                      } else {
                        Navigator.pushNamed(
                          context,
                          router.registerCardRoute,
                          arguments: RegisterCardPageArguments(
                            isNewCard: true,
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.register_card,
                                  style: const TextStyle(
                                      color: colors.darkBlue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0,
                                      fontFamily: "Comfortaa"),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
  }
}
