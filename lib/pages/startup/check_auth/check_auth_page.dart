import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multiple_sale_provider.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multisale_products_provider.dart';
import 'package:smart_lunch/pages/preferences/lang/languaje_provider.dart';
import 'package:smart_lunch/pages/providers.dart';
import 'package:smart_lunch/pages/startup/loading/loading_page.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/roles.dart';

class CheckAuthPage extends StatelessWidget {
  const CheckAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StorageProvider storageProvider = Provider.of<StorageProvider>(
      context,
      listen: false,
    );
    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );
    HomeProvider homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );
    ProductsProvider productsProvider = Provider.of<ProductsProvider>(
      context,
      listen: false,
    );
    MultisaleProductsProvider multisaleProductsProvider =
        Provider.of<MultisaleProductsProvider>(
      context,
      listen: false,
    );
    CardsInfoProvider cardsInfoProvider = Provider.of<CardsInfoProvider>(
      context,
      listen: false,
    );
    AllergyProvider allergyProvider = Provider.of<AllergyProvider>(
      context,
      listen: false,
    );

    HistoryProvider historyProvider = Provider.of<HistoryProvider>(
      context,
      listen: false,
    );

    LanguageProvider languajeProvider = Provider.of<LanguageProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      body: FutureBuilder(
        future: mainProvider.isSessionValid(storageProvider, languajeProvider),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const LoadingPage();
          } else if (snapshot.data == false) {
            Future.delayed(
              const Duration(seconds: 0),
              () {
                Navigator.of(context).pushReplacementNamed(router.loginRoute);
              },
            );
          } else {
            Future.wait(
              [
                homeProvider.loadCafeteria(mainProvider.accessToken, mainProvider, storageProvider),
                mainProvider.getCafeteria(storageProvider),
                mainProvider.checkAppVersion(),
                mainProvider.getChildren(),
                mainProvider.getTutorInfo(mainProvider.userType),
                mainProvider.createOpenPayCustomer(),
                mainProvider.loadDebtorsChildren(),
                mainProvider.loadCafeteriaSetting(),
                mainProvider.loadBalance(),
              ],
            ).then((List<dynamic> responses) async {
              await homeProvider.initialLoad(
                  mainProvider.accessToken,
                  mainProvider.cafeteriaId,
                  int.parse(mainProvider.studentId),
                  mainProvider.userType,
                  mainProvider.userType == UserRole.tutor
                      ? false
                      : mainProvider.selectedChild?.isIndependent ?? false);
              cardsInfoProvider.getOpenPayCredentials(
                  mainProvider.accessToken, mainProvider.cafeteriaId);

              if (mainProvider.userType == UserRole.tutor ||
                  mainProvider.userType == UserRole.teacher) {
                cardsInfoProvider.getTutorOpenPayAccount(
                  mainProvider.accessToken,
                  mainProvider.cafeteriaId,
                  mainProvider.saveTutorOpenPayId,
                );
              }
              if (mainProvider.userType == UserRole.student) {
                cardsInfoProvider.getTutorOpenPayAccount(
                  mainProvider.accessToken,
                  mainProvider.cafeteriaId,
                  mainProvider.saveStudentOpenPayId,
                );
              }
              allergyProvider.getAllergies(
                mainProvider.accessToken,
                mainProvider.cafeteriaId,
              );
              productsProvider.initialLoad(
                mainProvider.accessToken,
                mainProvider.cafeteriaId,
                (homeProvider.cafeteria?.school.country ?? "") ==
                    Contries.panama,
              );

              multisaleProductsProvider.initialLoad(
                  mainProvider.accessToken,
                  mainProvider.cafeteriaId,
                  (homeProvider.cafeteria?.school.country ?? "") ==
                      Contries.panama,
                  DateTime.now());

              historyProvider.initialLoad(
                  mainProvider.accessToken,
                  mainProvider.cafeteriaId,
                  int.parse(mainProvider.studentId),
                  mainProvider.userType);


                  print("Permission ${mainProvider.userType} ${homeProvider.cafeteria?.school.country}");

              if (mainProvider.userType == UserRole.tutor &&
                  (homeProvider.cafeteria?.school.country ?? "") ==
                      Contries.panama) {
                Navigator.of(context).pushReplacementNamed(router.panamaHome);
              }
              else if (mainProvider.userType == UserRole.tutor) {
                Navigator.of(context).pushReplacementNamed(router.homeRoute);
              } else if (mainProvider.userType == UserRole.student) {
                if (mainProvider.selectedChild!.isIndependent) {
                  if (cardsInfoProvider.cards.isEmpty) {
                    cardsInfoProvider.getCardList(
                      mainProvider.accessToken,
                      mainProvider.cafeteriaId,
                    );
                  }
                  Navigator.of(context)
                      .pushReplacementNamed(router.independentHomeRoute);
                } else {
                  Navigator.of(context).pushReplacementNamed(router.homeRoute);
                }
              } else if (mainProvider.userType == UserRole.teacher) {
                Navigator.of(context)
                    .pushReplacementNamed(router.independentHomeRoute);
              }
            });
          }
          return const LoadingPage();
        },
      ),
    );
  }
}
