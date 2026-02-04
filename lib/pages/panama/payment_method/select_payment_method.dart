import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/models/successful_openpay_recharge.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:smart_lunch/pages/panama/payment_method/components/add_card_button.dart';
import 'package:smart_lunch/pages/panama/payment_method/components/fee_component.dart';
import 'package:smart_lunch/pages/panama/payment_method/components/panama_sale_card_component.dart';
import 'package:smart_lunch/pages/panama/payment_method/components/support_component.dart';
import 'package:smart_lunch/pages/panama/payment_method/components/yappi_button.dart';

import 'package:smart_lunch/pages/preferences/lang/languaje_provider.dart';
import 'package:smart_lunch/pages/providers.dart';
import 'package:smart_lunch/pages/top_up_mercado_pago/top_up_provider.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';

class PanamaPaymentMethod extends StatelessWidget {
  const PanamaPaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CardsCroemProvider croemCardInfo = Provider.of<CardsCroemProvider>(
      context,
      listen: false,
    );

    TopUpProvider topUpProvider = Provider.of<TopUpProvider>(
      context,
      listen: false,
    );

    return TransparentScaffold(
      selectedOption: "A",
      body: Column(
        children: [
          Consumer<MainProvider>(
            builder: (context, mainProvider, widget) => Expanded(
              child: Stack(
                children: [
                  CustomAppBar(
                    hideGoBackText: true,
                    titleSize: 25,
                    height: 250,
                    showPageTitle: true,
                    pageTitle: AppLocalizations.of(context)!.payment_method,
                    titleAlignment: Alignment.bottomRight,
                    image: images.appBarLongImg,
                    showDrawer: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 130,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Consumer3<CardsCroemProvider, MainProvider,
                                      HomeProvider>(
                                  builder:
                                      (context,
                                              cardsCroemProvider,
                                              mainProvider,
                                              homeProvider,
                                              widget) =>
                                          Container(
                                            height: (cardsCroemProvider
                                                    .cards.isEmpty)
                                                ? 300
                                                : (cardsCroemProvider
                                                            .cards.length ==
                                                        1)
                                                    ? 350
                                                    : (cardsCroemProvider
                                                                .cards.length ==
                                                            2)
                                                        ? 400
                                                        : 450,
                                            width: 340,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          bottom: 10,
                                                          left: 8),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .cards_message,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            "Comfortaa"),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: Divider(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                  ),
                                                ),
                                                Container(
                                                    constraints: BoxConstraints(
                                                      maxHeight: (cardsCroemProvider
                                                                  .cards
                                                                  .length ==
                                                              1)
                                                          ? 100
                                                          : (cardsCroemProvider
                                                                      .cards
                                                                      .length ==
                                                                  2)
                                                              ? 160
                                                              : (cardsCroemProvider
                                                                          .cards
                                                                          .length ==
                                                                      3)
                                                                  ? 250
                                                                  : 20, // Establece la altura máxima a 200 píxeles
                                                    ),
                                                    child:
                                                        Consumer<TopUpProvider>(
                                                            builder: (context,
                                                                topUpProvider,
                                                                child) {
                                                      return ListView(
                                                        shrinkWrap: false,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        children: cardsCroemProvider
                                                            .cards
                                                            .map((card) =>
                                                                PanamaSaleCardComponent(
                                                                    loader:
                                                                        "RECHARGE",
                                                                    cvvController:
                                                                        cardsCroemProvider
                                                                            .cvvController,
                                                                    totalAmount:
                                                                        topUpProvider
                                                                            .rechargeTotal.toStringAsFixed(2)
                                                                            ,
                                                                    cardTap:
                                                                        () {
                                                                          
                                                                       
                                                                      cardsCroemProvider
                                                                          .topUpBalance(
                                                                              mainProvider.accessToken,
                                                                              mainProvider.cafeteriaId,
                                                                              mainProvider.userType == UserRole.tutor || mainProvider.userType == UserRole.teacher ? mainProvider.tutor?.userId ?? "" : mainProvider.selectedChild?.userId ?? "",
                                                                              AppLocalizations.of(context),
                                                                              topUpProvider.rechargeTotal.toString(),
                                                                              "CROEM")
                                                                          .then(
                                                                        (isRechargeSuccessful) {
                                                                          if (isRechargeSuccessful ==
                                                                              0) {
                                                                            mainProvider.getFamilyBalance();

                                                                            Navigator.of(context).pushNamed(
                                                                              router.topUpOpenpayStatusRoute,
                                                                              arguments: SuccessfulRecharge(folio: cardsCroemProvider.rechargeFolio, transactionId: cardsCroemProvider.croemFolio, rechargeStatus: cardsCroemProvider.croemRechargeStatus, amount: topUpProvider.rechargeTotal.toString(), platform: "CROEM"),
                                                                            );
                                                                          } else if (isRechargeSuccessful ==
                                                                              -1) {
                                                                            Navigator.of(context).pop();
                                                                            Navigator.of(context).pop();
                                                                          } else {
                                                                            context.pop();
                                                                            Navigator.of(context).pop();
                                                                          }
                                                                        },
                                                                      );
                                                                    },
                                                                    cardId: card!
                                                                        .id
                                                                        .toString(),
                                                                    cardNumber:
                                                                        card.cardNumber ??
                                                                            "",
                                                                    holderName:
                                                                        card.cardHolderName ??
                                                                            "",
                                                                    internalId: card
                                                                        .internalId,
                                                                    cardBrand:
                                                                        cardsCroemProvider.getCardBrand(card.cardNumber ??
                                                                            "")))
                                                            .toList(),
                                                      );
                                                    })),
                                                const AddCardButton(),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                FeeComponent(
                                                  comissionFee: 3.5,
                                                  amount: topUpProvider
                                                      .rechargeTotal,
                                                ),
                                              ],
                                            ),
                                          )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            Expanded(
                                child: Divider(
                                    color: colors.darkBlue.withOpacity(0.15))),
                            Text(AppLocalizations.of(context)!.orAlso),
                            Expanded(
                                child: Divider(
                                    color: colors.darkBlue.withOpacity(0.15))),
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          Consumer<CardsCroemProvider>(
                              builder: (context, cardsCroemProvider, child) {
                            return YappiButton(
                              onTap: () {
                                cardsCroemProvider
                                    .topUpBalance(
                                        mainProvider.accessToken,
                                        mainProvider.cafeteriaId,
                                        mainProvider.userType ==
                                                    UserRole.tutor ||
                                                mainProvider.userType ==
                                                    UserRole.teacher
                                            ? mainProvider.tutor?.userId ?? ""
                                            : mainProvider
                                                    .selectedChild?.userId ??
                                                "",
                                        AppLocalizations.of(context),
                                        topUpProvider.rechargeTotal.toString(),
                                        "YAPPY")
                                    .then(
                                  (isRechargeSuccessful) {
                                    if (isRechargeSuccessful == 0) {
                                      mainProvider.getFamilyBalance();

                                      cardsCroemProvider.launchURL(
                                          context, cardsCroemProvider.yappyUrl);
                                    } else if (isRechargeSuccessful == -1) {
                                      Navigator.of(context).pop();
                                    } else {
                                      context.pop();
                                      Navigator.of(context).pop();
                                    }
                                  },
                                );
                              },
                              loading: cardsCroemProvider.isToppingUpBalance,
                            );
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          FeeComponent(
                              comissionFee: 2,
                              amount: topUpProvider.rechargeTotal),
                          const SizedBox(
                            height: 40,
                          ),
                          const SupportComponent()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
