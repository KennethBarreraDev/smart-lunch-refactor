import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/models/child_model.dart';
import 'package:smart_lunch/models/sale_page_arguments.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/pages/home/time_provider.dart';
import 'package:smart_lunch/pages/home/components/components.dart';
import 'package:smart_lunch/pages/sales/sale/components/cart_section.dart';
import 'package:smart_lunch/pages/sales/sale/components/sale_tab_content.dart';
import 'package:smart_lunch/pages/sales/sale/sale_provider.dart';
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/custom_banner.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';
import 'package:smart_lunch/routes/router.dart' as router;

class SalePage extends StatelessWidget {
  const SalePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SaleProvider saleProvider = Provider.of<SaleProvider>(
      context,
      listen: false,
    );

    ProductsProvider productsProvider = Provider.of<ProductsProvider>(
      context,
      listen: false,
    );

    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );

    TimeProvider timeProvider = Provider.of<TimeProvider>(
      context,
      listen: true,
    );

    CardsInfoProvider cardsInfoProvider = Provider.of<CardsInfoProvider>(
      context,
      listen: false,
    );

    HomeProvider homeProvider = Provider.of<HomeProvider>(
      context,
      listen: true,
    );

    CardsCroemProvider cardsCroemProvider = Provider.of<CardsCroemProvider>(
      context,
      listen: false,
    );

    SalePageArguments salePageArguments =
        ModalRoute.of(context)?.settings.arguments as SalePageArguments;
    DateTime currentDate = DateTime.now();

    if (salePageArguments.isPresale == false) {
      saleProvider.updateSaleDate(currentDate, salePageArguments.isPresale);
    }

    return TransparentScaffold(
      selectedOption: "Inicio",
      showDrawer: false,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomAppBar(
                      height: 260,
                      showPageTitle: true,
                      pageTitle: salePageArguments.isPresale
                          ? AppLocalizations.of(context)!.presale
                          : AppLocalizations.of(context)!.sale,
                      image: images.appBarShortImg,
                      titleAlignment: Alignment.centerLeft,
                      showDrawer: false,
                    ),
                    Container(
                      color: const Color(0xFFf6f6f7),
                      height: salePageArguments.isPresale ? 120 : 95,
                    ),
                    Expanded(
                      child: Consumer3<ProductsProvider, SaleProvider,
                          MainProvider>(
                        builder: (context, productsProvider, saleProvider,
                                mainProvider, widget) =>
                            DefaultTabController(
                          length: productsProvider.categories.length + 1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ColoredBox(
                                        color: colors.white,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .menu,
                                              style: const TextStyle(
                                                color: Color(0xffffa66a),
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Comfortaa",
                                                fontSize: 24.0,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 24,
                                            ),
                                            Expanded(
                                              child: TabBar(
                                                indicatorColor:
                                                    const Color(0xffffa66a),
                                                labelColor:
                                                    const Color(0xff413931),
                                                unselectedLabelColor:
                                                    const Color(0xff413931)
                                                        .withOpacity(0.25),
                                                labelPadding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                isScrollable: true,
                                                tabs: [
                                                  const Tab(
                                                    text: "Todos",
                                                  ),
                                                  ...productsProvider.categories
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
                                      ),
                                      // Container(
                                      //     color: Colors.white,
                                      //   child: const Padding(
                                      //     padding: EdgeInsets.only(top: 10),
                                      //     child: ColoredBox(
                                      //       color: Colors.white,
                                      //       child: SearchProductInput(),
                                      //     ),
                                      //   ),
                                      // ),
                                      const SizedBox(
                                        height: 12,
                                      ),

                                      productsProvider.gettingNewProducts
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.orange,
                                              ),
                                            )
                                          : Expanded(
                                              child: (salePageArguments
                                                          .isPresale &&
                                                      (saleProvider.selectedDate
                                                                      .year ==
                                                                  currentDate
                                                                      .year &&
                                                              saleProvider
                                                                      .selectedDate
                                                                      .month ==
                                                                  currentDate
                                                                      .month &&
                                                              saleProvider
                                                                      .selectedDate
                                                                      .day ==
                                                                  currentDate
                                                                      .day) ==
                                                          false)
                                                  ? TabBarView(
                                                      children: [
                                                        Consumer2<SaleProvider,
                                                            MainProvider>(
                                                          builder: (context,
                                                                  presaleProvider,
                                                                  mainProvider,
                                                                  widget) =>
                                                              RefreshIndicator(
                                                            onRefresh:
                                                                () async {
                                                              productsProvider.getProducts(
                                                                  mainProvider
                                                                      .accessToken,
                                                                  mainProvider
                                                                      .cafeteriaId,
                                                                  (homeProvider.cafeteria?.school
                                                                              .country ??
                                                                          "") ==
                                                                      Contries
                                                                          .panama,
                                                                  omitFilters:
                                                                      false,
                                                                  isPresale:
                                                                      salePageArguments
                                                                          .isPresale,
                                                                  replaceDate:
                                                                      saleProvider
                                                                          .selectedDate);
                                                            },
                                                            child:
                                                                SaleTabContent(
                                                              numberFormat:
                                                                  mainProvider
                                                                      .numberFormat,
                                                              cart:
                                                                  presaleProvider
                                                                      .cart,
                                                              products: productsProvider
                                                                  .filterProducts(
                                                                      mainProvider
                                                                          .selectedChild),
                                                              addItem:
                                                                  presaleProvider
                                                                      .addItem,
                                                              removeItem:
                                                                  presaleProvider
                                                                      .removeItem,
                                                              balanceLimitStatus:
                                                                  presaleProvider
                                                                      .balanceLimitStatus,
                                                              isPresale:
                                                                  salePageArguments
                                                                      .isPresale,
                                                            ),
                                                          ),
                                                        ),
                                                        ...productsProvider
                                                            .categories
                                                            .map(
                                                              (category) => Consumer2<
                                                                  SaleProvider,
                                                                  MainProvider>(
                                                                builder: (context,
                                                                        presaleProvider,
                                                                        mainProvider,
                                                                        widget) =>
                                                                    RefreshIndicator(
                                                                  onRefresh:
                                                                      () async {
                                                                    productsProvider.getProducts(
                                                                        mainProvider
                                                                            .accessToken,
                                                                        mainProvider
                                                                            .cafeteriaId,
                                                                        (homeProvider.cafeteria?.school.country ??
                                                                                "") ==
                                                                            Contries
                                                                                .panama,
                                                                        omitFilters:
                                                                            false,
                                                                        isPresale:
                                                                            salePageArguments
                                                                                .isPresale,
                                                                        replaceDate:
                                                                            saleProvider.selectedDate);
                                                                  },
                                                                  child:
                                                                      SaleTabContent(
                                                                    numberFormat:
                                                                        mainProvider
                                                                            .numberFormat,
                                                                    cart: presaleProvider
                                                                        .cart,
                                                                    products: productsProvider.getProductFromCategory(
                                                                        category,
                                                                        mainProvider
                                                                            .selectedChild),
                                                                    addItem:
                                                                        presaleProvider
                                                                            .addItem,
                                                                    removeItem:
                                                                        presaleProvider
                                                                            .removeItem,
                                                                    balanceLimitStatus:
                                                                        presaleProvider
                                                                            .balanceLimitStatus,
                                                                    isPresale:
                                                                        salePageArguments
                                                                            .isPresale,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                            .toList(),
                                                      ],
                                                    )
                                                  : (salePageArguments
                                                              .isPresale ==
                                                          false)
                                                      ? TabBarView(
                                                          children: [
                                                            Consumer2<
                                                                SaleProvider,
                                                                MainProvider>(
                                                              builder: (context,
                                                                      presaleProvider,
                                                                      mainProvider,
                                                                      widget) =>
                                                                  RefreshIndicator(
                                                                onRefresh:
                                                                    () async {
                                                                  productsProvider.getProducts(
                                                                      mainProvider
                                                                          .accessToken,
                                                                      mainProvider
                                                                          .cafeteriaId,
                                                                      (homeProvider.cafeteria?.school.country ??
                                                                              "") ==
                                                                          Contries
                                                                              .panama,
                                                                      omitFilters:
                                                                          false,
                                                                      isPresale:
                                                                          salePageArguments
                                                                              .isPresale,
                                                                      replaceDate:
                                                                          saleProvider
                                                                              .selectedDate);
                                                                },
                                                                child:
                                                                    SaleTabContent(
                                                                  numberFormat:
                                                                      mainProvider
                                                                          .numberFormat,
                                                                  cart:
                                                                      presaleProvider
                                                                          .cart,
                                                                  products: productsProvider
                                                                      .filterProducts(
                                                                          mainProvider
                                                                              .selectedChild),
                                                                  addItem:
                                                                      presaleProvider
                                                                          .addItem,
                                                                  removeItem:
                                                                      presaleProvider
                                                                          .removeItem,
                                                                  balanceLimitStatus:
                                                                      presaleProvider
                                                                          .balanceLimitStatus,
                                                                  isPresale:
                                                                      salePageArguments
                                                                          .isPresale,
                                                                ),
                                                              ),
                                                            ),
                                                            ...productsProvider
                                                                .categories
                                                                .map(
                                                                  (category) =>
                                                                      Consumer2<
                                                                          SaleProvider,
                                                                          MainProvider>(
                                                                    builder: (context,
                                                                            presaleProvider,
                                                                            mainProvider,
                                                                            widget) =>
                                                                        RefreshIndicator(
                                                                      onRefresh:
                                                                          () async {
                                                                        productsProvider.getProducts(
                                                                            mainProvider
                                                                                .accessToken,
                                                                            mainProvider
                                                                                .cafeteriaId,
                                                                            (homeProvider.cafeteria?.school.country ?? "") ==
                                                                                Contries.panama,
                                                                            omitFilters: false,
                                                                            isPresale: salePageArguments.isPresale,
                                                                            replaceDate: saleProvider.selectedDate);
                                                                      },
                                                                      child:
                                                                          SaleTabContent(
                                                                        numberFormat:
                                                                            mainProvider.numberFormat,
                                                                        cart: presaleProvider
                                                                            .cart,
                                                                        products: productsProvider.getProductFromCategory(
                                                                            category,
                                                                            mainProvider.selectedChild),
                                                                        addItem:
                                                                            presaleProvider.addItem,
                                                                        removeItem:
                                                                            presaleProvider.removeItem,
                                                                        balanceLimitStatus:
                                                                            presaleProvider.balanceLimitStatus,
                                                                        isPresale:
                                                                            salePageArguments.isPresale,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                          ],
                                                        )
                                                      : SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                width: 200,
                                                                height: 200,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  image:
                                                                      DecorationImage(
                                                                    fit: BoxFit
                                                                        .contain,
                                                                    image:
                                                                        AssetImage(
                                                                      images
                                                                          .pickSaleDateLogo,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Center(
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .select_delivery_date,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.6),
                                                                    fontSize:
                                                                        20,
                                                                    fontFamily:
                                                                        "Comfortaa",
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              Consumer<SaleProvider>(
                                builder: (context, saleProvider, widget) =>
                                    Container(
                                  height: 100,
                                  color: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Consumer<SaleProvider>(
                                        builder:
                                            (context, saleProvider, widget) =>
                                                Container(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: Column(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .total_price,
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
                                                          color:
                                                              colors.darkBlue,
                                                          fontSize: 20.0,
                                                          fontFamily: "Outfit"),
                                                      text:
                                                          "\$${saleProvider.totalPrice}",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 220,
                                        child: Consumer<MainProvider>(builder:
                                            (context, mainProvider, widget) {
                                          return saleProvider.validatingBalance
                                              ? RoundedButton(
                                                  color: colors.orange,
                                                  iconData: Icons.shopping_cart,
                                                  text:
                                                      "${AppLocalizations.of(context)!.verifying_message}...",
                                                  verticalPadding: 14,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  enabled: saleProvider
                                                      .cartProducts.isNotEmpty,
                                                  onTap: () async {},
                                                )
                                              : RoundedButton(
                                                  color: colors.orange,
                                                  iconData: Icons.shopping_cart,
                                                  text:
                                                      "${AppLocalizations.of(context)!.view_cart} ( ${saleProvider.totalProducts} )",
                                                  verticalPadding: 14,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  enabled: saleProvider
                                                      .cartProducts.isNotEmpty,
                                                  onTap: () async {
                                                    saleProvider
                                                        .changeValidateBalanceValue(
                                                            true);

                                                    await saleProvider
                                                        .getCurrentBalance(
                                                            mainProvider
                                                                .userType);

                                                    if (!salePageArguments
                                                            .isPresale &&
                                                        ((mainProvider.userType ==
                                                                    UserRole
                                                                        .teacher ||
                                                                (mainProvider
                                                                            .userType ==
                                                                        UserRole
                                                                            .student &&
                                                                    mainProvider
                                                                        .selectedChild!
                                                                        .isIndependent)) &&
                                                            (saleProvider
                                                                    .scheduledHour
                                                                    .isEmpty ||
                                                                saleProvider
                                                                        .scheduledHour ==
                                                                    "Seleccione una hora"))) {
                                                      saleProvider
                                                          .changeValidateBalanceValue(
                                                              false);
                                                      final snackBar = SnackBar(
                                                        elevation: 0,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        content:
                                                            AwesomeSnackbarContent(
                                                          title: AppLocalizations
                                                                  .of(context)!
                                                              .please_wait,
                                                          message: AppLocalizations
                                                                  .of(context)!
                                                              .must_select_pickup_date,

                                                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                          contentType:
                                                              ContentType
                                                                  .warning,
                                                        ),
                                                      );

                                                      // ignore: use_build_context_synchronously
                                                      ScaffoldMessenger.of(
                                                          context)
                                                        ..hideCurrentSnackBar()
                                                        ..showSnackBar(
                                                            snackBar);
                                                    } else if (mainProvider
                                                                .userType ==
                                                            UserRole.teacher ||
                                                        (mainProvider
                                                                    .userType ==
                                                                UserRole
                                                                    .student &&
                                                            mainProvider
                                                                .selectedChild!
                                                                .isIndependent) ||
                                                        saleProvider
                                                                .balanceLimitReached ==
                                                            false) {
                                                      saleProvider
                                                          .changeValidateBalanceValue(
                                                              false);
                                                      saleProvider
                                                          .updateSaleType(
                                                        salePageArguments
                                                                .isPresale
                                                            ? "PS"
                                                            : "MO",
                                                      );

                                                      if (homeProvider
                                                              .cafeteria
                                                              ?.school
                                                              .country ==
                                                          Contries.panama) {
                                                        if (!cardsCroemProvider
                                                            .isLoadingCardList) {
                                                          if (cardsCroemProvider
                                                              .cards.isEmpty) {
                                                            await cardsCroemProvider
                                                                .getCardList(
                                                                    mainProvider
                                                                        .accessToken,
                                                                    mainProvider
                                                                        .cafeteriaId);
                                                          }
                                                        }

                                                        if (!salePageArguments
                                                            .isPresale) {
                                                          var hours = Duration(
                                                                  hours: DateTime
                                                                          .now()
                                                                      .hour,
                                                                  minutes: DateTime
                                                                          .now()
                                                                      .minute)
                                                              .toString()
                                                              .split(":");
                                                          saleProvider
                                                              .timeScheduled = DateFormat(
                                                                  "dd/MM/yyyy HH:mm")
                                                              .parse(DateFormat(
                                                                      "dd/MM/yyyy HH:mm")
                                                                  .format(DateTime
                                                                          .now()
                                                                      .add(Duration(
                                                                          hours:
                                                                              int.parse(hours[0]),
                                                                          minutes: int.parse(hours[1].split(" ")[0]))))
                                                                  .toString());
                                                        }

                                                        saleProvider
                                                            .saleCommentsController
                                                            .clear();
                                                        Navigator.of(context)
                                                            .pushReplacementNamed(
                                                          router
                                                              .panamaSummarySale,
                                                        );
                                                      } else {
                                                        saleProvider
                                                            .changePayWithCardOption(
                                                                true);
                                                        if (!cardsInfoProvider
                                                            .loadingCards) {
                                                          if (cardsInfoProvider
                                                              .cards.isEmpty) {
                                                            await cardsInfoProvider
                                                                .getCardList(
                                                                    mainProvider
                                                                        .accessToken,
                                                                    mainProvider
                                                                        .cafeteriaId);
                                                          }
                                                        }

                                                        if ((!salePageArguments
                                                                    .isPresale &&
                                                                (mainProvider
                                                                            .selectedChild
                                                                            ?.isIndependent ??
                                                                        false) ==
                                                                    false) ||
                                                            (!salePageArguments
                                                                    .isPresale ||
                                                                mainProvider
                                                                        .userType ==
                                                                    UserRole
                                                                        .tutor)) {
                                                          saleProvider.timeScheduled = saleProvider
                                                              .timeScheduled = DateFormat(
                                                                  "dd/MM/yyyy HH:mm")
                                                              .parse(DateFormat(
                                                                      "dd/MM/yyyy HH:mm")
                                                                  .format(DateTime
                                                                      .now()));
                                                        } else if (!salePageArguments
                                                                .isPresale &&
                                                            (mainProvider
                                                                        .selectedChild
                                                                        ?.isIndependent ??
                                                                    false) ==
                                                                true) {
                                                          var hours =
                                                              saleProvider
                                                                  .scheduledHour
                                                                  .split(":");
                                                          saleProvider
                                                              .timeScheduled = DateFormat(
                                                                  "dd/MM/yyyy HH:mm")
                                                              .parse(DateFormat(
                                                                      "dd/MM/yyyy HH:mm")
                                                                  .format(DateTime
                                                                          .now()
                                                                      .add(Duration(
                                                                          hours:
                                                                              int.parse(hours[0]),
                                                                          minutes: int.parse(hours[1].split(" ")[0]))))
                                                                  .toString());
                                                        }
                                                        saleProvider
                                                            .saleCommentsController
                                                            .clear();
                                                        Navigator.of(context)
                                                            .pushReplacementNamed(
                                                          router
                                                              .purchaseSummary,
                                                        );
                                                      }
                                                    } else {
                                                      saleProvider
                                                          .changeValidateBalanceValue(
                                                              false);
                                                      final snackBar = SnackBar(
                                                        elevation: 0,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        content:
                                                            AwesomeSnackbarContent(
                                                          title: AppLocalizations
                                                                  .of(context)!
                                                              .please_wait,
                                                          message: AppLocalizations
                                                                  .of(context)!
                                                              .purchase_exceed_balance_message,

                                                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                          contentType:
                                                              ContentType
                                                                  .warning,
                                                        ),
                                                      );

                                                      // ignore: use_build_context_synchronously
                                                      ScaffoldMessenger.of(
                                                          context)
                                                        ..hideCurrentSnackBar()
                                                        ..showSnackBar(
                                                            snackBar);
                                                    }
                                                  },
                                                );
                                        }),
                                      ),
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
                Padding(
                  padding: const EdgeInsets.only(
                    top: 130,
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.order_information,
                          style: const TextStyle(
                            color: colors.darkBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0,
                            fontFamily: "Comfortaa",
                          ),
                        ),
                        Divider(color: colors.darkBlue.withOpacity(0.15)),
                        const SizedBox(
                          height: 3,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.deliver_to,
                                      style: const TextStyle(
                                        color: Colors.black26,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.0,
                                        fontFamily: "Comfortaa",
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: salePageArguments.isPresale
                                          ? colors.darkBlue.withOpacity(0.15)
                                          : Colors.transparent,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        salePageArguments.isPresale ? 12 : 0,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: Consumer2<MainProvider,
                                        ProductsProvider>(
                                      builder: (context, mainProvider,
                                              productsProvider, widget) =>
                                          mainProvider.userType ==
                                                  UserRole.tutor
                                              ? 
                                              DropdownButton(
                                                  value: mainProvider
                                                      .selectedChild,
                                                  items: mainProvider.children
                                                      .map(
                                                        (child) =>
                                                            DropdownMenuItem(
                                                                value: child,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.11,
                                                                      height:
                                                                          50,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image:
                                                                            DecorationImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          image: child.imageUrl.isNotEmpty
                                                                              ? NetworkImage(child.imageUrl)
                                                                              : const AssetImage(images.defaultProfileStudentImage) as ImageProvider<Object>,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                        width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.5,
                                                                      child: Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child: Text(
                                                                                                                                                    "${child.childName} ${child.childLastName}",
                                                                                                                                                    style:
                                                                              const TextStyle(
                                                                            color:
                                                                                colors.darkBlue,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            fontSize:
                                                                                15.0,
                                                                                                                                                    ),
                                                                                                                                                    overflow:
                                                                              TextOverflow.ellipsis,
                                                                                                                                                    softWrap:
                                                                              false,
                                                                                                                                                    maxLines:
                                                                              1,
                                                                                                                                                  ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )),
                                                      )
                                                      .toList(),
                                                  icon: const Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: colors.darkBlue,
                                                  ),
                                                  onChanged: (Child? child) {
                                                    mainProvider
                                                        .selectChild(child);
                                                    // productsProvider
                                                    //     .filterProducts(child!);
                                                    saleProvider.resetCart();
                                                  })
                                              : Row(
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.11,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: mainProvider
                                                                      .userType ==
                                                                  UserRole
                                                                      .teacher
                                                              ? mainProvider
                                                                      .tutor!
                                                                      .profilePictureUrl
                                                                      .isNotEmpty
                                                                  ? NetworkImage(
                                                                      mainProvider
                                                                          .tutor!
                                                                          .profilePictureUrl)
                                                                  : const AssetImage(images.defaultProfileStudentImage)
                                                                      as ImageProvider<
                                                                          Object>
                                                              : mainProvider
                                                                      .selectedChild!
                                                                      .imageUrl
                                                                      .isNotEmpty
                                                                  ? NetworkImage(
                                                                      mainProvider
                                                                          .selectedChild!
                                                                          .imageUrl)
                                                                  : const AssetImage(
                                                                          images.defaultProfileStudentImage)
                                                                      as ImageProvider<Object>,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15),
                                                      child: Text(
                                                        mainProvider.userType ==
                                                                UserRole.teacher
                                                            ? "${mainProvider.tutor!.firstName} ${mainProvider.tutor!.lastName}"
                                                            : "${mainProvider.selectedChild!.childName} ${mainProvider.selectedChild!.childLastName}",
                                                        style: const TextStyle(
                                                          color:
                                                              colors.darkBlue,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 15.0,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: false,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    salePageArguments.isPresale
                                        ? Text(
                                            AppLocalizations.of(context)!
                                                .delivery_date,
                                            style: const TextStyle(
                                              color: Colors.black26,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12.0,
                                              fontFamily: "Comfortaa",
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                salePageArguments.isPresale
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                            color: colors.darkBlue
                                                .withOpacity(0.15),
                                          ),
                                          color: salePageArguments.isPresale
                                              ? Colors.white
                                              : const Color(0xFFE3E2E0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Consumer2<SaleProvider,
                                            HomeProvider>(
                                          builder: (context, saleProvider,
                                                  homeProvider, widget) =>
                                              GestureDetector(
                                            onTap: salePageArguments.isPresale
                                                ? () {
                                                    int weekDaySaleRestriction =
                                                        ((homeProvider.cafeteria?.school
                                                                            .country ??
                                                                        "") ==
                                                                    Contries
                                                                        .panama &&
                                                                DateTime.now()
                                                                        .hour >
                                                                    12)
                                                            ? 2
                                                            : 1;

                                                    DateTime now =
                                                        DateTime.now().add(
                                                      Duration(
                                                        days:
                                                            weekDaySaleRestriction,
                                                      ),
                                                    );

                                                    DateTime nextWeekDay = now;

                                                    print(
                                                        "Next week day $nextWeekDay ${nextWeekDay.weekday}");

                                                    //Validation for sunday
                                                    if (now.weekday == 7) {
                                                      nextWeekDay =
                                                          nextWeekDay.add(
                                                        const Duration(
                                                          days: 1,
                                                        ),
                                                      );
                                                    }
                                                    //Validation for saturday
                                                    else if (now.weekday == 6) {
                                                      nextWeekDay =
                                                          nextWeekDay.add(
                                                        const Duration(
                                                          days: 2,
                                                        ),
                                                      );
                                                    }
                                                    //Validation for friday
                                                    else if (now.weekday == 5) {
                                                      nextWeekDay =
                                                          nextWeekDay.add(
                                                        const Duration(
                                                          days: 3,
                                                        ),
                                                      );

                                                      if (((homeProvider
                                                                      .cafeteria
                                                                      ?.school
                                                                      .country ??
                                                                  "") ==
                                                              Contries.panama &&
                                                          DateTime.now().hour >
                                                              12)) {
                                                        nextWeekDay =
                                                            nextWeekDay.add(
                                                          const Duration(
                                                            days: 4,
                                                          ),
                                                        );
                                                      }
                                                    }

                                                    showDatePicker(
                                                      context: context,
                                                      initialDate: nextWeekDay,
                                                      firstDate: nextWeekDay,
                                                      lastDate: now.add(
                                                        const Duration(
                                                            days: 15),
                                                      ),
                                                      selectableDayPredicate:
                                                          (DateTime val) =>
                                                              val.weekday ==
                                                                          6 ||
                                                                      val.weekday ==
                                                                          7
                                                                  ? false
                                                                  : true,
                                                      locale: Locale(
                                                        AppLocalizations.of(
                                                                    context)
                                                                ?.localeName ??
                                                            "",
                                                      ),
                                                    ).then(
                                                      (value) {
                                                        saleProvider
                                                                .hasSelectedDateInPresale =
                                                            true;
                                                        saleProvider
                                                            .updateSaleDate(
                                                                value!,
                                                                salePageArguments
                                                                    .isPresale);

                                                        saleProvider
                                                            .resetCart();

                                                        productsProvider.getProducts(
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
                                                            omitFilters: false,
                                                            isPresale:
                                                                salePageArguments
                                                                    .isPresale,
                                                            replaceDate: value);
                                                      },
                                                    );
                                                  }
                                                : null,
                                            child: TextFormField(
                                              enabled: false,
                                              controller: saleProvider
                                                  .saleDateController,
                                              style: const TextStyle(
                                                color: colors.darkBlue,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12,
                                              ),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                salePageArguments.isPresale
                                    ? const SizedBox(
                                        height: 20,
                                      )
                                    : const SizedBox(height: 10),
                                Consumer<MainProvider>(
                                    builder: (context, mainProvider, widget) {
                                  return (mainProvider.userType ==
                                              UserRole.tutor ||
                                          (mainProvider.userType ==
                                                  UserRole.student &&
                                              !mainProvider.selectedChild!
                                                  .isIndependent))
                                      ? Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .available_balance,
                                                  style: const TextStyle(
                                                    color: Colors.black26,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 12.0,
                                                    fontFamily: "Comfortaa",
                                                  ),
                                                ),
                                                Consumer<MainProvider>(
                                                  builder: (context,
                                                          mainProvider,
                                                          widget) =>
                                                      RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          style:
                                                              const TextStyle(
                                                                  color: colors
                                                                      .darkBlue,
                                                                  fontSize:
                                                                      20.0,
                                                                  fontFamily:
                                                                      "Outfit"),
                                                          text: (double.parse(mainProvider
                                                                          .familyBalance) -
                                                                      mainProvider
                                                                          .totalDebt) <
                                                                  0
                                                              ? " - \$${(double.parse(mainProvider.familyBalance) - mainProvider.totalDebt).abs()}"
                                                              : "\$${(double.parse(mainProvider.familyBalance) - mainProvider.totalDebt).abs()}",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            salePageArguments.isPresale
                                                ? Container()
                                                : Column(
                                                    children: [
                                                      Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 5),
                                                          height: 1,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2),
                                                            border: Border.all(
                                                              color: colors
                                                                  .darkBlue
                                                                  .withOpacity(
                                                                      0.15),
                                                            ),
                                                            color: salePageArguments
                                                                    .isPresale
                                                                ? Colors.white
                                                                : const Color(
                                                                    0xFFE3E2E0),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 5,
                                                          )),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 15),
                                                        color: const Color(
                                                                0xff5CAEFF)
                                                            .withOpacity(0.1),
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.info,
                                                              color: Color(
                                                                  0xff5CAEFF),
                                                            ),
                                                            const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            8)),
                                                            Flexible(
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .today_sale_information,
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xff5CAEFF),
                                                                    fontSize:
                                                                        10,
                                                                    fontFamily:
                                                                        "Comfortaa"),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ],
                                        )
                                      : !salePageArguments.isPresale
                                          ? Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .deliver_in_time,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.5)),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        _showPicker(context,
                                                            timeProvider);
                                                      },
                                                      child: Container(
                                                          width: 170,
                                                          height: 45,
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      5),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.4)),
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                                  saleProvider
                                                                      .scheduledHour,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.4),
                                                                  )))),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          : Container();
                                }),
                              ],
                            ),
                          ],
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
          ),
        ],
      ),
    );
  }

  void _showPicker(BuildContext context, TimeProvider timeProvider) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: Consumer<SaleProvider>(
                builder: (context, saleProvider, widget) {
                  var items = timeProvider.getClickableHours();
                  return CupertinoPicker(
                      backgroundColor: Colors.white,
                      itemExtent: 30,
                      scrollController:
                          FixedExtentScrollController(initialItem: 1),
                      children: List.generate(
                          items.length,
                          (index) => Center(
                                child: Text(
                                  items[index],
                                  style: const TextStyle(fontSize: 20),
                                ),
                              )),
                      onSelectedItemChanged: (value) {
                        saleProvider.updateScheduledHour(items[value]);
                      });
                },
              ),
            ));
  }
}
