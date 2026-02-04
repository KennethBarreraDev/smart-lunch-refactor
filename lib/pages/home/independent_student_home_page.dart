import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/models/sale_page_arguments.dart';
import 'package:smart_lunch/pages/home/time_provider.dart';
import 'package:smart_lunch/pages/home/components/app_version_modal.dart';
import 'package:smart_lunch/pages/panama/membership_modal/membership_modal.dart';
import 'package:smart_lunch/pages/providers.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/box_overlay.dart';
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';

import 'dart:developer' as developer;

import 'components/components.dart';

class IndependentStudentPage extends StatelessWidget {
  const IndependentStudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );
    MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: false);

    CardsInfoProvider cardsInfoProvider = Provider.of<CardsInfoProvider>(
      context,
      listen: false,
    );

    TimeProvider timeProvider = Provider.of<TimeProvider>(
      context,
      listen: false,
    );

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
    timeProvider.updateCafeteriaCloseTime(endTime);
    developer.log(timeProvider.cafeteriaCloseTime.toString(),
        name: "Hora actual");

    bool isInOperationalHour =
        (mainProvider.cafeteriaSetting!.mobileSales == true &&
            currentDate.isAfter(startTime) &&
            currentDate.isBefore(endTime) &&
            currentDate.weekday != 6 &&
            currentDate.weekday != 7);
    //bool isInOperationalHour = true;
    if (!(isInOperationalHour)) {
      mainProvider.hideSalesForIndependentStudent = false;
    }

    //TODO: Regresar modal
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
                          const SizedBox(
                            height: 160,
                          ),
                          (mainProvider.hideSalesForIndependentStudent)
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 16,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          AppLocalizations.of(context)!
                                              .place_order,
                                          style: const TextStyle(
                                              fontFamily: "Comfortaa",
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold)),
                                      if (homeProvider
                                              .cafeteria?.menu.isNotEmpty ??
                                          false)
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              router.menuRoute,
                                              //router.mercadoPagoPage
                                            );
                                          },
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.menu_book,
                                                color: colors.orange,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 3),
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .view_menu,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: colors.orange),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    mainProvider.showSales();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 25,
                                        top: 30,
                                        bottom: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color:
                                                  colors.coral.withOpacity(0.2),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20))),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .close_button,
                                            style: const TextStyle(
                                                color: colors.coral),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          mainProvider.hideSalesForIndependentStudent
                              ? Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      // top: 90,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          //TODO: Regresar condicional
                                          isInOperationalHour &&
                                                  mainProvider.cafeteriaSetting!
                                                          .mobileSales ==
                                                      true
                                              ? GestureDetector(
                                                  onTap: () {
                                                    print("On tap");
                                                     saleProvider.updateSaleDate(
                                                        DateTime.now(), false);
                                                    saleProvider.scheduledHour =
                                                        "Seleccione una hora";
                                                    saleProvider.resetCart();
                                                    saleProvider
                                                            .selectedDateFormat =
                                                        DateFormat("dd/MM/yyyy")
                                                            .format(
                                                                DateTime.now())
                                                            .toString();
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
                                                        selectedChild:
                                                            mainProvider
                                                                .selectedChild,
                                                        omitFilters: false,
                                                        isPresale: false,
                                                        replaceDate:
                                                            saleProvider
                                                                .selectedDate);

                                                    Navigator.of(context)
                                                        .pushNamed(
                                                      router.saleRoute,
                                                      arguments:
                                                          SalePageArguments(
                                                        isPresale: false,
                                                      ),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Container(
                                                      height: 90,
                                                      decoration: BoxDecoration(
                                                          color: colors.orange
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(20),
                                                          )),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .sale,
                                                                  style: const TextStyle(
                                                                      color: colors
                                                                          .orange,
                                                                      fontSize:
                                                                          20,
                                                                      fontFamily:
                                                                          "Comfortaa"),
                                                                ),
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .sale_description,
                                                                  style: const TextStyle(
                                                                      color: colors
                                                                          .orange,
                                                                      fontSize:
                                                                          10,
                                                                      fontFamily:
                                                                          "Comfortaa"),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Image.asset(
                                                            images.dishIcon,
                                                            height: 100,
                                                            width: 100,
                                                            opacity:
                                                                const AlwaysStoppedAnimation<
                                                                        double>(
                                                                    0.5),
                                                          ), // Image.asset
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          mainProvider
                                                  .cafeteriaSetting!.presales
                                              ? GestureDetector(
                                                  onTap: () {
                                                    saleProvider.updateSaleDate(
                                                        DateTime.now(), true);
                                                    saleProvider.scheduledHour =
                                                        "Seleccione una hora";
                                                    saleProvider.resetCart();
                                                    // saleProvider
                                                    //         .selectedDateFormat =
                                                    //     DateFormat("dd/MM/yyyy")
                                                    //         .format(
                                                    //             DateTime.now())
                                                    //         .toString();
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
                                                        selectedChild:
                                                            mainProvider
                                                                .selectedChild,
                                                        omitFilters: false,
                                                        isPresale: true,
                                                        replaceDate:
                                                            saleProvider
                                                                .selectedDate);

                                                    Navigator.of(context)
                                                        .pushNamed(
                                                      router.saleRoute,
                                                      arguments:
                                                          SalePageArguments(
                                                        isPresale: true,
                                                      ),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: Container(
                                                      height: 90,
                                                      decoration: BoxDecoration(
                                                          color: colors
                                                              .lightBlue
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(20),
                                                          )),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .presales,
                                                                  style: const TextStyle(
                                                                      color: colors
                                                                          .lightBlue,
                                                                      fontSize:
                                                                          20,
                                                                      fontFamily:
                                                                          "Comfortaa"),
                                                                ),
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .presale_description,
                                                                  style: const TextStyle(
                                                                      color: colors
                                                                          .lightBlue,
                                                                      fontSize:
                                                                          10,
                                                                      fontFamily:
                                                                          "Comfortaa"),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Image.asset(
                                                            images.clockIcon,
                                                            height: 100,
                                                            width: 100,
                                                            opacity:
                                                                const AlwaysStoppedAnimation<
                                                                        double>(
                                                                    0.5),
                                                          ), // Image.asset
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                          GestureDetector(
                                            onTap: () {
                                              mainProvider.showSales();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.list,
                                                    color: colors.orange,
                                                    size: 25,
                                                    semanticLabel: '',
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                        AppLocalizations
                                                                .of(context)!
                                                            .view_today_purchases,
                                                        style:
                                                            const TextStyle(
                                                                color: colors
                                                                    .orange,
                                                                fontFamily:
                                                                    "Comfortaa",
                                                                fontSize: 15)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
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
                                                unselectedLabelColor: colors
                                                    .orange
                                                    .withOpacity(0.5),
                                                indicatorColor: colors.orange,
                                                labelPadding: EdgeInsets.zero,
                                                tabs: [
                                                  Tab(
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .today_purchases,
                                                  ),
                                                  Tab(
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .presales,
                                                  ),
                                                ],
                                              )),
                                          Expanded(
                                            child: TabBarView(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 12,
                                                  ),
                                                  child: Consumer<HomeProvider>(
                                                    builder: (context,
                                                            homeProvider,
                                                            widget) =>
                                                        RefreshIndicator(
                                                      onRefresh: () async {
                                                        homeProvider.loadSales(
                                                          mainProvider
                                                              .accessToken,
                                                          mainProvider
                                                              .cafeteriaId,
                                                          int.parse(mainProvider
                                                              .studentId),
                                                          mainProvider.userType,
                                                          mainProvider.userType ==
                                                                  UserRole.tutor
                                                              ? false
                                                              : mainProvider
                                                                      .selectedChild
                                                                      ?.isIndependent ??
                                                                  false,
                                                        );
                                                      },
                                                      child: TabContent(
                                                        isPresale: false,
                                                        products: homeProvider
                                                            .dailySales,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 12,
                                                  ),
                                                  child: Consumer<HomeProvider>(
                                                    builder: (context,
                                                            homeProvider,
                                                            widget) =>
                                                        RefreshIndicator(
                                                      onRefresh: () async {
                                                        homeProvider.loadPresales(
                                                            mainProvider
                                                                .accessToken,
                                                            mainProvider
                                                                .cafeteriaId,
                                                            int.parse(
                                                                mainProvider
                                                                    .studentId),
                                                            mainProvider
                                                                .userType);
                                                      },
                                                      child: TabContent(
                                                        isPresale: true,
                                                        products: homeProvider
                                                            .presales,
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
                        padding: const EdgeInsets.only(top: 190),
                        child: BoxOverlay(
                          marginTop: 2,
                          height: 230,
                          firstRow: [
                            Consumer<MainProvider>(
                                builder: (context, mainProvider, widget) => Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.20,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: mainProvider.userType ==
                                                    UserRole.student
                                                ? DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: mainProvider
                                                            .selectedChild!
                                                            .imageUrl
                                                            .isNotEmpty
                                                        ? NetworkImage(
                                                            mainProvider
                                                                .selectedChild!
                                                                .imageUrl)
                                                        : const AssetImage(images
                                                                .defaultProfileStudentImage)
                                                            as ImageProvider<
                                                                Object>,
                                                  )
                                                : DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: mainProvider
                                                            .tutor!
                                                            .profilePictureUrl
                                                            .isNotEmpty
                                                        ? NetworkImage(mainProvider
                                                            .tutor!
                                                            .profilePictureUrl)
                                                        : const AssetImage(images
                                                                .defaultProfileStudentImage)
                                                            as ImageProvider<
                                                                Object>,
                                                  ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 230,
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      mainProvider.userType ==
                                                              UserRole.student
                                                          ? "${mainProvider.selectedChild!.childName} ${mainProvider.selectedChild!.childLastName}"
                                                          : "${mainProvider.tutor?.firstName} ${mainProvider.tutor?.lastName}",
                                                      style: const TextStyle(
                                                        color: colors.darkBlue,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18.0,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .student,
                                                style: TextStyle(
                                                  color: colors.darkBlue
                                                      .withOpacity(0.5),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 10.0,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))
                          ],
                          middleRow: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 15.0, top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .current_balance,
                                        style: const TextStyle(
                                            color: colors.orange,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Comfortaa",
                                            fontSize: 16),
                                      ),
                                    ),
                                    Consumer<MainProvider>(
                                      builder:
                                          (context, mainProvider, widget) =>
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
                                                                  Contries
                                                                      .panama
                                                              ? 2
                                                              : 50)
                                                      ? colors.coral
                                                      : colors.darkBlue,
                                                  fontSize: 25.0,
                                                  fontFamily: "Outfit"),
                                              text: (double.parse(mainProvider
                                                              .familyBalance) -
                                                          mainProvider
                                                              .totalDebt) <
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
                                                                  Contries
                                                                      .panama
                                                              ? 2
                                                              : 50)
                                                      ? colors.coral
                                                      : colors.darkBlue,
                                                  fontSize: 16.0,
                                                  fontFamily: "Outfit"),
                                              text: ((homeProvider
                                                              .cafeteria
                                                              ?.school
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
                                  ],
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, top: 20),
                              child: mainProvider
                                      .cafeteriaSetting!.openpayRecharge
                                  ? ClipOval(
                                      child: Material(
                                        color: colors.tuitionGreen
                                            .withOpacity(0.2), // Button color
                                        child: InkWell(
                                          onTap: () async {
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
                                              Navigator.of(context).pushNamed(
                                                  router.topUpOpenpayRoute);
                                            }
                                          },
                                          child: cardsInfoProvider.loadingCards
                                              ? const CircularProgressIndicator(
                                                  color: colors.tuitionGreen,
                                                )
                                              : const SizedBox(
                                                  width: 40,
                                                  height: 40,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: colors.tuitionGreen,
                                                  )),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ),
                          ],
                          secondRow: [
                            mainProvider.cafeteriaSetting!.openpayRecharge
                                ? TextButton.icon(
                                    onPressed: () async {
                                      if (!cardsInfoProvider.loadingCards) {
                                        if (cardsInfoProvider.cards.isEmpty) {
                                          await cardsInfoProvider.getCardList(
                                              mainProvider.accessToken,
                                              mainProvider.cafeteriaId);
                                        }

                                        Navigator.of(context)
                                            .pushNamed(router.cardsRoute);
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.credit_card,
                                      color: colors.tuitionGreen,
                                      size: 20,
                                      semanticLabel: '',
                                    ),
                                    label: Text(
                                      cardsInfoProvider.loadingCards
                                          ? "${AppLocalizations.of(context)!.loading_message}..."
                                          : AppLocalizations.of(context)!
                                              .cards_message,
                                      style: const TextStyle(
                                          color: colors.tuitionGreen,
                                          fontSize: 15),
                                    ))
                                : Container(),
                            RoundedButton(
                              color: colors.lightBlue,
                              iconData: Icons.contact_emergency,
                              text: AppLocalizations.of(context)!
                                  .crendential_message,
                              onTap: () {
                                //Navigator.of(context).pushNamed(router.topUpBalanceRoute);
                                Navigator.of(context).pushNamed(router
                                    .independentStudentIdentificationRoute);
                              },
                            )
                            //ElevatedButton.icon(onPressed: null, icon: null, label: null);
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
