import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/cards_info/active_card_provider_resolver.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/widgets/card_summary_row.dart';

class SaleCardComponent extends StatelessWidget {
  const SaleCardComponent(
      {super.key,
      required this.cardId,
      required this.cardNumber,
      required this.holderName,
      required this.internalId,
      required this.cardBrand});

  final String holderName;
  final String cardNumber;
  final String cardId;
  final int internalId;
  final String cardBrand;

  @override
  Widget build(BuildContext context) {
    return Consumer4<CardsInfoProvider, CardsCroemProvider, MainProvider,
            HomeProvider>(
        builder: (context, cardInfoProvider, cardsCroemProvider, mainProvider,
                homeProvider, widget) {
      final isPanamaTutor = isPanamaTutorContext(mainProvider, homeProvider);
      final selectedCardId = isPanamaTutor
          ? cardsCroemProvider.selectedCardToPaySaleId
          : cardInfoProvider.selectedCardToPaySaleId;

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              minVerticalPadding: 12,
              horizontalTitleGap: 12,
              contentPadding: EdgeInsets.zero,
              title: CardSummaryRow(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                holderLabel: AppLocalizations.of(context)!.card_owner,
                holderName: holderName,
                holderNameWidth: 100,
                holderNameStyle:
                    const TextStyle(fontSize: 13, fontFamily: "Comfortaa"),
                cardNumber: formatCardNumberDisplay(cardNumber, isPanamaTutor),
                cardNumberStyle: const TextStyle(fontSize: 13),
                brand: cardBrand,
              ),
              trailing: Radio(
                value: cardId,
                groupValue: selectedCardId == cardId ? cardId : "",
                onChanged: (value) {
                  updateSaleCardOnActiveProvider(
                    isPanamaTutor: isPanamaTutor,
                    cardsCroemProvider: cardsCroemProvider,
                    cardsInfoProvider: cardInfoProvider,
                    cardId: cardId,
                    internalId: internalId,
                  );
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return colors
                      .orange; // Cambia el color de fondo cuando está seleccionado
                }),
                overlayColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
              ),
            ),
          ],
        ),
      );
    });
  }
}
