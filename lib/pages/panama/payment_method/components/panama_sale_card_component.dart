import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/cards_info/active_card_provider_resolver.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/widgets/card_summary_row.dart';

import 'cvv_confirmation_dialog.dart';

class PanamaSaleCardComponent extends StatelessWidget {
  const PanamaSaleCardComponent(
      {super.key,
      required this.cardId,
      required this.cardNumber,
      required this.holderName,
      required this.internalId,
      required this.cardBrand,
      required this.cardTap,
      required this.totalAmount,
      required this.cvvController,
      required this.loader});

  final String holderName;
  final String cardNumber;
  final String cardId;
  final int internalId;
  final String cardBrand;
  final void Function()? cardTap;
  final String totalAmount;
  final TextEditingController cvvController;
  final String loader;

  @override
  Widget build(BuildContext context) {
    return Consumer3<CardsCroemProvider, MainProvider, HomeProvider>(
        builder: (context, cardsCroemProvider, mainProvider, homeProvider,
                widget) {
      final isPanamaTutor = isPanamaTutorContext(mainProvider, homeProvider);
      return GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      minVerticalPadding: 2,
                      horizontalTitleGap: 12,
                      contentPadding: EdgeInsets.zero,
                      title: CardSummaryRow(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        holderLabel: AppLocalizations.of(context)!.card_owner,
                        holderName: holderName,
                        holderNameStyle:
                            const TextStyle(fontSize: 13, fontFamily: "Comfortaa"),
                        cardNumber:
                            formatCardNumberDisplay(cardNumber, isPanamaTutor),
                        cardNumberStyle: const TextStyle(fontSize: 13),
                        brand: cardBrand,
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                      onTap: () {
                        cardsCroemProvider.updateSaleCard(cardId, internalId);
                        cardsCroemProvider.selectMainCardInSalePage(
                            mainProvider.accessToken,
                            AppLocalizations.of(context));

                        cardsCroemProvider.resetPaymentError();
                        cvvController.clear();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CvvConfirmationDialog(
                              totalAmount: totalAmount,
                              cvvController: cvvController,
                              cardTap: cardTap,
                              loader: loader,
                            );
                          },
                        );
                      },
                    ),
                    Divider(color: colors.darkBlue.withOpacity(0.15)),
                  ],
                ),
              ),
            );
    });
  }
}
