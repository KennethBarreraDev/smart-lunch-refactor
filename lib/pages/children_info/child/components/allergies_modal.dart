import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/widgets/labeled_checkbox.dart';
import 'package:smart_lunch/widgets/modal_action_button.dart';

class AllergiesModal extends StatelessWidget {
  const AllergiesModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: false,
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      insetPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      titleTextStyle: const TextStyle(
        fontSize: 24.0,
        color: Color(0xff413931),
        fontFamily: "Comfortaa",
      ),
      title: Text(
        AppLocalizations.of(context)!.allergies_message,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: 56,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: SingleChildScrollView(
                child: Column(

                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /*
                Consumer<MainProvider>(
                    builder: (context, mainProvider, widget) => CustomBanner(
                    bannerType: mainProvider.allergyUpdateBannerType,
                    bannerMessage: mainProvider.allergyUpdateBannerMessage,
                    hideBanner: mainProvider.hideAllergyUpdateBanner,
                  )
                ),*/
                    Consumer2<AllergyProvider, MainProvider>(
                      builder:
                          (context, allergyProvider, mainProvider, widget) =>
                              ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.3,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: allergyProvider.allergies.isNotEmpty
                              ? [
                                  const Divider(),
                                  Text(
                                    AppLocalizations.of(context)!.common_allergies,
                                    style: const TextStyle(
                                      color: Color(0xff413931),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Comfortaa",
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: allergyProvider.allergies
                                            .map(
                                              (allergy) => LabeledCheckbox(
                                                label: allergy.name,
                                                value: mainProvider
                                                        .selectedChild
                                                        ?.allergies
                                                        .contains(allergy.id) ??
                                                    false,
                                                id: allergy.id,
                                                onChanged:
                                                    mainProvider.changeAllergy,
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  )
                                ]
                              : [],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.other_allergies,
                      style: const TextStyle(
                        color: Color(0xff413931),
                        fontWeight: FontWeight.w700,
                        fontFamily: "Comfortaa",
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Consumer<MainProvider>(
                      builder: (context, mainProvider, widget) => TextFormField(
                        controller: mainProvider.otherAllergiesController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          hintText: AppLocalizations.of(context)!.none_message,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<MainProvider>(
                  builder: (context, mainProvider, widget) => ModalActionButton(
                    backgroundColor: const Color(0xff21a76f).withOpacity(0.15),
                    primaryColor: const Color(0xff21a76f),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        mainProvider.saveAllergies(
                          AppLocalizations.of(context),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    text: AppLocalizations.of(context)!.save_button,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
