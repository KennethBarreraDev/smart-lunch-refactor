import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/pages/home/components/components.dart';
import 'package:smart_lunch/pages/top_up_mercado_pago/top_up_provider.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/l10n/app_localizations.dart';

class TopUpPage extends StatelessWidget {
  const TopUpPage({Key? key}) : super(key: key);

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

    topUpProvider.setRechargeTotal(mainProvider
            .cafeteriaSetting!.minimumRechargeEnabled
        ? mainProvider.cafeteriaSetting!.minimumRechargeAmount.toDouble()
        : mainProvider.cafeteriaSetting!.minimumRechargeNoCommission
            ? mainProvider.cafeteriaSetting!.minimumRechargeNoCommissionAmount
                .toDouble()
            : 50);

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
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.chevron_left,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                "Recargar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
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
                        top: MediaQuery.of(context).size.height * 0.004),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Text(
                                "Saldo actual",
                                style: TextStyle(
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
                                          fontSize: 30,
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
                    padding: const EdgeInsets.only(left: 30, top: 10),
                    child: const Text(
                      "Cantidad",
                      style: TextStyle(
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
                                  const Text(
                                    "Sugerido",
                                    style: TextStyle(
                                      color: Color(0xffFFA66A),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _valueButton(
                                          1, 100, topUpProvider, mainProvider),
                                      _valueButton(
                                          2, 150, topUpProvider, mainProvider),
                                      _valueButton(
                                          3, 200, topUpProvider, mainProvider),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _valueButton(
                                          4, 300, topUpProvider, mainProvider),
                                      _valueButton(
                                          5, 500, topUpProvider, mainProvider),
                                      _valueButton(
                                          6, 1000, topUpProvider, mainProvider),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey.withOpacity(0.4),
                                  ),
                                  !topUpProvider.setAmountFromInput
                                      ? Center(
                                          child: Container(
                                            margin: const EdgeInsets.all(5),
                                            child: TextButton(
                                              child: const Text(
                                                'Otra cantidad',
                                                style: TextStyle(
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
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.0),
                                              child: Text('Otra cantidad',
                                                  style: TextStyle(
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
                                                    int minimumRechargeValue = mainProvider
                                                            .cafeteriaSetting!
                                                            .minimumRechargeEnabled
                                                        ? mainProvider
                                                            .cafeteriaSetting!
                                                            .minimumRechargeAmount
                                                        : mainProvider
                                                                .cafeteriaSetting!
                                                                .minimumRechargeNoCommission
                                                            ? mainProvider
                                                                .cafeteriaSetting!
                                                                .minimumRechargeNoCommissionAmount
                                                            : 50;

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
                                                      topUpProvider
                                                          .setRechargeTotal(
                                                              double.parse(
                                                                  topUpProvider
                                                                      .rechargeTotalInput
                                                                      .text));
                                                      topUpProvider
                                                          .setInsertedAmountError(
                                                              false);
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 5, top: 20),
                                              child: mainProvider
                                                      .cafeteriaSetting!
                                                      .minimumRechargeEnabled
                                                  ? Text(
                                                      "* La cantidad miníma de recarga es de ${mainProvider.cafeteriaSetting!.minimumRechargeAmount}",
                                                      style: const TextStyle(
                                                        color: colors.darkBlue,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 10.0,
                                                      ),
                                                    )
                                                  : mainProvider
                                                          .cafeteriaSetting!
                                                          .minimumRechargeNoCommission
                                                      ? Text(
                                                          "* La cantidad miníma de recarga es de ${mainProvider.cafeteriaSetting!.minimumRechargeNoCommissionAmount}",
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                colors.darkBlue,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 10.0,
                                                          ),
                                                        )
                                                      : const Text(
                                                          "* La cantidad miníma de recarga es de 50",
                                                          style: TextStyle(
                                                            color:
                                                                colors.darkBlue,
                                                            fontWeight:
                                                                FontWeight.w600,
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
                                                      child: const Center(
                                                          child: Text(
                                                        "La cantidad ingresada no es valida",
                                                        style: TextStyle(
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
                                              child: const Center(
                                                  child: Text('Cancelar',
                                                      style: TextStyle(
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
                                                    .setRechargeTotal(100);
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
                  Container(
                    padding: EdgeInsets.only(left: 30, top: 10),
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
                      padding: const EdgeInsets.only(
                          top: 10, right: 20, left: 20, bottom: 10),
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
                                        "Subtotal",
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
                                            fontSize: 16.0,
                                          )),
                                    ],
                                  ),
                                  mainProvider.cafeteriaSetting!
                                          .chargeCommissionToParents
                                      ? Column(
                                          children: [
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Cargo por servicio",
                                                  style: TextStyle(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                                Text(
                                                  "\$${(((((topUpProvider.rechargeTotal + (mainProvider.cafeteriaSetting?.chargeCommissionToParentsAmount ?? 0.0)) / 0.959516) - topUpProvider.rechargeTotal) * 100).floor() / 100).toStringAsFixed(2)}",
                                                  style: const TextStyle(
                                                    color: colors.darkBlue,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Divider(
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.total_price,
                                    style: const TextStyle(
                                      color: colors.darkBlue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$${(((topUpProvider.rechargeTotal + (((topUpProvider.rechargeTotal + (mainProvider.cafeteriaSetting?.chargeCommissionToParentsAmount ?? 0.0)) / 0.959516) - topUpProvider.rechargeTotal)) * 100).floor() / 100).toStringAsFixed(2)}",
                                        style: const TextStyle(fontSize: 30),
                                      ),
                                      _confirmButton(
                                          "Confirmar",
                                          mainProvider.tutor!.userId,
                                          mainProvider.accessToken,
                                          mainProvider.cafeteriaId,
                                          topUpProvider,
                                          context),
                                    ],
                                  ),
                                ],
                              )),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 250,
                        height: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(
                              images.mercadoPagoLogo,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
          topUpProvider.selectButton(buttonId);
          topUpProvider.setRechargeTotal(value);
          topUpProvider.setInsertedAmountError(false);
        },
        child: Text("\$$value",
            style: TextStyle(
                fontSize: 14,
                color: topUpProvider.buttonId == buttonId
                    ? const Color(0xffFFA66A)
                    : Colors.black)));
  }

  Widget _confirmButton(String value, String tutorId, String token,
      String cafeteriaId, TopUpProvider topUpProvider, BuildContext context) {
    return RoundedButton(
      color: colors.tuitionGreen,
      iconData: Icons.credit_score_outlined,
      text: "Confirmar",
      onTap: () async {
        String mercadoPagoReference = await topUpProvider.recharge(
            token, cafeteriaId, tutorId, topUpProvider.rechargeTotal);
        // ignore: use_build_context_synchronously
        launchURL(context, mercadoPagoReference);
      },
    );
  }

  void launchURL(BuildContext context, String url) async {
    try {
      final theme = Theme.of(context);
      try {
        await launchUrl(
          Uri.parse(url),
          customTabsOptions: CustomTabsOptions(
            colorSchemes: CustomTabsColorSchemes.defaults(
              toolbarColor: theme.colorScheme.surface,
              navigationBarColor: theme.colorScheme.surface,
            ),
            shareState: CustomTabsShareState.on,
            urlBarHidingEnabled: true,
            showTitle: true,
          ),
          safariVCOptions: SafariViewControllerOptions(
            preferredBarTintColor: theme.colorScheme.surface,
            preferredControlTintColor: theme.colorScheme.onSurface,
            barCollapsingEnabled: true,
            entersReaderIfAvailable: false,
          ),
        );
      } catch (e) {
        // An exception is thrown if browser app is not installed on Android device.
        debugPrint(e.toString());
      }
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}
