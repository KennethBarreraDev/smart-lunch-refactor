import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/panama/membership_modal/membership_provider.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/widgets/card_summary_row.dart';

/// notificación antes de confirmar una recarga o el pago de una membresía.
class CvvConfirmationDialog extends StatelessWidget {
  const CvvConfirmationDialog({
    super.key,
    required this.totalAmount,
    required this.cvvController,
    required this.cardTap,
    required this.loader,
  });

  final String totalAmount;
  final TextEditingController cvvController;
  final void Function()? cardTap;
  final String loader;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Consumer<CardsCroemProvider>(
          builder: (context, cardsCroemProvider, child) {
        final selectedCard = cardsCroemProvider.selectedCardForTopUp;
        final brand = cardsCroemProvider
            .getCardBrand(selectedCard?.cardNumber ?? "");

        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: cardsCroemProvider.paymentError ? 450 : 400,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.card_cvv,
                  style: const TextStyle(
                      fontFamily: "Confortaa",
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2),
                      )),
                  child: CardSummaryRow(
                    holderName: selectedCard?.cardHolderName ?? "",
                    holderNameStyle: const TextStyle(fontSize: 12),
                    cardNumber: " ${selectedCard?.cardNumber ?? ""}",
                    cardNumberStyle: const TextStyle(fontSize: 10),
                    brand: brand,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 16,
                  enabled: true,
                  controller: cvvController,
                  decoration: const InputDecoration(
                    labelText: "CVV",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                cardsCroemProvider.paymentError
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Center(
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        color: colors.coral.withOpacity(0.2),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                              AppLocalizations.of(context)!
                                                  .cvv_error,
                                              style: const TextStyle(
                                                  color: colors.coral,
                                                  fontSize: 10)),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(
                                            Icons.credit_card_off,
                                            color: colors.coral,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      )
                    : const SizedBox(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.total_price,
                      style: const TextStyle(
                        fontFamily: "Outfit",
                        color: colors.darkBlue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$$totalAmount",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: cardTap,
                  child: Row(
                    children: [
                      Consumer2<CardsCroemProvider, MembershipProvider>(
                          builder: (context, cardsCroemProvider,
                              membershipProvider, child) {
                        return Expanded(
                          child: (loader == "RECHARGE" &&
                                      cardsCroemProvider.isToppingUpBalance) ||
                                  (membershipProvider.isBuyingMembership &&
                                      loader == "MEMBERSHIP")
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: colors.tuitionGreen,
                                    ),
                                  ],
                                )
                              : Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: colors.tuitionGreen
                                          .withOpacity(0.2),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.credit_score_outlined,
                                            color: colors.tuitionGreen,
                                            size: 24,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .continuePayment,
                                            style: const TextStyle(
                                                color: colors.tuitionGreen),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
