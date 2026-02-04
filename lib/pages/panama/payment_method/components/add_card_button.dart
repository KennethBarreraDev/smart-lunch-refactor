import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/models/register_card_page_arguments.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/providers.dart';
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/colors.dart' as colors;

class AddCardButton extends StatefulWidget {
  const AddCardButton({super.key});

  @override
  State<AddCardButton> createState() => _AddCardButtonState();
}

class _AddCardButtonState extends State<AddCardButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<HomeProvider, CardsCroemProvider, MainProvider>(builder:
        (context, homeProvider, cardsCroemProvider, mainProvider, child) {
      return ((!cardsCroemProvider.isUpdatingMainCardForSale &&
              cardsCroemProvider.cards.length < 3))
          ? Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 8),
              child: Container(
                padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: () {
                    if (mainProvider.userType == UserRole.tutor &&
                        (homeProvider.cafeteria?.school.country ?? "") ==
                            Contries.panama) {
                      Navigator.of(context)
                          .pushNamed(router.createCroemCardRoute);
                    } else {
                      Navigator.pushNamed(
                        context,
                        router.registerCardRoute,
                        arguments: RegisterCardPageArguments(
                          isNewCard: true,
                        ),
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add_card_outlined,
                        color: colors.lightBlue,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        AppLocalizations.of(context)!.add_card,
                        style: const TextStyle(color: colors.lightBlue),
                      ),
                    ],
                  ),
                ),
              ))
          : Container();
    });
  }
}
