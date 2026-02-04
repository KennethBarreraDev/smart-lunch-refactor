import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/pages/home/components/rounded_button.dart';
import 'package:smart_lunch/pages/providers.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_graphics/vector_graphics.dart';

class SuccessfulPreSalePage extends StatelessWidget {
  const SuccessfulPreSalePage({Key? key}) : super(key: key);

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

    return TransparentScaffold(
      selectedOption: "Inicio",
      showDrawer: false,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    const CustomAppBar(
                      height: 200,
                      showPageTitle: false,
                      showDrawer: false,
                      image: images.appBarLongImg,
                      titleTopPadding: 0.3,
                      secondaryColor: true,
                    ),
                    const SizedBox(
                      height: 27,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Expanded(
                              flex: 2,
                              child: SvgPicture(
                                AssetBytesLoader(images.successfulSaleImage),
                                semanticsLabel: "successfulSaleImage",
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(
                              height: 56,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: colors.tuitionGreen.withOpacity(0.05),
                                border: Border.all(
                                  color: colors.tuitionGreen,
                                  width: 2,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 24,
                                horizontal: 12,
                              ),
                              margin: const EdgeInsets.only(
                                bottom: 50,
                              ),
                              child: Consumer<SaleProvider>(
                                builder: (context, saleProvider, widget) =>
                                    Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            style: const TextStyle(
                                              color: colors.darkBlue,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16.0,
                                            ),
                                            text: AppLocalizations.of(context)!.the_order,
                                          ),
                                          TextSpan(
                                            style: const TextStyle(
                                              color: colors.darkBlue,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.0,
                                            ),
                                            text: saleProvider.successfulSaleId
                                                .substring(
                                                    saleProvider
                                                            .successfulSaleId
                                                            .length -
                                                        13,
                                                    saleProvider
                                                            .successfulSaleId
                                                            .length -
                                                        1),
                                          ),
                                        TextSpan(
                                            style: const TextStyle(
                                              color: colors.darkBlue,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16.0,
                                            ),
                                            text: AppLocalizations.of(context)!.will_be_ready_message,
                                          ),
                                          TextSpan(
                                            style: const TextStyle(
                                              color: colors.darkBlue,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.0,
                                            ),
                                            text: saleProvider
                                                .successfulSaleChild,
                                          ),
                                          TextSpan(
                                            style: const TextStyle(
                                              color: colors.darkBlue,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16.0,
                                            ),
                                            text: AppLocalizations.of(context)!.on_message,
                                          ),
                                          TextSpan(
                                            style: const TextStyle(
                                              color: colors.darkBlue,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.0,
                                            ),
                                            text:
                                                saleProvider.successfulSaleDate,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 11,
                                    ),
                                    DottedLine(
                                      dashColor: Colors.black.withOpacity(0.15),
                                      dashGapLength: 6,
                                      dashLength: 6,
                                    ),
                                    const SizedBox(
                                      height: 11,
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
                                          ),
                                        ),
                                        Text(
                                          "\$${saleProvider.successfulSaleCharge} ${(homeProvider.cafeteria?.school.country ?? "") == Contries.panama ? " USD" : " MXN"}",
                                          style: const TextStyle(
                                            color: colors.darkBlue,
                                            fontSize: 24.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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
                                         Navigator.of(context)
                                    .pushReplacementNamed(router.panamaHome);
                                      }   

                                else if (mainProvider.userType == UserRole.student &&
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
                           AppLocalizations.of(context)!.purchase_successfully_mesage,
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
          ),
        ],
      ),
    );
  }
}
