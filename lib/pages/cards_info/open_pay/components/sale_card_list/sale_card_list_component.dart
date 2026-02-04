import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/roles.dart';

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
                homeProvider, widget) =>
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    minVerticalPadding: 12,
                    horizontalTitleGap: 12,
                    contentPadding: EdgeInsets.zero,
                    title: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.card_owner,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 10,
                                      fontFamily: "Comfortaa"),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          holderName,
                                          style: const TextStyle(
                                              fontSize: 13, fontFamily: "Comfortaa"),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Text(
                                mainProvider.userType == UserRole.tutor &&
                                        (homeProvider.cafeteria?.school
                                                    .country ??
                                                "") ==
                                            Contries.panama
                                    ? cardNumber
                                    : "●●●● $cardNumber",
                                style: const TextStyle(fontSize: 13)),
                            cardBrand.isNotEmpty
                                ? Image.asset(
                                    images.getCardBrandImage(cardBrand),
                                  )
                                : Image.asset(
                                    images.getCardBrandImage("visa"),
                                  ),
                          ],
                        )
                      ],
                    ),
                    trailing: Radio(
                      value: cardId,
                      groupValue: mainProvider.userType == UserRole.tutor &&
                              (homeProvider.cafeteria?.school.country ?? "") ==
                                  Contries.panama
                          ? cardsCroemProvider.selectedCardToPaySaleId == cardId
                              ? cardId
                              : ""
                          : cardInfoProvider.selectedCardToPaySaleId == cardId
                              ? cardId
                              : "",
                      onChanged: (value) {
                        if (mainProvider.userType == UserRole.tutor &&
                            (homeProvider.cafeteria?.school.country ?? "") ==
                                Contries.panama) {
                          cardsCroemProvider.updateSaleCard(cardId, internalId);
                        } else {
                          cardInfoProvider.updateSaleCard(cardId, internalId);
                        }
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
            ));
  }
}
