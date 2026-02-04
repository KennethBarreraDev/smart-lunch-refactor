import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/models/successful_sale_arguments.dart';
import 'package:smart_lunch/pages/home/components/rounded_button.dart';
import 'package:smart_lunch/pages/providers.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_graphics/vector_graphics.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';

class SuccessfulSalePage extends StatelessWidget {
  const SuccessfulSalePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );
    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );
    HistoryProvider historyProvider = Provider.of<HistoryProvider>(
      context,
      listen: false,
    );

    SuccessfulSaleArguments successfulSaleArguments =
        ModalRoute.of(context)?.settings.arguments as SuccessfulSaleArguments;

    return TransparentScaffold(
      selectedOption: "Inicio",
      showDrawer: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                const CustomAppBar(
                  height: 255,
                  showPageTitle: false,
                  showDrawer: false,
                  image: images.appBarLongImg,
                  titleTopPadding: 0.3,
                  secondaryColor: true,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 27,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 140,
                          ),
                          const SizedBox(
                            height: 150,
                            child: SvgPicture(
                              AssetBytesLoader(images.successfulSaleImage),
                              semanticsLabel: "successfulSaleImage",
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            height: 56,
                          ),
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 2),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.08),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .folio_message,
                                            style: const TextStyle(
                                                color: colors.darkBlue,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15.0,
                                                fontFamily: "Comfortaa"),
                                          ),
                                          Flexible(
                                            child: Text(
                                              successfulSaleArguments.folio
                                                  .substring(
                                                      successfulSaleArguments
                                                              .folio.length -
                                                          13,
                                                      successfulSaleArguments
                                                              .folio.length -
                                                          1),
                                              style: const TextStyle(
                                                  color: colors.darkBlue,
                                                  fontSize: 13.0,
                                                  fontFamily: "Comfortaa"),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                        color:
                                            colors.darkBlue.withOpacity(0.15)),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.date,
                                            style: const TextStyle(
                                                color: colors.darkBlue,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15.0,
                                                fontFamily: "Comfortaa"),
                                          ),
                                          Flexible(
                                            child: Text(
                                              successfulSaleArguments.saleDate,
                                              style: const TextStyle(
                                                  color: colors.darkBlue,
                                                  fontSize: 13.0,
                                                  fontFamily: "Comfortaa"),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                        color:
                                            colors.darkBlue.withOpacity(0.15)),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .deliver_to,
                                            style: const TextStyle(
                                                color: colors.darkBlue,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15.0,
                                                fontFamily: "Comfortaa"),
                                          ),
                                          Flexible(
                                            child: Text(
                                              "${successfulSaleArguments.childName}  ${successfulSaleArguments.childLastName}",
                                              style: const TextStyle(
                                                  color: colors.darkBlue,
                                                  fontSize: 13.0,
                                                  fontFamily: "Comfortaa",
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              maxLines: 1,
                                              softWrap: false,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                        color:
                                            colors.darkBlue.withOpacity(0.15)),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .total_items,
                                            style: const TextStyle(
                                                color: colors.darkBlue,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15.0,
                                                fontFamily: "Comfortaa"),
                                          ),
                                          Flexible(
                                            child: Text(
                                              successfulSaleArguments
                                                  .productsAmount
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: colors.darkBlue,
                                                  fontSize: 13.0,
                                                  fontFamily: "Comfortaa"),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                        color:
                                            colors.darkBlue.withOpacity(0.15)),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .subtotal,
                                            style: const TextStyle(
                                                color: colors.darkBlue,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15.0,
                                                fontFamily: "Comfortaa"),
                                          ),
                                          Flexible(
                                            child: Text(
                                              "\$${successfulSaleArguments.total.toString()} ${(homeProvider.cafeteria?.school.country ?? "") == Contries.panama ? " USD" : " MXN"}",
                                              style: const TextStyle(
                                                  color: colors.darkBlue,
                                                  fontSize: 13.0,
                                                  fontFamily: "Comfortaa"),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    /*
                                    Divider(color: colors.darkBlue.withOpacity(0.15)),
                                    SizedBox(height: 15,),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Pago por servicio",
                                            style: TextStyle(
                                                color: colors.darkBlue,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15.0,
                                                fontFamily: "Comfortaa"
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                               "",
                                              style: const TextStyle(
                                                  color: colors.darkBlue,
                                                  fontSize: 13.0,
                                                  fontFamily: "Comfortaa"
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),*/
                                    Divider(
                                        color:
                                            colors.darkBlue.withOpacity(0.15)),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.total_price,
                                    style: const TextStyle(
                                        color: colors.darkBlue,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24.0,
                                        fontFamily: "Comfortaa"),
                                  ),
                                  Text(
                                    "\$${(successfulSaleArguments.total)} ${(homeProvider.cafeteria?.school.country ?? "") == Contries.panama ? " USD" : " MXN"}",
                                    style: const TextStyle(
                                        color: colors.darkBlue,
                                        fontSize: 34.0,
                                        fontFamily: "Outfit"),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          RoundedButton(
                            color: colors.orange,
                            iconData: Icons.arrow_back,
                            text: AppLocalizations.of(context)!.go_back_button,
                            mainAxisAlignment: MainAxisAlignment.center,
                            verticalPadding: 14,
                            onTap: () {
                              homeProvider.homePageRefresh(
                                  mainProvider.accessToken,
                                  mainProvider.cafeteriaId,
                                  int.parse(mainProvider.studentId),
                                  mainProvider.userType,
                                  mainProvider.userType == UserRole.tutor
                                      ? false
                                      : mainProvider
                                              .selectedChild?.isIndependent ??
                                          false);
                              mainProvider.loadCafeteriaSetting();
                              mainProvider.loadBalance();
                              /*
                              if(mainProvider.userType=="Tutor"){
                                mainProvider.loadDebtorsChildren();
                              }*/
                              mainProvider.loadDebtorsChildren();
                              historyProvider.initialLoad(
                                  mainProvider.accessToken,
                                  mainProvider.cafeteriaId,
                                  int.parse(mainProvider.studentId),
                                  mainProvider.userType);
                              if (mainProvider.userType == UserRole.tutor &&
                                  (homeProvider.cafeteria?.school.country ??
                                          "") ==
                                      Contries.panama) {
                                Navigator.of(context).popUntil(
                                  ModalRoute.withName(router.panamaHome),
                                );
                              } else if (mainProvider.userType ==
                                      UserRole.student &&
                                  mainProvider.selectedChild!.isIndependent) {
                                Navigator.of(context).popUntil(
                                  ModalRoute.withName(
                                      router.independentHomeRoute),
                                );
                              } else {
                                Navigator.of(context).popUntil(
                                  ModalRoute.withName(router.homeRoute),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Text(
                          AppLocalizations.of(context)!.order_completed,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .purchase_successfully_mesage,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white.withOpacity(0.75),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
