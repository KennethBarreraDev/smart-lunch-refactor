import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';

import 'components/components.dart';

class MenuPreviewPage extends StatelessWidget {
  const MenuPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        actions: [
          NavigationControls(
            controller: homeProvider.filePreviewController,
          ),
        ],
      ),
      body: WebViewStack(
        controller: homeProvider.filePreviewController,
      ),
    );
  }
}
