import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/models/successful_openpay_recharge.dart';
import 'package:smart_lunch/pages/home/components/rounded_button.dart';
import 'package:smart_lunch/pages/providers.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';

class MembershipSuccessPage extends StatelessWidget {
  const MembershipSuccessPage({super.key});

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

    SuccessfulRecharge pageArguments =
        ModalRoute.of(context)?.settings.arguments as SuccessfulRecharge;

    /*
    SuccessfulSaleArguments successfulSaleArguments =
    ModalRoute.of(context)?.settings.arguments as SuccessfulSaleArguments;*/

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
                          SizedBox(
                            height: 150,
                            child: SvgPicture.asset(
                              pageArguments.rechargeStatus == "APPROVED"
                                  ? images.successRecharge
                                  : images.errorRecharge,
                              semanticsLabel: "successRecharge",
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .subtotal,
                                          style: const TextStyle(
                                              color: colors.darkBlue,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              fontFamily: "Comfortaa"),
                                        ),
                                        Consumer<HomeProvider>(builder:
                                            (context, homeProvider, child) {
                                          return RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: pageArguments.amount,
                                                  style: const TextStyle(
                                                      color: colors.darkBlue,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                      fontFamily: "Comfortaa"),
                                                ),
                                                TextSpan(
                                                  text: (homeProvider
                                                                  .cafeteria
                                                                  ?.school
                                                                  .country ??
                                                              "") ==
                                                          Contries.panama
                                                      ? " USD"
                                                      : " MXN",
                                                  style: const TextStyle(
                                                    color: colors.darkBlue,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .bank_fee,
                                          style: const TextStyle(
                                              color: colors.darkBlue,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              fontFamily: "Comfortaa"),
                                        ),
                                        Consumer<HomeProvider>(builder:
                                            (context, homeProvider, child) {
                                          return RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: (double.parse(
                                                              pageArguments
                                                                  .amount) *
                                                          (3.5 / 100))
                                                      .toStringAsFixed(2),
                                                  style: const TextStyle(
                                                      color: colors.darkBlue,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                      fontFamily: "Comfortaa"),
                                                ),
                                                TextSpan(
                                                  text: (homeProvider
                                                                  .cafeteria
                                                                  ?.school
                                                                  .country ??
                                                              "") ==
                                                          Contries.panama
                                                      ? " USD"
                                                      : " MXN",
                                                  style: const TextStyle(
                                                    color: colors.darkBlue,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    Divider(color: Colors.grey.withOpacity(0.4),),
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .total_price,
                                          style: const TextStyle(
                                              color: colors.darkBlue,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 21.0,
                                              fontFamily: "Comfortaa"),
                                        ),
                                        Consumer<HomeProvider>(builder:
                                            (context, homeProvider, child) {
                                          return RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: (double.parse(
                                                              pageArguments
                                                                  .amount) +
                                                          double.parse(
                                                                  pageArguments
                                                                      .amount) *
                                                              (3.5 / 100))
                                                      .toStringAsFixed(2),
                                                  style: const TextStyle(
                                                      color: colors.darkBlue,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 24.0,
                                                      fontFamily: "Comfortaa"),
                                                ),
                                                TextSpan(
                                                  text: (homeProvider
                                                                  .cafeteria
                                                                  ?.school
                                                                  .country ??
                                                              "") ==
                                                          Contries.panama
                                                      ? " USD"
                                                      : " MXN",
                                                  style: const TextStyle(
                                                    color: colors.darkBlue,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),

                                    //+ (mainProvider.membershipTotalPrice * (3.5/100))
                                  ],
                                ),
                              ),
                              ...mainProvider.membershipDebtors
                                  .where((debtors) => mainProvider
                                      .membershipCart.keys
                                      .toList()
                                      .contains(debtors.id))
                                  .map(
                                    (element) => Container(
                                      margin: const EdgeInsets.symmetric(vertical: 2),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.withOpacity(0.2)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: element
                                                            .imageUrl.isNotEmpty
                                                        ? NetworkImage(
                                                            element.imageUrl)
                                                        : const AssetImage(images
                                                                .defaultProfileStudentImage)
                                                            as ImageProvider<
                                                                Object>,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${element.childName} ${element.childLastName}",
                                                    style: const TextStyle(
                                                        color: colors.darkBlue,
                                                        fontSize: 16,
                                                        fontFamily: "Comfortaa",
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "${AppLocalizations.of(context)!.membership_message}: ${mainProvider.membershipCart[element.id]}",
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: "Comfortaa",
                                                        color: colors.darkBlue),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "\$${((mainProvider.membershipCart[element.id] ?? 0) * 1.20).toStringAsFixed(2)}",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "Comfortaa",
                                                      color: colors.darkBlue),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
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
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    router.panamaHome,
                                    (Route<dynamic> route) => false);
                              } else if (mainProvider.userType ==
                                  UserRole.tutor) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    router.homeRoute,
                                    (Route<dynamic> route) => false);
                              } else {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    router.independentHomeRoute,
                                    (Route<dynamic> route) => false);
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
                          height: 60,
                        ),
                        Text(
                          pageArguments.rechargeStatus == "APPROVED"
                              ? AppLocalizations.of(context)!
                                  .payment_completed
                              : AppLocalizations.of(context)!.try_again_later,
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
        )));
  }
}
