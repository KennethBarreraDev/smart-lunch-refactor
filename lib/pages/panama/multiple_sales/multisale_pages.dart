import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/main_provider.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/CommentsModal.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multiple_sale_provider.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/MultisaleTabContent.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multisale_products_provider.dart';
import 'package:smart_lunch/pages/providers.dart';
import 'package:smart_lunch/pages/sales/sale/components/search_input.dart';
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;

class MultisalePage extends StatelessWidget {
  const MultisalePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MultisaleProvider multisaleProvider = Provider.of<MultisaleProvider>(
      context,
      listen: false,
    );

    MultisaleProductsProvider multisaleProductsProvider =
        Provider.of<MultisaleProductsProvider>(
      context,
      listen: false,
    );
    return PopScope(
      onPopInvoked: (value) {
        multisaleProductsProvider.resetInput();
        multisaleProvider.returnBalanceToUser();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 80),
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
                                size: 45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<MultisaleProvider>(
                      builder: (context, multisaleProvider, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: (multisaleProvider.selectedChild
                                                ?.imageUrl.isNotEmpty ??
                                            false)
                                        ? BoxFit.cover
                                        : BoxFit.contain,
                                    image: (multisaleProvider
                                                    .selectedChild?.imageUrl ??
                                                "")
                                            .isNotEmpty
                                        ? NetworkImage(
                                            (multisaleProvider
                                                    .selectedChild?.imageUrl ??
                                                ""),
                                          )
                                        : const AssetImage(
                                            images.defaultProfileStudentImage,
                                          ) as ImageProvider<Object>,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ("${multisaleProvider.selectedChild?.childName} ${multisaleProvider.selectedChild?.childLastName}" ??
                                        ""),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Comfortaa",
                                      fontSize: 20,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    (DateFormat(
                                            "EEEE',' d 'de' MMMM  'de' y", 'es')
                                        .format(multisaleProvider
                                            .selectedSaleDate.saleDate)
                                        .toString()),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Comfortaa",
                                      fontSize: 8,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.homePageStack,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Comfortaa",
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "\$${multisaleProvider.familyBalance.toString()}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Comfortaa",
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                  Divider(
                    color: Colors.white.withOpacity(0.3),
                  ),
                  Expanded(
                    child: Consumer5<HomeProvider, MultisaleProvider,
                        SaleProvider, MainProvider, MultisaleProductsProvider>(
                      builder: (context,
                              homeProvider,
                              multisaleProvider,
                              saleProvider,
                              mainProvider,
                              multisaleProductsProvider,
                              widget) =>
                          DefaultTabController(
                        length: multisaleProductsProvider.categories.length + 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: SearchProductInput(
                                  findProduct: (value) {
                                    multisaleProductsProvider.getProducts(
                                      mainProvider.accessToken,
                                      mainProvider.cafeteriaId,
                                      (homeProvider.cafeteria?.school.country ??
                                              "") ==
                                          Contries.panama,
                                      multisaleProvider
                                          .selectedSaleDate.saleDate,
                                    );
                                  },
                                  inputController:
                                      multisaleProductsProvider.productFilter),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          width: 24,
                                        ),
                                        Expanded(
                                          child: TabBar(
                                            indicatorColor:
                                                const Color(0xffffa66a),
                                            labelColor: Colors.white,
                                            unselectedLabelColor:
                                                Colors.white.withOpacity(0.25),
                                            labelPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            isScrollable: true,
                                            tabs: [
                                              const Tab(
                                                text: "Todos",
                                              ),
                                              ...multisaleProductsProvider
                                                  .categories
                                                  .map(
                                                    (category) => Tab(
                                                      text: category.name,
                                                    ),
                                                  )
                                                  .toList(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Expanded(
                                        child: TabBarView(
                                      children: [
                                        Consumer4<SaleProvider, MainProvider,
                                            HomeProvider, MultisaleProvider>(
                                          builder: (context,
                                                  presaleProvider,
                                                  mainProvider,
                                                  homeProvider,
                                                  multisaleProvider,
                                                  widget) =>
                                              RefreshIndicator(
                                            onRefresh: () async {
                                              multisaleProductsProvider
                                                  .getProducts(
                                                      mainProvider.accessToken,
                                                      mainProvider.cafeteriaId,
                                                      (homeProvider
                                                                  .cafeteria
                                                                  ?.school
                                                                  .country ??
                                                              "") ==
                                                          Contries.panama,
                                                      multisaleProvider
                                                          .selectedSaleDate
                                                          .saleDate,
                                                      omitFilters: false,
                                                      isPresale: true);
                                            },
                                            child: MultisaleTabContent(
                                              saleDate: multisaleProvider
                                                  .selectedSaleDate.saleDate,
                                              numberFormat:
                                                  mainProvider.numberFormat,
                                              cart: multisaleProvider
                                                  .selectedSaleDate.cart,
                                              products:
                                                  multisaleProductsProvider
                                                      .filterProducts(
                                                          multisaleProvider
                                                              .selectedChild,
                                                          multisaleProvider
                                                              .selectedSaleDate
                                                              .saleDate),
                                              addItem:
                                                  multisaleProvider.addItem,
                                              removeItem:
                                                  multisaleProvider.removeItem,
                                              balanceLimitStatus:
                                                  presaleProvider
                                                      .balanceLimitStatus,
                                              isPresale: true,
                                            ),
                                          ),
                                        ),
                                        ...multisaleProductsProvider.categories
                                            .map(
                                              (category) => Consumer2<
                                                  SaleProvider, MainProvider>(
                                                builder: (context,
                                                        presaleProvider,
                                                        mainProvider,
                                                        widget) =>
                                                    RefreshIndicator(
                                                  onRefresh: () async {
                                                    multisaleProductsProvider
                                                        .getProducts(
                                                            mainProvider
                                                                .accessToken,
                                                            mainProvider
                                                                .cafeteriaId,
                                                            (homeProvider
                                                                        .cafeteria
                                                                        ?.school
                                                                        .country ??
                                                                    "") ==
                                                                Contries.panama,
                                                            multisaleProvider
                                                                .selectedSaleDate
                                                                .saleDate,
                                                            omitFilters: false,
                                                            isPresale: true);
                                                  },
                                                  child: MultisaleTabContent(
                                                    saleDate: multisaleProvider
                                                        .selectedSaleDate
                                                        .saleDate,
                                                    numberFormat: mainProvider
                                                        .numberFormat,
                                                    cart: multisaleProvider
                                                            .selectedSaleDate
                                                            .cart ??
                                                        {},
                                                    products: multisaleProductsProvider
                                                        .getProductFromCategory(
                                                            category,
                                                            multisaleProvider
                                                                .selectedChild),
                                                    addItem:
                                                        presaleProvider.addItem,
                                                    removeItem: presaleProvider
                                                        .removeItem,
                                                    balanceLimitStatus:
                                                        presaleProvider
                                                            .balanceLimitStatus,
                                                    isPresale: true,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
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
                  ),
                ],
              ),
            ),
            Consumer<MultisaleProvider>(
              builder: (context, multisaleProvider, widget) => Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 80,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.subtotal,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Comfortaa",
                                  color: Colors.black26),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    style: const TextStyle(
                                        color: colors.darkBlue,
                                        fontSize: 20.0,
                                        fontFamily: "Outfit"),
                                    text:
                                        "\$${multisaleProvider.selectedSaleDate.totalPrice}",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<MultisaleProvider>(
                        builder: (context, multisaleProvider, child) {
                          return TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                useSafeArea: true,
                                builder: (BuildContext context) {
                                  return CommentsModal(controller: multisaleProvider.commentController, onTap: multisaleProvider.saveSaleComment,);
                                },
                              );
                            },
                            child: Row(
                              mainAxisSize:
                                  MainAxisSize.min, // Para evitar espacio adicional
                              children: [
                                const Icon(Icons.edit_note,
                                    color: colors.lightBlue),
                                const SizedBox(
                                    width:
                                        1), // Ajusta el espacio entre el icono y el texto
                                Text(
                                  AppLocalizations.of(context)!.comments_message,
                                  style: const TextStyle(
                                      color: colors.lightBlue, fontSize: 15),
                                ),
                              ],
                            ),
                          );
                        }
                      ),
                      GestureDetector(
                        onTap: () {
                          multisaleProvider.setCurrentSaleInfo(
                              multisaleProvider.selectedSaleDate.saleDate,
                              multisaleProvider.selectedSaleDate.cart ?? {},
                              multisaleProvider.selectedSaleDate.cartProducts ??
                                  [],
                              multisaleProvider.selectedSaleDate.totalPrice,
                              multisaleProvider.selectedSaleDate.totalProducts,
                              multisaleProvider.selectedSaleDate.selected,
                              multisaleProvider.selectedSaleDate.comment);
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: colors.tuitionGreen.withOpacity(0.2)),
                          child: Text(
                            AppLocalizations.of(context)!.confirm_button,
                            style: const TextStyle(
                                fontSize: 14, color: colors.tuitionGreen),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
