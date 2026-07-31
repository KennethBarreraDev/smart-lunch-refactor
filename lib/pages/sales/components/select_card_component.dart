import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/models/register_card_page_arguments.dart';
import 'package:smart_lunch/pages/cards_info/active_card_provider_resolver.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/card_summary_row.dart';
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
                ? Builder(builder: (context) {
                    final selectedCard = resolveSelectedCardForTopUp(
                      cardsCroemProvider: cardsCroemProvider,
                      cardsInfoProvider: cardsInfoProvider,
                      mainProvider: mainProvider,
                      homeProvider: homeProvider,
                    );
                    return GestureDetector(
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
                              CardSummaryRow(
                                holderName: selectedCard.holderName,
                                holderNameWidth: 120,
                                holderNameStyle:
                                    const TextStyle(fontSize: 12),
                                cardNumber: formatCardNumberDisplay(
                                  selectedCard.cardNumber,
                                  selectedCard.isPanamaTutor,
                                ),
                                cardNumberStyle:
                                    const TextStyle(fontSize: 10),
                                brand: selectedCard.brand,
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
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
