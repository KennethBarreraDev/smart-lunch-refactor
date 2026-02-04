import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/models/successful_sale_arguments.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:smart_lunch/pages/home/components/components.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/CommentsModal.dart';
import 'package:smart_lunch/pages/panama/summary_sale/components/selected_child_checkout.dart';
import 'package:smart_lunch/pages/sales/components/select_card_component.dart';
import 'package:smart_lunch/pages/sales/sale/components/card_item_summary.dart';
import 'package:smart_lunch/pages/sales/sale/sale_provider.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/custom_banner.dart';
import 'package:smart_lunch/widgets/product_summary_card/product_sumary_card.dart';

class PanamaPurchaseSummaryPage extends StatelessWidget {
  const PanamaPurchaseSummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(AppLocalizations.of(context)!.register_payment_method),
      backgroundColor: (const Color(0xffffa66a)),
      action: SnackBarAction(
        label: AppLocalizations.of(context)!.close_button,
        onPressed: () {},
      ),
    );
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
                                size: 30,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                AppLocalizations.of(context)!.finish_purchase,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SelectedChildCheckout(),
                  const SizedBox(
                    height: 15,
                  ),
                  Consumer2<MainProvider, SaleProvider>(
                    builder: (context, mainProvider, saleProvider, widget) =>
                        Center(
                      child: SizedBox(
                        height:
                            saleProvider.cartProducts.length == 1 ? 320 : 400,
                        width: 350,
                        child: ClipPath(
                            clipper: CustomCardClipper(),
                            child: Container(
                                height: 100,
                                width: 500,
                                alignment: Alignment.center,
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(top: 10)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text("Resumen de compra",
                                          style: TextStyle(
                                              color: Colors.grey
                                                  .withOpacity(0.5))),
                                    ),
                                    Divider(
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(top: 20)),
                                    Container(
                                      constraints: BoxConstraints(
                                        maxHeight: saleProvider
                                                    .cartProducts.length ==
                                                1
                                            ? 100
                                            : 200, // Establece la altura máxima a 200 píxeles
                                      ),
                                      child: ListView(
                                        shrinkWrap: false,
                                        padding: EdgeInsets.zero,
                                        children: saleProvider.cartProducts
                                            .map(
                                              (product) => CartItemSummary(
                                                productID: product.id,
                                                productImageUrl:
                                                    product.imageUrl,
                                                productName:
                                                    product.productName,
                                                amount: saleProvider
                                                        .cart[product.id] ??
                                                    0,
                                                price: product.price,
                                                numberFormat:
                                                    mainProvider.numberFormat,
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(top: 10)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    useSafeArea: true,
                                                    builder:
                                                        (BuildContext context) {
                                                      return CommentsModal(
                                                        controller: saleProvider
                                                            .saleCommentsController,
                                                        onTap: () => {},
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Icon(Icons.edit_note,
                                                        color:
                                                            colors.lightBlue),
                                                    const SizedBox(
                                                        width:
                                                            1), // Ajusta el espacio entre el icono y el texto
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .add_comment,
                                                      style: const TextStyle(
                                                          color:
                                                              colors.lightBlue,
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .comments_message,
                                            style: const TextStyle(
                                                color: colors.lightBlue,
                                                fontFamily: "Comfortaa"),
                                          ),
                                          Text(
                                            saleProvider.saleCommentsController
                                                    .text.isNotEmpty
                                                ? saleProvider
                                                    .saleCommentsController.text
                                                : "Sin comentarios",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Comfortaa"),
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.only(top: 7)),
                                        ],
                                      ),
                                    )
                                  ],
                                ))),
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
                      padding: const EdgeInsets.only(
                          top: 50, right: 20, left: 20, bottom: 60),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.total_price,
                            style: const TextStyle(
                              color: colors.darkBlue,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0,
                            ),
                          ),
                          Consumer3<SaleProvider, MainProvider,
                                  CardsInfoProvider>(
                              builder: (context, saleProvider, mainProvider,
                                      cardInfoProvider, widget) =>
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        saleProvider.totalPrice.toString(),
                                        style: const TextStyle(fontSize: 30),
                                      ),
                                      !saleProvider.isSellingProducts
                                          ? RoundedButton(
                                              color: colors.tuitionGreen,
                                              iconData:
                                                  Icons.credit_score_outlined,
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .buy_now,
                                              onTap: () {
                                                double totalPriceCopy =
                                                    saleProvider.totalPrice;
                                                saleProvider
                                                    .sellProducts(
                                                  mainProvider.accessToken,
                                                  mainProvider.cafeteriaId,
                                                  mainProvider.selectedChild
                                                          ?.userId ??
                                                      "",
                                                  mainProvider.userType ==
                                                          UserRole.tutor
                                                      ? false
                                                      : (mainProvider.userType ==
                                                                  UserRole
                                                                      .student &&
                                                              !mainProvider
                                                                  .selectedChild!
                                                                  .isIndependent)
                                                          ? false
                                                          : true,
                                                  (mainProvider.userType ==
                                                          UserRole.tutor)
                                                      ? ""
                                                      : (mainProvider.userType ==
                                                                  UserRole
                                                                      .student &&
                                                              mainProvider
                                                                  .selectedChild!
                                                                  .isIndependent)
                                                          ? cardInfoProvider
                                                                  .selectedCardForTopUp!
                                                                  .id ??
                                                              ""
                                                          : "",
                                                  (mainProvider.userType ==
                                                          UserRole.tutor)
                                                      ? mainProvider
                                                          .tutor!.openPayId
                                                      : mainProvider
                                                          .selectedChild!
                                                          .openpayId,
                                                  true,
                                                  AppLocalizations.of(context),
                                                )
                                                    .then(
                                                  (wasSaleSuccessful) {
                                                    if (wasSaleSuccessful) {
                                                      if (saleProvider
                                                              .saleType ==
                                                          "PS") {
                                                        Navigator.of(context)
                                                            .pushReplacementNamed(
                                                          router
                                                              .successfulPresaleSaleRoute,
                                                        );
                                                      } else {
                                                        Navigator.of(context)
                                                            .pushReplacementNamed(
                                                          router
                                                              .successfulSaleRoute,
                                                          arguments: SuccessfulSaleArguments(
                                                              total:
                                                                  totalPriceCopy,
                                                              folio: saleProvider
                                                                  .successfulSaleId,
                                                              saleDate: DateFormat("EEEE',' d 'de' MMMM  'de' y", 'es')
                                                                  .format(DateTime
                                                                      .now())
                                                                  .toString(),
                                                              scheduledDate: DateFormat("EEEE',' d 'de' MMMM  'de' y", 'es')
                                                                  .format(DateTime
                                                                      .now())
                                                                  .toString(),
                                                              paymentType:
                                                                  "Mercado pago",
                                                              mercadoPagoID:
                                                                  "5641561894846516546",
                                                              childName: mainProvider
                                                                  .selectedChild!
                                                                  .childName,
                                                              childLastName: mainProvider
                                                                  .selectedChild!
                                                                  .childLastName,
                                                              productsAmount:
                                                                  saleProvider
                                                                      .totalProductsCopy,
                                                              surchargeSaleType: mainProvider
                                                                  .cafeteriaSetting!
                                                                  .surchargeSaleType,
                                                              surchargeSaleAmount: mainProvider
                                                                  .cafeteriaSetting!
                                                                  .surchargeSaleAmount,
                                                              surchargeSaleActivated:
                                                                  mainProvider
                                                                      .cafeteriaSetting!
                                                                      .surchargeSale),
                                                        );
                                                      }
                                                    } else {}
                                                  },
                                                );
                                              },
                                            )
                                          : const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircularProgressIndicator(
                                                  color: colors.tuitionGreen,
                                                ),
                                              ],
                                            ),
                                    ],
                                  )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Consumer<SaleProvider>(
              builder: (context, saleProvider, widget) => CustomBanner(
                bannerType: saleProvider.saleBannerType,
                bannerMessage: saleProvider.saleBannerMessage,
                hideBanner: saleProvider.hideSaleTopUpBanner,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
