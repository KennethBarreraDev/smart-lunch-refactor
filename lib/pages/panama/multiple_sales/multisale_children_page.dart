import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/main_provider.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/child_components/multisale_child_page.dart';

import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multiple_sale_provider.dart';
import 'package:smart_lunch/pages/providers.dart';
import 'package:smart_lunch/routes/router.dart' as router;

class MultisaleChildrenPage extends StatelessWidget {
  const MultisaleChildrenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 2,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xffEF5360),
                Color(0xffFFA66A),
              ],
            )),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).maybePop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.chevron_left,
                                color: Colors.white,
                                size: 45,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                AppLocalizations.of(context)!.select_student,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.2,
            ),
            child: Consumer3<MainProvider, MultisaleProvider, HomeProvider>(
              builder: (context, mainProvider, multisaleProvider, homeProvider, widget) =>
                  ListView(
                shrinkWrap: false,
                padding: EdgeInsets.zero,
                children: mainProvider.children
                    .map(
                      (child) => MultisaleChildComponent(
                        imageUrl: child.imageUrl,
                        childName: "${child.childName} ${child.childLastName}",
                        dailySpendLimit: child.dailySpendLimit,
                        allergies: child.allergies,
                        onTap: () {
                          multisaleProvider.resetValues();
                          multisaleProvider.changeSelectedChild(child);
                          multisaleProvider.setCurrentBalance(double.tryParse(mainProvider.familyBalance) ?? 0);
                          multisaleProvider.generateSaleDays(homeProvider.cafeteria?.school.country ?? "");
                          Navigator.of(context).pushNamed(
                            router.multisaleCalendarRoute,
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
