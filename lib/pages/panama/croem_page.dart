import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/pages/home/menu_preview/components/web_view_stack.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/custom_banner.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';

class CroemPage extends StatelessWidget {
  const CroemPage({super.key});

  @override
  Widget build(BuildContext context) {
    CardsCroemProvider croemCardsInfoProvider = Provider.of<CardsCroemProvider>(
      context,
      listen: false,
    );

    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );

    croemCardsInfoProvider.croemController
        .loadFlutterAsset("assets/web/index.html");
    croemCardsInfoProvider.croemController.addJavaScriptChannel(
      'Flutter',
      onMessageReceived: (message) {
        Map<String, dynamic> response = jsonDecode(message.message);

        if (response["ResponseCode"] != null &&
            response["ResponseCode"] == "T00") {
          croemCardsInfoProvider.registerCard(
            response["TokenDetails"]["AccountToken"],
            mainProvider.tutor?.userId ?? "",
            response["TokenDetails"]["CardNumber"],
            response["TokenDetails"]["CardHolderName"],
            "Test",
            mainProvider.accessToken,
            mainProvider.cafeteriaId,
            AppLocalizations.of(context),
          );
        }
      },
    );
    // croemCardsInfoProvider.croemController.runJavaScript(
    //   "document.getElementById('apiKey').innerText=\"q9CZkq18RMjJ\"",
    // );

    return TransparentScaffold(
      selectedOption: "Promociones",
      body: Column(
        children: [
          const CustomAppBar(
            height: 140,
            showPageTitle: true,
            pageTitle: "Nueva tarjeta",
            titleAlignment: Alignment.bottomRight,
            image: images.appBarShortImg,
            showDrawer: false,
            titleSize: 24,
          ),
        Container(
            color: Colors.white,
            height: 30,),
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 7,
                        child: WebViewStack(
                            controller: croemCardsInfoProvider.croemController),
                      ),
                      Flexible(
                        flex: 2,
                        child: Image.asset(images.croemSupport),
                      )
                    ],
                  ),
                ),
                Consumer<CardsCroemProvider>(
                  builder: (context, croemInfoProvider, widget) => CustomBanner(
                    bannerType: croemInfoProvider.cardRegisterBannerType,
                    bannerMessage: croemInfoProvider.cardRegisterBannerMessage,
                    hideBanner: croemInfoProvider.hideRegisterBanner,
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

// class CroemPage extends StatelessWidget {
//   const CroemPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('InAppWebView Example'),
//         ),
//         body: FutureBuilder<WebViewController>(
//           future: _initializeController(),
//           builder: (BuildContext context,
//               AsyncSnapshot<WebViewController> snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               snapshot.data!.runJavaScript(
//                 "document.getElementById('apiKey').innerText=\"q9CZkq18RMjJ\"",
//               );
//               return WebViewWidget(controller: snapshot.data!);
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.send),
//           onPressed: () {},
//         ),
//       ),
//     );
//   }
// }
