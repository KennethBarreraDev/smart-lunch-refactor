import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class MercadoPagoPage extends StatelessWidget {
  const MercadoPagoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: TextButton(
            child: const Text('Show Flutter homepage'),
            onPressed: () => (){}
          ),
        ),
      ),
    );
  }

  // void _launchURL(BuildContext context) async {


  //   try {
  //     await launch(
  //       'https://www.mercadopago.com.mx/developers/es/docs/checkout-pro/integrate-checkout-pro/mobile/android/flutter',
  //       customTabsOption: CustomTabsOption(
  //         toolbarColor: Theme.of(context).primaryColor,
  //         enableDefaultShare: true,
  //         enableUrlBarHiding: true,
  //         showPageTitle: true,
  //         animation: CustomTabsSystemAnimation.slideIn(),
  //         // or user defined animation.
  //         /*
  //         animation: const CustomTabsSystemAnimation(
  //           startEnter: 'slide_up',
  //           startExit: 'android:anim/fade_out',
  //           endEnter: 'android:anim/fade_in',
  //           endExit: 'slide_down',
  //         ),*/
  //         extraCustomTabs: const <String>[
  //           // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
  //           'org.mozilla.firefox',
  //           // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
  //           'com.microsoft.emmx',
  //         ],
  //       ),
  //       safariVCOption: SafariViewControllerOption(
  //         preferredBarTintColor: Theme.of(context).primaryColor,
  //         preferredControlTintColor: Colors.white,
  //         barCollapsingEnabled: true,
  //         entersReaderIfAvailable: false,
  //         dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
  //       ),
  //     );
  //   } catch (e) {
  //     // An exception is thrown if browser app is not installed on Android device.
  //     debugPrint(e.toString());
  //   }
  // }


}