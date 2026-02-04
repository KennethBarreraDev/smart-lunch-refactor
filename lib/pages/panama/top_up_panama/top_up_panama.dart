import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/models/successful_openpay_recharge.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:smart_lunch/pages/sales/components/select_card_component.dart';
import 'package:smart_lunch/pages/top_up_mercado_pago/top_up_provider.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/roles.dart';

import 'package:smart_lunch/widgets/custom_banner.dart';

class TopUpCroemPage extends StatelessWidget {
  const TopUpCroemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TopUpProvider topUpProvider = Provider.of<TopUpProvider>(
      context,
      listen: false,
    );

    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );

    

    //List<double> buttonsList = topUpProvider.getValuesToRender(double.parse(mainProvider.cafeteriaSetting!.minimunOpenPayRechargeValue.toString()));

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 2,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xffEF5360),
                Color(0xffFFA66A),
              ],
            )),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).maybePop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.chevron_left,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                AppLocalizations.of(context)!.top_up,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.001),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text(
                                AppLocalizations.of(context)!.current_balance,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Consumer<MainProvider>(
                                builder: (context, mainProvider, widget) =>
                                    Padding(
                                      padding: const EdgeInsets.only(right: 30),
                                      child: Text(
                                        (double.parse(mainProvider
                                                        .familyBalance) -
                                                    mainProvider.totalDebt) <
                                                0
                                            ? " - \$${(double.parse(mainProvider.familyBalance) - mainProvider.totalDebt).abs()}"
                                            : "\$${(double.parse(mainProvider.familyBalance) - mainProvider.totalDebt).abs()}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                        ),
                                      ),
                                    )),
                          ],
                        )),
                  ),
                  Divider(
                    color: Colors.white.withOpacity(0.3),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 30, top: 5),
                    child: Text(
                      AppLocalizations.of(context)!.amount_message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
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
                        vertical: 8,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Consumer2<TopUpProvider, MainProvider>(
                          builder: (context, topUpProvider, mainProvider,
                                  widget) =>
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .suggested_options,
                                    style: const TextStyle(
                                      color: Color(0xffFFA66A),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    height: 120,
                                    child: GridView.builder(
                                      padding: EdgeInsets
                                          .zero, // set padding to zero
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: 6,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10,
                                              crossAxisCount: 3,
                                              childAspectRatio: 2.5),
                                      itemBuilder: (context, index) {
                                        double currentValue = 0;
                                        switch (index) {
                                          case 0:
                                            currentValue = 5;
                                            break;
                                          case 1:
                                            currentValue = 10;
                                            break;
                                          case 2:
                                            currentValue = 20;
                                            break;
                                          case 3:
                                            currentValue = 30;
                                            break;
                                          case 4:
                                            currentValue = 50;
                                            break;
                                          case 5:
                                            currentValue = 100;
                                            break;
                                        }

                                        //TODO: Implentar setting a futuro
                                        return _valueButton(index, currentValue,
                                            topUpProvider, mainProvider);
                                      },
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey.withOpacity(0.4),
                                  ),
                                  !topUpProvider.setAmountFromInput
                                      ? Center(
                                          child: Container(
                                            margin: const EdgeInsets.all(5),
                                            child: TextButton(
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .another_amount,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xffFFA66A)),
                                              ),
                                              onPressed: () {
                                                topUpProvider
                                                    .setAmountFromInputValue(
                                                        true);
                                              },
                                            ),
                                          ),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .another_amount,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          Color(0xffFFA66A))),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20, right: 20),
                                                    child: const Text("\$",
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            fontFamily:
                                                                "Comfortaa"))),
                                                SizedBox(
                                                  width: (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.55),
                                                  child: TextField(
                                                      controller: topUpProvider
                                                          .rechargeTotalInput,
                                                      keyboardType:
                                                          TextInputType.number),
                                                ),
                                                GestureDetector(
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 20, left: 15),
                                                    child: Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          fit: BoxFit.contain,
                                                          image: AssetImage(
                                                            images
                                                                .confirmRechargeAmountIcon,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    //TODO: implementar setting
                                                    // int minimumRechargeValue =
                                                    //     mainProvider
                                                    //         .cafeteriaSetting!
                                                    //         .minimunOpenPayRechargeValue;

                                                    int minimumRechargeValue =
                                                        5;

                                                    //TODO: implementar setting
                                                    // int chargeTotal = mainProvider
                                                    //         .cafeteriaSetting!
                                                    //         .chargeCommissionToParents
                                                    //     ? mainProvider
                                                    //         .cafeteriaSetting!
                                                    //         .chargeCommissionToParentsAmount
                                                    //     : 0;

                                                    int chargeTotal = 0;

                                                    if (topUpProvider
                                                            .rechargeTotalInput
                                                            .text
                                                            .isEmpty ||
                                                        topUpProvider
                                                                .rechargeTotalInput
                                                                .text ==
                                                            "." ||
                                                        topUpProvider
                                                                .rechargeTotalInput
                                                                .text ==
                                                            "-" ||
                                                        double.parse(topUpProvider
                                                                .rechargeTotalInput
                                                                .text) <
                                                            minimumRechargeValue) {
                                                      topUpProvider
                                                          .setInsertedAmountError(
                                                              true);
                                                    } else {
                                                      topUpProvider.setRechargeTotal(
                                                          double.parse(topUpProvider
                                                                  .rechargeTotalInput
                                                                  .text) +
                                                              chargeTotal);
                                                      topUpProvider
                                                          .setInsertedAmountError(
                                                              false);
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),

                                            //TODO: implementar setting
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 5, top: 20),
                                              child: Text(
                                                "*${AppLocalizations.of(context)!.minimum_recharge_amount} 5",
                                                style: const TextStyle(
                                                  color: colors.darkBlue,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 10.0,
                                                ),
                                              ),
                                            ),
                                            topUpProvider.insertedAmountError
                                                ? Center(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    20)),
                                                        color: colors.coral
                                                            .withOpacity(0.2),
                                                      ),
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 2),
                                                      child: Center(
                                                          child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .amount_not_valid,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "comfortaa",
                                                            fontSize: 13,
                                                            color:
                                                                colors.coral),
                                                      )),
                                                    ),
                                                  )
                                                : Container(),
                                            TextButton(
                                              child: Center(
                                                  child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .cancel_button,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              colors.coral))),
                                              onPressed: () {
                                                topUpProvider
                                                    .setAmountFromInputValue(
                                                        false);
                                                topUpProvider
                                                    .setInsertedAmountError(
                                                        false);
                                                topUpProvider
                                                    .setRechargeTotal(5);
                                              },
                                            ),
                                            const Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 10)),
                                          ],
                                        ),
                                ],
                              )),
                    ),
                  ),

                  //TODO: Selector de tarjeta
                  // Container(
                  //   padding: EdgeInsets.only(
                  //       left: 30,
                  //       top: MediaQuery.of(context).size.height * 0.02),
                  //   child: Text(
                  //     AppLocalizations.of(context)!.payment_method,
                  //     style: const TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 20,
                  //     ),
                  //   ),
                  // ),
                  // const SelectCardComponent(),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Image.asset(
                  //         images.croemLogo,
                  //         height: 40,
                  //         width: 120,
                  //       ),
                  //       Image.asset(images.supportLogo)
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                          top: 20, right: 20, left: 20, bottom: 20),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Consumer2<TopUpProvider, MainProvider>(
                          builder: (context, topUpProvider, mainProvider,
                                  widget) =>
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.subtotal,
                                        style: TextStyle(
                                          color: Colors.grey.withOpacity(0.5),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Text("\$${topUpProvider.rechargeTotal}",
                                          style: const TextStyle(
                                            color: colors.darkBlue,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Outfit",
                                            fontSize: 20.0,
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  // Divider(
                                  //   color: Colors.grey.withOpacity(0.3),
                                  // ),
                                  // Text(
                                  //   AppLocalizations.of(context)!.total_price,
                                  //   style: const TextStyle(
                                  //     color: colors.darkBlue,
                                  //     fontWeight: FontWeight.w600,
                                  //     fontSize: 12.0,
                                  //   ),
                                  // ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Text(
                                      //   "\$${topUpProvider.rechargeTotal}",
                                      //   style: const TextStyle(fontSize: 30),
                                      // ),
                                      _confirmButton(
                                          topUpProvider.rechargeTotal,
                                          mainProvider,
                                          context),
                                    ],
                                  ),
                                ],
                              )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Consumer<CardsCroemProvider>(
              builder: (context, cardsCroemProvider, widget) => CustomBanner(
                bannerType: cardsCroemProvider.balanceTopUpBannerType,
                bannerMessage: cardsCroemProvider.balanceTopUpBannerMessage,
                hideBanner: cardsCroemProvider.hideBalanceTopUpBanner,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _valueButton(int buttonId, double value, TopUpProvider topUpProvider,
      MainProvider mainProvider) {
    return ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black38),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: topUpProvider.buttonId == buttonId
                        ? const BorderSide(color: Color(0xffFFA66A))
                        : BorderSide(color: Colors.grey.withOpacity(0.3))))),
        onPressed: () {
          double chargeTotal = mainProvider
                  .cafeteriaSetting!.chargeCommissionToParents
              ? mainProvider.cafeteriaSetting!.chargeCommissionToParentsAmount
              : 0;
          topUpProvider.selectButton(buttonId);
          topUpProvider.setRechargeTotal(value + chargeTotal);
          topUpProvider.setInsertedAmountError(false);
        },
        child: Text("\$$value",
            style: TextStyle(
                fontSize: 14,
                color: topUpProvider.buttonId == buttonId
                    ? const Color(0xffFFA66A)
                    : Colors.black)));
  }

  Widget _confirmButton(
      double value, MainProvider mainProvider, BuildContext context) {
    return Consumer2<CardsInfoProvider, CardsCroemProvider>(
        builder: (context, cardsInfoProvider, cardsCroemProvider, widget) =>
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        router.panamaPaymentMethod
                      );

       
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: colors.tuitionGreen.withOpacity(0.2),
                      side: BorderSide(
                          color: colors.tuitionGreen.withOpacity(0.2)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
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
                              AppLocalizations.of(context)!.continuePayment,
                              style:
                                  const TextStyle(color: colors.tuitionGreen),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ));
  }
}
