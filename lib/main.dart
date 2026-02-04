import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/children_info/child/child_provider.dart';
import 'package:smart_lunch/pages/home/time_provider.dart';
import 'package:smart_lunch/pages/panama/membership_modal/membership_provider.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multiple_sale_provider.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multisale_products_provider.dart';
import 'package:smart_lunch/pages/password_recovery/restore_password/restore_password_provider.dart';
import 'package:smart_lunch/pages/preferences/lang/languaje_provider.dart';
import 'package:smart_lunch/pages/providers.dart';
import 'package:smart_lunch/pages/top_up_mercado_pago/components/top_up_status_provider.dart';
import 'package:smart_lunch/pages/top_up_mercado_pago/top_up_provider.dart';
import 'package:smart_lunch/routes/router.dart' as router;

@pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
  
//   developer.log(
//     "Handling a background message: ${message.toString()}",
//     name: "_firebaseMessagingBackgroundHandler",
//   );
// }

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestorePasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CardsInfoProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CardsCroemProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SaleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TopUpProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AccountProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChildAccountProvider(),
        ),
        ChangeNotifierProvider(
          create: (cosntext) => ChangePasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CouponsProvider(),
        ),
        // Common providers
        ChangeNotifierProvider(
          create: (context) => MainProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MembershipProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => StorageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AllergyProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TimeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MultisaleProvider(),
        ),
         ChangeNotifierProvider(
          create: (context) => MultisaleProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TopUpStatusProvider(
              paymentId: '',
              merchantOrderId: '',
              externalReference: '',
              rechargeAmount: '',
              paymentMethod: '',
              folio: '',
              yappyFolio: ''
              ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
        builder: (context, languajeProvider, widget) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: const [
          Locale('en'), // English
          Locale('es'), // Spanish
        ],
        locale: languajeProvider.locale,
        title: "Smart Lunch",
        initialRoute: router.checkAuthRoute,
        onGenerateRoute: router.controller,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Comfortaa"),
      );
    });
  }
}
