import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/models/successful_sale_arguments.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/home/components/components.dart';
import 'package:smart_lunch/pages/providers.dart';
import 'package:smart_lunch/pages/sales/sale/components/cart_item_tile.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/utils/roles.dart';

class CartSection extends StatelessWidget {
  const CartSection({super.key, required this.isPresale});

  final bool isPresale;

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );

    HomeProvider homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );

    CardsInfoProvider cardsInfoProvider = Provider.of<CardsInfoProvider>(
      context,
      listen: false,
    );

    CardsCroemProvider cardsCroemProvider = Provider.of<CardsCroemProvider>(
      context,
      listen: false,
    );

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 9,
          horizontal: 16,
        ),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Consumer<SaleProvider>(
          builder: (context, saleProvider, widget) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RotatedBox(
                quarterTurns: 3,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: const Color(0xFF323232).withOpacity(0.15),
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.order_message,
                    style: const TextStyle(
                      color: colors.orange,
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0,
                      fontFamily: "Comfortaa",
                    ),
                  ),
                  Text(
                    "${mainProvider.selectedChild?.childName} - ${DateFormat("dd/MM/yyyy").format(saleProvider.selectedDate)}",
                    style: TextStyle(
                      color: colors.orange.withOpacity(0.75),
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0,
                      fontFamily: "Comfortaa",
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: false,
                  padding: EdgeInsets.zero,
                  children: saleProvider.cartProducts
                      .map(
                        (product) => CartItemTile(
                          productID: product.id,
                          productImageUrl: product.imageUrl,
                          productName: product.productName,
                          amount: saleProvider.cart[product.id] ?? 0,
                          price: product.price,
                          numberFormat: mainProvider.numberFormat,
                        ),
                      )
                      .toList(),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: colors.orange.withOpacity(0.05),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(
                    color: colors.orange,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 12,
                ),
                margin: const EdgeInsets.only(
                  bottom: 24,
                  top: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      style: const TextStyle(
                        color: colors.darkBlue,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                      ),
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.comments_message,
                        hintText:
                            AppLocalizations.of(context)!.comments_message,
                      ),
                      controller: saleProvider.saleCommentsController,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    !(mainProvider.userType == UserRole.student &&
                            mainProvider.selectedChild!.isIndependent)
                        ? Row(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${AppLocalizations.of(context)!.available_balance}: ",
                                    style: TextStyle(
                                      color: colors.darkBlue.withOpacity(0.5),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10.0,
                                      fontFamily: "Comfortaa",
                                    ),
                                  ),
                                  // $1,217.00 MXN
                                  Consumer<HomeProvider>(
                                      builder: (context, homeProvider, child) {
                                    return Text(
                                      (double.parse(mainProvider
                                                      .familyBalance) -
                                                  mainProvider.totalDebt) <
                                              0
                                          ? " - \$${(double.parse(mainProvider.familyBalance) - mainProvider.totalDebt).abs()} ${(homeProvider.cafeteria?.school.country ?? "") == Contries.panama ? " USD" : " MXN"}"
                                          : "\$${(double.parse(mainProvider.familyBalance) - mainProvider.totalDebt).abs()} ${(homeProvider.cafeteria?.school.country ?? "") == Contries.panama ? " USD" : " MXN"}",
                                      style: TextStyle(
                                        color: colors.darkBlue.withOpacity(0.5),
                                        fontSize: 12.0,
                                        fontFamily: "Outfit",
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ],
                          )
                        : Container(),
                    const SizedBox(
                      height: 11,
                    ),
                    DottedLine(
                      dashColor: Colors.black.withOpacity(0.15),
                      dashLength: 6,
                      dashGapLength: 6,
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.total_price}: ",
                          style: const TextStyle(
                            color: colors.darkBlue,
                            fontWeight: FontWeight.w700,
                            fontSize: 24.0,
                            fontFamily: "Comfortaa",
                          ),
                        ),
                        Consumer<HomeProvider>(
                            builder: (context, homeProvider, child) {
                          return Text(
                            "\$${mainProvider.numberFormat.format(saleProvider.totalPrice)} ${((homeProvider.cafeteria?.school.country ?? "") == Contries.panama) ? " USD" : " MXN"}",
                            style: const TextStyle(
                              color: colors.darkBlue,
                              fontSize: 24.0,
                              fontFamily: "Outfit",
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              homeProvider.cafeteria?.school.country == Contries.panama
                  ? Container(
                      child: !saleProvider.isSellingProducts
                          ? Row(
                              children: [
                                Expanded(
                                  child: RoundedButton(
                                    color: colors.tuitionGreen,
                                    iconData: Icons.done,
                                    text: cardsCroemProvider.isLoadingCardList
                                        ? "${AppLocalizations.of(context)!.loading_message}..."
                                        : AppLocalizations.of(context)!
                                            .continuePayment,
                                    verticalPadding: 14,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    enabled: true,
                                    onTap: () async {
                                      if (!cardsCroemProvider
                                          .isLoadingCardList) {
                                        if (cardsCroemProvider.cards.isEmpty) {
                                          await cardsCroemProvider.getCardList(
                                              mainProvider.accessToken,
                                              mainProvider.cafeteriaId);
                                        }
                                      }

                                      if (!isPresale) {
                                        var hours = Duration(
                                                hours: DateTime.now().hour,
                                                minutes: DateTime.now().minute)
                                            .toString()
                                            .split(":");
                                        saleProvider.timeScheduled = DateFormat(
                                                "dd/MM/yyyy HH:mm")
                                            .parse(DateFormat(
                                                    "dd/MM/yyyy HH:mm")
                                                .format(DateTime.now().add(
                                                    Duration(
                                                        hours:
                                                            int.parse(hours[0]),
                                                        minutes: int.parse(
                                                            hours[1].split(
                                                                " ")[0]))))
                                                .toString());
                                      }

                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                        router.panamaSummarySale,
                                      );
                                    },
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
                    )
                  : Container(
                      child: !saleProvider.isSellingProducts
                          ? Row(
                              children: [
                                Expanded(
                                  child: RoundedButton(
                                    color: colors.tuitionGreen,
                                    iconData: Icons.done,
                                    text: cardsInfoProvider.loadingCards
                                        ? "${AppLocalizations.of(context)!.loading_message}..."
                                        : AppLocalizations.of(context)!
                                            .select_payment_method,
                                    verticalPadding: 14,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    enabled: true,
                                    onTap: () async {
                                      saleProvider
                                          .changePayWithCardOption(true);
                                      if (!cardsInfoProvider.loadingCards) {
                                        if (cardsInfoProvider.cards.isEmpty) {
                                          await cardsInfoProvider.getCardList(
                                              mainProvider.accessToken,
                                              mainProvider.cafeteriaId);
                                        }
                                      }

                                      if ((!isPresale &&
                                          (mainProvider.selectedChild
                                                      ?.isIndependent ??
                                                  false) ==
                                              false) || (!isPresale || mainProvider.userType==UserRole.tutor)) {
                                        saleProvider.timeScheduled =
                                            saleProvider.timeScheduled =
                                                DateFormat("dd/MM/yyyy HH:mm")
                                                    .parse(DateFormat(
                                                            "dd/MM/yyyy HH:mm")
                                                        .format(
                                                            DateTime.now()));
                                      } else if (!isPresale &&
                                          (mainProvider.selectedChild
                                                      ?.isIndependent ??
                                                  false) ==
                                              true) {
                                        var hours = saleProvider.scheduledHour
                                            .split(":");
                                        saleProvider.timeScheduled = DateFormat(
                                                "dd/MM/yyyy HH:mm")
                                            .parse(DateFormat(
                                                    "dd/MM/yyyy HH:mm")
                                                .format(DateTime.now().add(
                                                    Duration(
                                                        hours:
                                                            int.parse(hours[0]),
                                                        minutes: int.parse(
                                                            hours[1].split(
                                                                " ")[0]))))
                                                .toString());
                                      }

                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                        router.purchaseSummary,
                                      );
                                    },
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
                    )

              // Container(
              //     child: !saleProvider.isSellingProducts
              //         ? Row(
              //             children: [
              //               Expanded(
              //                 child: RoundedButton(
              //                   color: colors.tuitionGreen,
              //                   iconData: Icons.done,
              //                   text: AppLocalizations.of(context)!
              //                       .buy_now,
              //                   verticalPadding: 14,
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.center,
              //                   enabled: (double.tryParse(mainProvider
              //                               .familyBalance) ??
              //                           0) >=
              //                       saleProvider.totalPrice,
              //                   onTap: () {
              //                     double totalPriceCopy =
              //                         saleProvider.totalPrice;
              //                     saleProvider
              //                         .sellProducts(
              //                       mainProvider.accessToken,
              //                       mainProvider.cafeteriaId,
              //                       mainProvider
              //                               .selectedChild?.userId ??
              //                           "",
              //                       mainProvider.userType ==
              //                               UserRole.tutor
              //                           ? false
              //                           : (mainProvider.userType ==
              //                                       UserRole.student &&
              //                                   !mainProvider
              //                                       .selectedChild!
              //                                       .isIndependent)
              //                               ? false
              //                               : true,
              //                       (mainProvider.userType ==
              //                               UserRole.tutor)
              //                           ? ""
              //                           : (mainProvider.userType ==
              //                                       UserRole.student &&
              //                                   mainProvider
              //                                       .selectedChild!
              //                                       .isIndependent)
              //                               ? cardsInfoProvider
              //                                       .selectedCardForTopUp!
              //                                       .id ??
              //                                   ""
              //                               : "",
              //                       (mainProvider.userType ==
              //                               UserRole.tutor)
              //                           ? mainProvider.tutor!.openPayId
              //                           : mainProvider
              //                               .selectedChild!.openpayId,
              //                       AppLocalizations.of(context),
              //                     )
              //                         .then(
              //                       (wasSaleSuccessful) {
              //                         if (wasSaleSuccessful) {
              //                           if (isPresale) {
              //                             Navigator.of(context)
              //                                 .pushReplacementNamed(
              //                               router
              //                                   .successfulPresaleSaleRoute,
              //                             );
              //                           } else {
              //                             Navigator.of(context)
              //                                 .pushReplacementNamed(
              //                               router.successfulSaleRoute,
              //                               arguments: SuccessfulSaleArguments(
              //                                   total: totalPriceCopy,
              //                                   folio: saleProvider
              //                                       .successfulSaleId,
              //                                   saleDate: DateFormat("EEEE',' d 'de' MMMM  'de' y", 'es')
              //                                       .format(
              //                                           DateTime.now())
              //                                       .toString(),
              //                                   scheduledDate: DateFormat("EEEE',' d 'de' MMMM  'de' y", 'es')
              //                                       .format(
              //                                           DateTime.now())
              //                                       .toString(),
              //                                   paymentType:
              //                                       "Mercado pago",
              //                                   mercadoPagoID:
              //                                       "5641561894846516546",
              //                                   childName: mainProvider
              //                                       .selectedChild!
              //                                       .childName,
              //                                   childLastName:
              //                                       mainProvider
              //                                           .selectedChild!
              //                                           .childLastName,
              //                                   productsAmount: saleProvider
              //                                       .totalProductsCopy,
              //                                   surchargeSaleType:
              //                                       mainProvider
              //                                           .cafeteriaSetting!
              //                                           .surchargeSaleType,
              //                                   surchargeSaleAmount:
              //                                       mainProvider
              //                                           .cafeteriaSetting!
              //                                           .surchargeSaleAmount,
              //                                   surchargeSaleActivated:
              //                                       mainProvider
              //                                           .cafeteriaSetting!
              //                                           .surchargeSale),
              //                             );
              //                           }
              //                         } else {
              //                           Navigator.pop(context);
              //                         }
              //                       },
              //                     );
              //                   },
              //                 ),
              //               ),
              //             ],
              //           )
              //         : const Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               CircularProgressIndicator(
              //                 color: colors.tuitionGreen,
              //               ),
              //             ],
              //           ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
