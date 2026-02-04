import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/main.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({
    required this.controller,
    super.key,
  });

  final WebViewController controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;
  AppLocalizations? appLocalizations;

  @override
  void initState() {
    super.initState();
    CardsInfoProvider cardsInfoProvider = Provider.of<CardsInfoProvider>(
      context,
      listen: false,
    );
    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );

    widget.controller.setNavigationDelegate(
      NavigationDelegate(onPageStarted: (url) {
        developer.log(url, name: "onPageStarted");
        setState(() {
          loadingPercentage = 0;
        });
      }, onProgress: (progress) {
        setState(() {
          loadingPercentage = progress;
        });
      }, onPageFinished: (url) {
        developer.log(url, name: "onPageFinished");
        setState(() {
          loadingPercentage = 100;
        });
      }, onNavigationRequest: (navigation) {
        cardsInfoProvider
            .confirm3dSecure(
          mainProvider.accessToken,
          mainProvider.cafeteriaId,
          Uri.parse(navigation.url).queryParameters["id"].toString(),
          appLocalizations,
        )
            .then(
          (value) {
            mainProvider.getFamilyBalance();
          },
        );
        navigatorKey.currentState?.pop();
        return NavigationDecision.prevent;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);

    return Stack(
      children: [
        WebViewWidget(
          controller: widget.controller,
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
          ),
      ],
    );
  }
}
