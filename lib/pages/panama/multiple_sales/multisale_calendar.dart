import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/main_provider.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/calendar_components/calendar_component.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/child_components/multisale_child_page.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multiple_sale_provider.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multisale_products_provider.dart';
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/custom_banner.dart';

class MultisaleCalendar extends StatelessWidget {
  const MultisaleCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: SingleChildScrollView(
                child: Consumer4<MultisaleProvider, MultisaleProductsProvider,
                        HomeProvider, MainProvider>(
                    builder: (context,
                        multisaleProvider,
                        multisaleProductsProvider,
                        homeProvider,
                        mainProvider,
                        child) {
                  return Column(
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
                                horizontal: 8, vertical: 8),
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
                                        image: (multisaleProvider.selectedChild
                                                        ?.imageUrl ??
                                                    "")
                                                .isNotEmpty
                                            ? NetworkImage(
                                                (multisaleProvider.selectedChild
                                                        ?.imageUrl ??
                                                    ""),
                                              )
                                            : const AssetImage(
                                                images
                                                    .defaultProfileStudentImage,
                                              ) as ImageProvider<Object>,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 14,
                                  ),
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
                                        AppLocalizations.of(context)!
                                            .homePageStack,
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
                      const SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.white.withOpacity(0.3),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ...multisaleProvider.multisaleProducts
                          .map(
                            (element) => Align(
                              alignment: Alignment.center,
                              child: CalendarComponent(
                                salePrice: element.totalPrice,
                                selected: element.selected,
                                date: DateFormat(
                                        "EEEE',' d 'de' MMMM  'de' y", 'es')
                                    .format(element.saleDate)
                                    .toString(),
                                onTap: () {
                                  print("Comentario es ${element.comment}");
                                  multisaleProvider.changeSelectedDate(
                                      element.saleDate,
                                      element.cart ?? {},
                                      element.cartProducts ?? [],
                                      element.totalPrice,
                                      element.totalProducts,
                                      element.selected,
                                      element.comment);
                                  multisaleProductsProvider.getProducts(
                                      mainProvider.accessToken,
                                      mainProvider.cafeteriaId,
                                      (homeProvider.cafeteria?.school.country ??
                                              "") ==
                                          Contries.panama,
                                      multisaleProvider
                                          .selectedSaleDate.saleDate,
                                      incrementPage: true,
                                      omitFilters: false,
                                      loadData: true,
                                      resetPage: true,
                                      isPresale: true);
                                  Navigator.of(context).pushNamed(
                                    router.multisalePageRoute,
                                  );
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  );
                }),
              ),
            ),
          ),
          Consumer<MultisaleProvider>(
            builder: (context, multisaleProvider, widget) => Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: multisaleProvider.applyDisscount ? CrossAxisAlignment.center : CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Column(
                        children: [
                          if (multisaleProvider.applyDisscount)
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 35,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          colors.tuitionGreen.withOpacity(0.2)),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .disccount_message,
                                          style: const TextStyle(
                                              color: colors.tuitionGreen,
                                              fontSize: 10),
                                        ),
                                        const Text(
                                          "\$3.25",
                                          style: TextStyle(
                                              color: colors.tuitionGreen,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          const SizedBox(
                            height: 5,
                          ),
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
                                  text: "\$${multisaleProvider.totalPrice}",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Consumer2<MultisaleProvider, MainProvider>(builder:
                        (context, multisaleProvider, mainProvider, child) {
                      return GestureDetector(
                        onTap: () {
                          multisaleProvider
                              .sellProducts(
                            mainProvider.accessToken,
                            mainProvider.cafeteriaId,
                            multisaleProvider.selectedChild?.userId ?? "",
                            AppLocalizations.of(context),
                          )
                              .then((value) {
                            if (value) {
                              Navigator.of(context)
                                  .pushNamed(router.multisaleSuccessPage);
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: multisaleProvider.canBuy
                                  ? colors.tuitionGreen.withOpacity(0.2)
                                  : Colors.grey.withOpacity(0.2)),
                          child: multisaleProvider.isSellingProducts
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: colors.tuitionGreen,
                                ))
                              : Text(
                                  multisaleProvider.canBuy
                                      ? AppLocalizations.of(context)!.buy_now
                                      : AppLocalizations.of(context)!
                                          .make_one_order,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: multisaleProvider.canBuy
                                          ? colors.tuitionGreen
                                          : Colors.grey),
                                ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Consumer<MultisaleProvider>(
              builder: (context, multisaleProvider, widget) => CustomBanner(
                bannerType: multisaleProvider.multisaleBannerType,
                bannerMessage: multisaleProvider.multisaleBannerMessage,
                hideBanner: multisaleProvider.hideBalanceTopUpBanner,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
