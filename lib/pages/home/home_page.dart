import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/models/sale_page_arguments.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/home/components/app_version_modal.dart';
import 'package:smart_lunch/pages/home/time_provider.dart';
import 'package:smart_lunch/pages/panama/membership_modal/membership_modal.dart';
import 'package:smart_lunch/pages/providers.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/box_overlay.dart';
import 'package:smart_lunch/widgets/circled_icon.dart';
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';

import 'components/components.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Build home");

    MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: false);

    CardsInfoProvider cardsInfoProvider = Provider.of<CardsInfoProvider>(
      context,
      listen: false,
    );

    HomeProvider homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );

    CardsCroemProvider croemCardInfo = Provider.of<CardsCroemProvider>(
      context,
      listen: false,
    );

    TimeProvider timeProvider = Provider.of<TimeProvider>(
      context,
      listen: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mainProvider.appIsUpdated == false) {
        showDialog(
          context: context,
          useSafeArea: true,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const AppVersionModal();
          },
        );
      }

      if ((homeProvider.cafeteria?.school.country ?? "") == Contries.panama &&
          mainProvider.showMembershipModal) {
        showDialog(
          context: context,
          useSafeArea: true,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const PendingMembershipModal();
          },
        );
      }
    });

    return TransparentScaffold(
      selectedOption: "Inicio",
      body: Stack(
        children: [
          Consumer3<MainProvider, ProductsProvider, SaleProvider>(builder:
              (context, mainProvider, productsProvider, saleProvider, widget) {
            DateTime currentDate = timeProvider.getCurrentDate();
            String startTimeStr = mainProvider.cafeteriaSetting!.startTime;
            String endTimeStr = mainProvider.cafeteriaSetting!.endTime;

            DateTime startTime = DateTime(
              currentDate.year,
              currentDate.month,
              currentDate.day,
              int.parse(startTimeStr.split(':')[0]),
              int.parse(startTimeStr.split(':')[1]),
            );

            DateTime endTime = DateTime(
              currentDate.year,
              currentDate.month,
              currentDate.day,
              int.parse(endTimeStr.split(':')[0]),
              int.parse(endTimeStr.split(':')[1]),
            );

            return Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer<HomeProvider>(
                            builder: (context, homeProvider, widget) =>
                                CustomAppBar(
                              height: 270,
                              showSchoolLogo: true,
                              image: images.appBarLongImg,
                              schoolLogoUrl: homeProvider.cafeteria?.logo ?? "",
                              schoolName:
                                  homeProvider.cafeteria?.school.name ?? "",
                              cafeteriaName: homeProvider.cafeteria?.name ?? "",
                            ),
                          ),
                          SizedBox(
                            height: mainProvider.userType == UserRole.tutor &&
                                    mainProvider.debtors.isNotEmpty &&
                                    mainProvider.totalDebt > 0
                                ? 170
                                : 115,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (homeProvider.cafeteria?.menu.isNotEmpty ??
                                    false)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        router.menuRoute,
                                        //router.mercadoPagoPage
                                      );
                                    },
                                    child: const CircledIcon(
                                      color: colors.gold,
                                      iconData: Icons.menu_book,
                                      height: 36,
                                      width: 48,
                                      padding: 6,
                                    ),
                                  ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //TODO: Regresar condicional
                                    (mainProvider.cafeteriaSetting!
                                                    .mobileSales ==
                                                true &&
                                            currentDate.isAfter(startTime) &&
                                            currentDate.isBefore(endTime) &&
                                            currentDate.weekday != 6 &&
                                            currentDate.weekday != 7)
                                        ? RoundedButton(
                                            color: colors.tuitionGreen,
                                            iconData: Icons.shopping_cart,
                                            text: AppLocalizations.of(context)!
                                                .sale,
                                            onTap: () {
                                              saleProvider.updateSaleDate(
                                                  DateTime.now(), false);
                                              saleProvider.resetCart();
                                              saleProvider.selectedDateFormat =
                                                  DateFormat("dd/MM/yyyy")
                                                      .format(DateTime.now())
                                                      .toString();
                                              productsProvider.getProducts(
                                                  mainProvider.accessToken,
                                                  mainProvider.cafeteriaId,
                                                  (homeProvider
                                                              .cafeteria
                                                              ?.school
                                                              .country ??
                                                          "") ==
                                                      Contries.panama,
                                                  selectedChild: mainProvider
                                                      .selectedChild,
                                                  isPresale: false,
                                                  omitFilters: false,
                                                  replaceDate: saleProvider
                                                      .selectedDate);

                                              Navigator.of(context).pushNamed(
                                                router.saleRoute,
                                                arguments: SalePageArguments(
                                                  isPresale: false,
                                                ),
                                              );
                                            },
                                          )
                                        : Container(),
                                    const SizedBox(
                                      width: 24,
                                    ),
                                    (mainProvider.cafeteriaSetting!.presales ==
                                                true &&
                                            mainProvider.userType ==
                                                UserRole.tutor)
                                        ? RoundedButton(
                                            color: colors.lightBlue,
                                            iconData: Icons.add_shopping_cart,
                                            text: AppLocalizations.of(context)!
                                                .presale,
                                            onTap: () {
                                              saleProvider.updateSaleDate(
                                                  DateTime.now(), true);
                                              saleProvider.resetCart();
                                              //saleProvider.saleDateController.text="Seleccione una fecha";
                                              //saleProvider. selectedDateFormat = DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
                                              productsProvider.getProducts(
                                                  mainProvider.accessToken,
                                                  mainProvider.cafeteriaId,
                                                  (homeProvider
                                                              .cafeteria
                                                              ?.school
                                                              .country ??
                                                          "") ==
                                                      Contries.panama,
                                                  selectedChild: mainProvider
                                                      .selectedChild,
                                                  isPresale: true,
                                                  omitFilters: false,
                                                  replaceDate: saleProvider
                                                      .selectedDate);

                                              Navigator.of(context).pushNamed(
                                                router.saleRoute,
                                                arguments: SalePageArguments(
                                                  isPresale: true,
                                                ),
                                              );
                                            },
                                          )
                                        : Container(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (mainProvider.cafeteriaSetting!.presales == true &&
                              (homeProvider.cafeteria?.school.country ?? "") ==
                                  Contries.panama)
                            Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RoundedButton(
                                      color: colors.lightBlue,
                                      iconData: Icons.add_shopping_cart,
                                      text: AppLocalizations.of(context)!
                                          .multisale,
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed(router.multisaleRoute);
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                // top: 90,
                              ),
                              child: DefaultTabController(
                                length: 2,
                                child: Column(
                                  children: [
                                    ColoredBox(
                                        color: colors.white,
                                        child: TabBar(
                                          labelColor: colors.orange,
                                          unselectedLabelColor:
                                              colors.orange.withOpacity(0.5),
                                          indicatorColor: colors.orange,
                                          labelPadding: EdgeInsets.zero,
                                          tabs: [
                                            Tab(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .today_purchases,
                                            ),
                                            Tab(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .presales,
                                            ),
                                          ],
                                        )),
                                    Expanded(
                                      child: TabBarView(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 12,
                                            ),
                                            child: Consumer<HomeProvider>(
                                              builder: (context, homeProvider,
                                                      widget) =>
                                                  RefreshIndicator(
                                                onRefresh: () async {
                                                  homeProvider.loadSales(
                                                      mainProvider.accessToken,
                                                      mainProvider.cafeteriaId,
                                                      int.parse(mainProvider
                                                          .studentId),
                                                      mainProvider.userType,
                                                      false);
                                                },
                                                child: TabContent(
                                                  isPresale: false,
                                                  products:
                                                      homeProvider.dailySales,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 12,
                                            ),
                                            child: Consumer<HomeProvider>(
                                              builder: (context, homeProvider,
                                                      widget) =>
                                                  RefreshIndicator(
                                                onRefresh: () async {
                                                  homeProvider.loadPresales(
                                                      mainProvider.accessToken,
                                                      mainProvider.cafeteriaId,
                                                      int.parse(mainProvider
                                                          .studentId),
                                                      mainProvider.userType);
                                                },
                                                child: TabContent(
                                                  isPresale: true,
                                                  products:
                                                      homeProvider.presales,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 210),
                        child: BoxOverlay(
                          marginTop: 2,
                          height: mainProvider.userType == UserRole.tutor &&
                                  mainProvider.debtors.isNotEmpty &&
                                  mainProvider.totalDebt > 0
                              ? 220
                              : 165,
                          firstRow: [
                            Text(
                              AppLocalizations.of(context)!.home,
                              style: const TextStyle(
                                color: colors.darkBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0,
                                fontFamily: "Comfortaa",
                              ),
                            ),
                            Text(
                              DateFormat("EEEE, d MMM, yyyy", "es").format(
                                DateTime.now(),
                              ),
                              style: TextStyle(
                                color: const Color(0xff413931).withOpacity(0.5),
                                fontWeight: FontWeight.w300,
                                fontSize: 8.0,
                                fontFamily: "Comfortaa",
                              ),
                            ),
                          ],
                          secondRow: [
                            Consumer<MainProvider>(
                              builder: (context, mainProvider, widget) =>
                                  RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      style: TextStyle(
                                          color: double.parse(mainProvider
                                                      .familyBalance) <
                                                  ((homeProvider
                                                                  .cafeteria
                                                                  ?.school
                                                                  .country ??
                                                              "") ==
                                                          Contries.panama
                                                      ? 2
                                                      : 50)
                                              ? colors.coral
                                              : colors.darkBlue,
                                          fontSize: 35.0,
                                          fontFamily: "Outfit"),
                                      text: (double.parse(mainProvider
                                                      .familyBalance) -
                                                  mainProvider.totalDebt) <
                                              0
                                          ? " - \$${(double.parse(mainProvider.familyBalance) - mainProvider.totalDebt).abs()}"
                                          : "\$${(double.parse(mainProvider.familyBalance) - mainProvider.totalDebt).abs()}",
                                    ),
                                    TextSpan(
                                      style: TextStyle(
                                          color: double.parse(mainProvider
                                                      .familyBalance) <
                                                  ((homeProvider
                                                                  .cafeteria
                                                                  ?.school
                                                                  .country ??
                                                              "") ==
                                                          Contries.panama
                                                      ? 2
                                                      : 50)
                                              ? colors.coral
                                              : colors.darkBlue,
                                          fontSize: 16.0,
                                          fontFamily: "Outfit"),
                                      text: ((homeProvider.cafeteria?.school
                                                      .country ??
                                                  "") ==
                                              Contries.panama)
                                          ? " USD"
                                          : " MXN",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ((mainProvider.userType == UserRole.tutor &&
                                        mainProvider.cafeteriaSetting!
                                                .openpayRecharge ==
                                            true) ||
                                    (mainProvider.userType == UserRole.tutor &&
                                        mainProvider.cafeteriaSetting!
                                                .mercadoPagoEnabled ==
                                            true))
                                ? GestureDetector(
                                    onTap: () async {
                                      //Navigator.of(context).pushNamed(router.topUpBalanceRoute);
                                      //Navigator.of(context).pushNamed(router.cardsRoute);
                                      //Navigator.of(context).pushNamed(router.topUpRoute);
                                      // ignore: use_build_context_synchronously

                                      //Navigator.of(context).pushNamed(router.promotionsRoute);

                                      if (mainProvider.userType ==
                                              UserRole.tutor &&
                                          (homeProvider.cafeteria?.school
                                                      .country ??
                                                  "") ==
                                              Contries.panama) {
                                        if (!croemCardInfo.isLoadingCardList) {
                                          if (croemCardInfo.cards.isEmpty) {
                                            await croemCardInfo.getCardList(
                                                mainProvider.accessToken,
                                                mainProvider.cafeteriaId);
                                          }

                                          Navigator.of(context).pushNamed(
                                              router.topUpCroemRoute);
                                        }
                                      } else {
                                        if ((mainProvider.userType ==
                                                UserRole.tutor &&
                                            mainProvider.cafeteriaSetting!
                                                    .mercadoPagoEnabled ==
                                                true)) {
                                          Navigator.of(context)
                                              .pushNamed(router.topUpRoute);
                                              return;
                                        }

                                        if (!cardsInfoProvider.loadingCards) {
                                          if (cardsInfoProvider.cards.isEmpty) {
                                            await cardsInfoProvider.getCardList(
                                                mainProvider.accessToken,
                                                mainProvider.cafeteriaId);
                                          }
                                          Navigator.of(context).pushNamed(
                                              router.topUpOpenpayRoute);
                                        }
                                      }
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const CircledIcon(
                                          color: Color(0xff008891),
                                          iconData: Icons.payments,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          child: Text(
                                            (cardsInfoProvider.loadingCards ||
                                                    croemCardInfo
                                                        .isLoadingCardList)
                                                ? "${AppLocalizations.of(context)!.loading_message}..."
                                                : AppLocalizations.of(context)!
                                                    .top_up,
                                            style: const TextStyle(
                                              color: Color(0xff008891),
                                              fontSize: 8.0,
                                              fontFamily: "Comfortaa",
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
