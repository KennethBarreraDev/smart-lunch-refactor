import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/modal_action_button.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_graphics/vector_graphics.dart';


class DeleteCardModal extends StatelessWidget {
  const DeleteCardModal({
    Key? key,
    required this.cardId,
    required this.cardNumber,
  }) : super(key: key);

  final String cardId;
  final String cardNumber;

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );

    HomeProvider homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.96836982,
      height: MediaQuery.of(context).size.height * 0.51312910,
      child: AlertDialog(
        scrollable: true,
        backgroundColor: colors.white,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        titleTextStyle: const TextStyle(
          color: colors.darkBlue,
          fontSize: 24.0,
          fontWeight: FontWeight.w300,
        ),
        title: Text(
          AppLocalizations.of(context)!.remove_card,
        ),
        content: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: 56,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Divider(),
                  const SvgPicture(
                    AssetBytesLoader(images.deleteCardModal),
                    semanticsLabel: "App bar",
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          style: const TextStyle(
                            color: colors.darkBlue,
                            fontWeight: FontWeight.w300,
                            fontSize: 16.0,
                          ),
                          text: AppLocalizations.of(context)!.remove_card_warning,
                        ),
                        TextSpan(
                          style: const TextStyle(
                            color: colors.darkBlue,
                            fontSize: 16.0,
                          ),
                          text: " $cardNumber?",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ModalActionButton(
                      backgroundColor: const Color(0xFFfee8e8),
                      primaryColor: const Color(0xfff96362),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                      ),
                      onTap: () {
                        Navigator.of(context).maybePop();
                      },
                      text: AppLocalizations.of(context)!.cancel_button,
                    ),
                    Consumer2<CardsInfoProvider, CardsCroemProvider>(
                      builder: (context, cardsInfoProvider, cardsCroemProvider,
                              widget) =>
                          ModalActionButton(
                        backgroundColor: const Color(0xFFdcfaed),
                        primaryColor: const Color(0xff12db87),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(16),
                        ),
                        onTap: () {
                          if (mainProvider.userType == UserRole.tutor &&
                              (homeProvider.cafeteria?.school.country ?? "") ==
                                  Contries.panama) {
                            cardsCroemProvider
                                .deleteCard(
                              mainProvider.accessToken,
                              mainProvider.cafeteriaId,
                              cardId,
                              mainProvider.tutor?.openPayId ?? "",
                              AppLocalizations.of(context),
                            )
                                .then(
                              (value) {
                                Navigator.of(context).maybePop();
                              },
                            );
                          } else {
                            cardsInfoProvider
                                .deleteCard(
                              mainProvider.accessToken,
                              mainProvider.cafeteriaId,
                              cardId,
                              mainProvider.tutor?.openPayId ?? "",
                              AppLocalizations.of(context),
                            )
                                .then(
                              (value) {
                                Navigator.of(context).maybePop();
                              },
                            );
                          }
                        },
                        iconData: Icons.do_disturb_on_outlined,
                        text: AppLocalizations.of(context)!.remove_card,
                        isLoading: (cardsInfoProvider.isDeletingCard || cardsCroemProvider.isDeletingCard),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
