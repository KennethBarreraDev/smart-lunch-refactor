import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/models/register_card_page_arguments.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/custom_banner.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';

import 'components/components.dart';

class RegisterCardPage extends StatelessWidget {
  const RegisterCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: false);

    RegisterCardPageArguments registerCardPageArguments =
        ModalRoute.of(context)?.settings.arguments as RegisterCardPageArguments;

    return TransparentScaffold(
      selectedOption: "Colegiaturas",
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAppBar(
            height: 160,
            showPageTitle: true,
            pageTitle: registerCardPageArguments.isNewCard
                ? AppLocalizations.of(context)!.register_card
                : AppLocalizations.of(context)!.update_card,
            image: images.appBarShortImg,
            showDrawer: false,
          ),
          const SizedBox(
            height: 9,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Consumer<CardsInfoProvider>(
                          builder: (context, cardsInfoProvider, widget) =>
                              Column(
                            children: [
                              FractionallySizedBox(
                                widthFactor: 1,
                                child: TextFormField(
                                  controller:
                                      cardsInfoProvider.holderNameController,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!
                                        .owner_full_name,
                                    border: const OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: TextFormField(
                                      maxLength: 16,
                                      enabled:
                                          registerCardPageArguments.isNewCard,
                                      onChanged:
                                          cardsInfoProvider.onCardNumberChange,
                                      controller: cardsInfoProvider
                                          .cardNumberController,
                                      decoration: InputDecoration(
                                        labelText: AppLocalizations.of(context)!
                                            .card_number,
                                        border: const OutlineInputBorder(),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  const Spacer(),
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxWidth: 65,
                                      maxHeight: 41,
                                    ),
                                    child:
                                        cardsInfoProvider.cardBrand.isNotEmpty
                                            ? Image.asset(
                                                images.getCardBrandImage(
                                                  cardsInfoProvider.cardBrand,
                                                ),
                                              )
                                            : Container(),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: ExpirationDateField(
                                      expirationMonthController:
                                          cardsInfoProvider
                                              .expirationMonthController,
                                      expirationYearController:
                                          cardsInfoProvider
                                              .expirationYearController,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: TextFormField(
                                        enabled:
                                            registerCardPageArguments.isNewCard,
                                        controller:
                                            cardsInfoProvider.cvv2Controller,
                                        decoration: const InputDecoration(
                                          labelText: "CVV",
                                          border: OutlineInputBorder(),
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(
                                              4), 
                                          FilteringTextInputFormatter
                                              .digitsOnly, 
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: !cardsInfoProvider.isRegisteringCard
                                      ? const EdgeInsets.symmetric(
                                          vertical: 11,
                                        )
                                      : const EdgeInsets.symmetric(
                                          vertical: 5,
                                        ),
                                  backgroundColor:
                                      colors.tuitionGreen.withOpacity(0.15),
                                  shadowColor: Colors.transparent,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (registerCardPageArguments.isNewCard) {
                                    if (!cardsInfoProvider.isRegisteringCard) {
                                      cardsInfoProvider.registerCard(
                                        mainProvider.accessToken,
                                        mainProvider.cafeteriaId,
                                        mainProvider.tutor?.openPayId ?? "",
                                        AppLocalizations.of(context),
                                      );
                                    }
                                  } else {
                                    if (!cardsInfoProvider.isUpdatingCard) {
                                      cardsInfoProvider.updateCard(
                                        mainProvider.accessToken,
                                        mainProvider.cafeteriaId,
                                        mainProvider.tutor?.openPayId ?? "",
                                        AppLocalizations.of(context),
                                      );
                                    }
                                  }
                                },
                                child: !cardsInfoProvider.isRegisteringCard
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.add_card,
                                            color: colors.tuitionGreen,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            registerCardPageArguments.isNewCard
                                                ? AppLocalizations.of(context)!
                                                    .register_button
                                                : AppLocalizations.of(context)!
                                                    .update_card,
                                            style: const TextStyle(
                                              color: colors.tuitionGreen,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            color: colors.tuitionGreen,
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: const Color(0xFF346DBE).withOpacity(0.1),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Transacciones realizadas vía",
                          style: TextStyle(
                            color: colors.darkBlue,
                            fontWeight: FontWeight.w300,
                            fontSize: 12.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 112,
                            maxHeight: 32,
                          ),
                          child: Image.asset(images.openpayColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const CreditCardRow(),
                        const DebitCardsRow(),
                        const Divider(),
                        const SizedBox(
                          height: 23,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.support_agent,
                              color: Color(0xFF346DBE),
                            ),
                            Text(
                              AppLocalizations.of(context)!.support_message,
                              style: const TextStyle(
                                color: Color(0xff346dbe),
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          "contacto@smartschool.mx",
                          style: TextStyle(
                            color: Color(0xff346dbe),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Consumer<CardsInfoProvider>(
                    builder: (context, cardsInfoProvider, widget) =>
                        CustomBanner(
                      bannerType: cardsInfoProvider.cardRegisterBannerType,
                      bannerMessage:
                          cardsInfoProvider.cardRegisterBannerMessage,
                      hideBanner: cardsInfoProvider.hideRegisterBanner,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
