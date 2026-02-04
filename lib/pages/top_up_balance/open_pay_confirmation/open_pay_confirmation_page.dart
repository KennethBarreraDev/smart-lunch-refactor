import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';

import 'components/components.dart';

class OpenPayConfirmationPage extends StatelessWidget {
  const OpenPayConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    CardsInfoProvider cardsInfoProvider = Provider.of<CardsInfoProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Lunch"),
        actions: [
          NavigationControls(
            controller: cardsInfoProvider.openPayController,
          ),
        ],
      ),
      body: WebViewStack(
        controller: cardsInfoProvider.openPayController,
      ),
    );
  }
}
