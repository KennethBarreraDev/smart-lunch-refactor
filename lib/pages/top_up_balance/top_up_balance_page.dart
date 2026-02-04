import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/openpay.dart' as openpay;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/custom_banner.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';

import 'components/dropdown_with_label.dart';

class TopUpBalancePage extends StatelessWidget {
  const TopUpBalancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );

    return TransparentScaffold(
      selectedOption: "Inicio",
      body: SingleChildScrollView(
        child: Stack(
          children: [
            CustomAppBar(
              height: 240,
              showPageTitle: true,
              pageTitle: AppLocalizations.of(context)!.top_up,
              image: images.appBarShortImg,
              titleAlignment: Alignment.centerLeft,
              showDrawer: false,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 180,
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 0,
                            ),
                            width:
                                MediaQuery.of(context).size.width * 0.92558139,
                            height: 280,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x1f413931),
                                  offset: Offset(0, 6),
                                  blurRadius: 18,
                                  spreadRadius: -5,
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.current_balance,
                                  style: const TextStyle(
                                    color: colors.darkBlue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                const Divider(
                                  color: Color(0xff1f3098),
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                Expanded(
                                  child: Consumer2<MainProvider, HomeProvider>(
                                    builder: (context, mainProvider, homeProvider, widget) =>
                                        RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            style: const TextStyle(
                                              color: colors.darkBlue,
                                              fontSize: 40.0,
                                            ),
                                            text: (double.parse(mainProvider
                                                            .familyBalance) -
                                                        mainProvider
                                                            .totalDebt) <
                                                    0
                                                ? " - \$${(double.parse(mainProvider.familyBalance) - mainProvider.totalDebt).abs()}"
                                                : "\$${(double.parse(mainProvider.familyBalance) - mainProvider.totalDebt).abs()}",
                                          ),
                                          TextSpan(
                                            style: const TextStyle(
                                              color: colors.darkBlue,
                                              fontSize: 16.0,
                                            ),
                                            text: (homeProvider.cafeteria?.school.country ?? "") == Contries.panama ? " USD" : " MXN",
                                          )
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                Consumer<CardsInfoProvider>(
                                  builder:
                                      (context, cardsInfoProvider, widget) {
                                    openpay.CardInfo? selectedCardForPayment =
                                        cardsInfoProvider
                                            .getSelectedCardForPayment();

                                    if (cardsInfoProvider.isLoadingCardList) {
                                      return const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            color: colors.darkBlue,
                                          ),
                                        ],
                                      );
                                    } else if (selectedCardForPayment != null) {
                                      return DropdownWithLabel(
                                        label: "Tarjeta",
                                        initialValue: cardsInfoProvider
                                                .selectedCardForTopUp?.id ??
                                            "",
                                        options: cardsInfoProvider.cards
                                            .map(
                                              (card) => [
                                                card?.id ?? "",
                                                "•••• ${card?.cardNumber}"
                                              ],
                                            )
                                            .toList(),
                                        onChanged: cardsInfoProvider
                                            .changeCardForTopUpBalance,
                                      );
                                    }
                                    return const DropdownWithLabel(
                                      label: "Tarjeta",
                                      initialValue: "",
                                      options: [
                                        [
                                          "",
                                          "Agregue un método de pago",
                                        ],
                                      ],
                                      onChanged: null,
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Consumer<CardsInfoProvider>(
                                  builder:
                                      (context, cardsInfoProvider, widget) =>
                                          TextFormField(
                                    controller:
                                        cardsInfoProvider.rechargeController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              colors.darkBlue.withOpacity(0.08),
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                            4,
                                          ),
                                        ),
                                      ),
                                      labelText: "Cantidad de recarga",
                                      labelStyle: const TextStyle(
                                        color: colors.darkBlue,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ),
                                // DropdownWithLabel(
                                //   label: "Cantidad de recarga",
                                //   initialValue: "500",
                                //   options: const [
                                //     "500",
                                //     "1000",
                                //   ],
                                //   onChanged: (value) {},
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 27,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Text(
                          "* Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia",
                          style: TextStyle(
                            color: colors.darkBlue,
                            fontWeight: FontWeight.w500,
                            fontSize: 8.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Text(
                          "** Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia amet sint. Velit officia amet sint. Velit officia",
                          style: TextStyle(
                            color: colors.darkBlue,
                            fontWeight: FontWeight.w500,
                            fontSize: 8.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 27,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Consumer<CardsInfoProvider>(
                          builder: (context, cardsInfoProvider, widget) =>
                              ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 13,
                                horizontal: 24,
                              ),
                              backgroundColor: const Color(0xFFDCFAED),
                              shadowColor: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                            ),
                            onPressed: () {
                              cardsInfoProvider
                                  .topUpBalance(
                                      mainProvider.accessToken,
                                      mainProvider.cafeteriaId,
                                      mainProvider.userType == UserRole.tutor ||
                                              mainProvider.userType ==
                                                  UserRole.teacher
                                          ? mainProvider.tutor?.userId ?? ""
                                          : mainProvider
                                                  .selectedChild?.userId ??
                                              "",
                                      AppLocalizations.of(context),
                                      "9999")
                                  .then(
                                (isRechargeSuccessful) {
                                  if (isRechargeSuccessful == 0) {
                                    mainProvider.getFamilyBalance();
                                  } else if (isRechargeSuccessful == 1) {
                                    cardsInfoProvider.openPayController
                                        .currentUrl()
                                        .then(
                                      (value) {
                                        developer.log(
                                          value ?? "",
                                          name: "current url",
                                        );
                                      },
                                    );
                                    Navigator.of(context).pushNamed(
                                      router.openPay3dSecureRoute,
                                    );
                                  }
                                },
                              );
                              // Navigator.of(context).pop();
                            },
                            child: !cardsInfoProvider.isToppingUpBalance
                                ? const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.payments,
                                        color: colors.tuitionGreen,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Recargar",
                                        style: TextStyle(
                                          color: colors.tuitionGreen,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        color: colors.tuitionGreen,
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Consumer<CardsInfoProvider>(
                    builder: (context, cardsInfoProvider, widget) =>
                        CustomBanner(
                      bannerType: cardsInfoProvider.balanceTopUpBannerType,
                      bannerMessage:
                          cardsInfoProvider.balanceTopUpBannerMessage,
                      hideBanner: cardsInfoProvider.hideBalanceTopUpBanner,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
