import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';

import 'components/child_card.dart';

class ChildrenListPage extends StatelessWidget {
  const ChildrenListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransparentScaffold(
      selectedOption: "Hijos",
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CustomAppBar(
                  height: 240,
                  showPageTitle: true,
                  pageTitle: AppLocalizations.of(context)!.children,
                  image: images.appBarShortImg,
                  titleAlignment: Alignment.centerLeft,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 180,
                  ),
                  child: Consumer<MainProvider>(
                    builder: (context, mainProvider, widget) => ListView(
                      shrinkWrap: false,
                      padding: EdgeInsets.zero,
                      children: mainProvider.children
                          .map(
                            (child) => ChildCard(
                              membershipExpiration: (child.membership && child.membershipExpiration!=null ) ? (child.membershipExpiration ?? "") : "",
                              imageUrl: child.imageUrl,
                              childName: "${child.childName} ${child.childLastName}",
                              registrationNumber: child.registrationNumber,
                              id: child.id.toString(),
                              status: child.status,
                              onTap: () {
                                mainProvider.selectChild(child);
                                Navigator.of(context)
                                    .pushNamed(router.childRoute);
                              },
                            ),
                          )
                          .toList(),
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
