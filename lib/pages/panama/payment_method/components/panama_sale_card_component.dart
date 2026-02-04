import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/pages/panama/membership_modal/membership_provider.dart';
import 'package:smart_lunch/pages/panama/payment_method/components/yappi_button.dart';
import 'package:smart_lunch/pages/top_up_mercado_pago/top_up_provider.dart';
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/roles.dart';

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
                widget) =>
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      minVerticalPadding: 2,
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
                                  Text(
                                    holderName,
                                    style: const TextStyle(
                                        fontSize: 13, fontFamily: "Comfortaa"),
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
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                      onTap: () {
                        print("Selected card $cardId $internalId");
                        cardsCroemProvider.updateSaleCard(cardId, internalId);
                        cardsCroemProvider.selectMainCardInSalePage(
                            mainProvider.accessToken,
                            AppLocalizations.of(context));

                        cardsCroemProvider.resetPaymentError();
                        cvvController.clear();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:
                                  Consumer2<CardsCroemProvider, TopUpProvider>(
                                      builder: (context, cardsCroemProvider,
                                          topUpProvider, child) {
                                return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: cardsCroemProvider.paymentError
                                      ? 450
                                      : 400,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context)!
                                              .card_cvv,
                                          style: const TextStyle(
                                              fontFamily: "Confortaa",
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                              )),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                cardsCroemProvider
                                                        .selectedCardForTopUp!
                                                        .cardHolderName ??
                                                    "",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              const Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 5)),
                                              Text(
                                                  " ${cardsCroemProvider.selectedCardForTopUp!.cardNumber}",
                                                  style: const TextStyle(
                                                      fontSize: 10)),
                                              cardsCroemProvider
                                                      .getCardBrand(
                                                          cardsCroemProvider
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
                                                      images.getCardBrandImage(
                                                          "visa"),
                                                    ),
                                            ],
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                          child: Center(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                color: colors
                                                                    .coral
                                                                    .withOpacity(
                                                                        0.2),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .cvv_error,
                                                                      style: const TextStyle(
                                                                          color: colors
                                                                              .coral,
                                                                          fontSize:
                                                                              10)),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  const Icon(
                                                                    Icons
                                                                        .credit_card_off,
                                                                    color: colors
                                                                        .coral,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .total_price,
                                              style: const TextStyle(
                                                fontFamily: "Outfit",
                                                color: colors.darkBlue,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "\$${totalAmount}",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700),
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
                                                builder: (context, cardsCroemProvider, membershipProvider, child) {
                                                  return Expanded(
                                                    child: (loader == "RECHARGE" &&
                                                                cardsCroemProvider
                                                                    .isToppingUpBalance) ||
                                                            (membershipProvider
                                                                    .isBuyingMembership &&
                                                                loader ==
                                                                    "MEMBERSHIP")
                                                        ? const Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              CircularProgressIndicator(
                                                                color: colors
                                                                    .tuitionGreen,
                                                              ),
                                                            ],
                                                          )
                                                        : Center(
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                color: colors
                                                                    .tuitionGreen
                                                                    .withOpacity(
                                                                        0.2),
                                                              ),
                                                              child: Center(
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
                                                                          .continuePayment,
                                                                      style: const TextStyle(
                                                                          color: colors
                                                                              .tuitionGreen),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                  );
                                                }
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        );
                      },
                    ),
                    Divider(color: colors.darkBlue.withOpacity(0.15)),
                  ],
                ),
              ),
            ));
  }
}
