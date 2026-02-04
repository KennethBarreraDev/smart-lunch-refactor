import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:smart_lunch/pages/history/history_provider.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/pages/login/components/components.dart';
import 'package:smart_lunch/pages/login/login_provider.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multiple_sale_provider.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multiple_sale_provider.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multisale_products_provider.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/login_base_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StorageProvider storageProvider = Provider.of<StorageProvider>(
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

    //final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    return LoginBasePage(
      title: AppLocalizations.of(context)!.login,
      bodyConsumer: Consumer<LoginProvider>(
        builder: (context, loginProvider, widget) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoginInput(
              labelText: AppLocalizations.of(context)!.email,
              textInputType: TextInputType.emailAddress,
              textEditingController: loginProvider.usernameController,
            ),
            const SizedBox(
              height: 48,
            ),
            LoginInput(
              labelText: AppLocalizations.of(context)!.password,
              textInputType: TextInputType.visiblePassword,
              obscurePassword: loginProvider.obscurePassword,
              onVisibilityChange: loginProvider.changePasswordVisibility,
              textEditingController: loginProvider.passwordController,
            ),
            // const SizedBox(
            //   height: 24,
            // ),
            if (loginProvider.hasLoginError)
              Container(
                color: const Color(0xffef5360).withOpacity(0.25),
                padding: const EdgeInsets.symmetric(vertical: 7),
                margin: const EdgeInsets.only(top: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Icon(
                        Icons.shield,
                        color: Color(0xffef5360),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        AppLocalizations.of(context)!.login_error,
                        style: const TextStyle(
                          color: Color(0xffef5360),
                          fontSize: 14,
                          fontFamily: "Comfortaa",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(
              height: 40,
            ),
            Consumer<MainProvider>(
              builder: (context, mainProvider, widget) => LoginButton(
                text: AppLocalizations.of(context)!.login,
                isEnabled: !loginProvider.isLoading,
                isLoading: loginProvider.isLoading,
                onPressed: () {
                  // Navigator.of(context).pushReplacementNamed(router.homeRoute);
                  loginProvider.login(mainProvider, storageProvider).then(
                    (userType) {
                      developer.log(userType.toString(),
                          name: "login_buttonResponse");

                      mainProvider.updateLoginInfo(storageProvider).then(
                        (value) {
                          // firebaseMessaging.getToken().then(
                          //       (token) => developer.log(
                          //         token ?? "Token error",
                          //         name: "firebase_token",
                          //       ),
                          //     );

                          // firebaseMessaging.requestPermission(
                          //   alert: true,
                          //   announcement: true,
                          //   badge: true,
                          //   carPlay: true,
                          //   criticalAlert: true,
                          //   provisional: true,
                          //   sound: true,
                          // );
                          Future.wait([
                            homeProvider.loadCafeteria(mainProvider.accessToken,
                                mainProvider, storageProvider),
                            mainProvider.checkAppVersion(),
                            mainProvider.getChildren(),
                            mainProvider.getTutorInfo(mainProvider.userType),
                            mainProvider.createOpenPayCustomer(),
                            mainProvider.loadDebtorsChildren(),
                            mainProvider.loadCafeteriaSetting(),
                            mainProvider.loadBalance()
                          ]).then(
                            (List<dynamic> responses) async {
                              await homeProvider.initialLoad(
                                  mainProvider.accessToken,
                                  mainProvider.cafeteriaId,
                                  int.tryParse(mainProvider.studentId) ?? 0,
                                  mainProvider.userType,
                                  mainProvider.userType == UserRole.tutor
                                      ? false
                                      : mainProvider
                                              .selectedChild?.isIndependent ??
                                          false);
                              cardsInfoProvider.getOpenPayCredentials(
                                  mainProvider.accessToken,
                                  mainProvider.cafeteriaId);
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
                                  mainProvider.cafeteriaId);
                              productsProvider.initialLoad(
                                mainProvider.accessToken,
                                mainProvider.cafeteriaId,
                                (homeProvider.cafeteria?.school.country ??
                                        "") ==
                                    Contries.panama,
                              );

                              multisaleProductsProvider.initialLoad(
                                  mainProvider.accessToken,
                                  mainProvider.cafeteriaId,
                                  (homeProvider.cafeteria?.school.country ??
                                          "") ==
                                      Contries.panama,
                                  DateTime.now());

                              historyProvider.initialLoad(
                                  mainProvider.accessToken,
                                  mainProvider.cafeteriaId,
                                  int.parse(mainProvider.studentId),
                                  mainProvider.userType);

                              loginProvider.resetLoadingButton();

                              if (userType == UserRole.tutor &&
                                  (homeProvider.cafeteria?.school.country ??
                                          "") ==
                                      Contries.panama) {
                                Navigator.of(context)
                                    .pushReplacementNamed(router.panamaHome);
                              } else if (userType == UserRole.tutor) {
                                Navigator.of(context)
                                    .pushReplacementNamed(router.homeRoute);
                              } else if (userType == UserRole.student) {
                                if (mainProvider.selectedChild!.isIndependent) {
                                  if (cardsInfoProvider.cards.isEmpty) {
                                    cardsInfoProvider.getCardList(
                                        mainProvider.accessToken,
                                        mainProvider.cafeteriaId);
                                  }
                                  Navigator.of(context).pushReplacementNamed(
                                      router.independentHomeRoute);
                                } else {
                                  Navigator.of(context)
                                      .pushReplacementNamed(router.homeRoute);
                                }
                              } else if (userType == UserRole.teacher) {
                                Navigator.of(context).pushReplacementNamed(
                                    router.independentHomeRoute);
                              }
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(router.restorePasswordRoute);
                },
                child: Text(
                  AppLocalizations.of(context)!.reset_password,
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color(0xff323232),
                    fontWeight: FontWeight.w300,
                    fontSize: 12.0,
                    fontFamily: "Comfortaa",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        router.termsAndCondition,
                      );
                      /*
                      launchUrl(
                        Uri.parse(
                          "https://app.smartlunch.mx/terms-and-conditions",
                        ),
                        mode: LaunchMode.inAppWebView,
                      );*/
                    },
                    child: Text(
                      AppLocalizations.of(context)!.terms_and_conditions,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff323232),
                        fontWeight: FontWeight.w300,
                        fontSize: 12.0,
                        fontFamily: "Comfortaa",
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        router.privacityPolicy,
                      );
                      /*
                      launchUrl(
                        Uri.parse(
                          "https://app.smartlunch.mx/political-privacy",
                        ),
                        mode: LaunchMode.inAppWebView,
                      );*/
                    },
                    child: Text(
                      AppLocalizations.of(context)!.political_privacy,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff323232),
                        fontWeight: FontWeight.w300,
                        fontSize: 12.0,
                        fontFamily: "Comfortaa",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  AppLocalizations.of(context)!.contact,
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color(0xff323232),
                    fontWeight: FontWeight.w300,
                    fontSize: 12.0,
                    fontFamily: "Comfortaa",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
