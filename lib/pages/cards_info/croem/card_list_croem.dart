import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/components/card_component.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/custom_banner.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';

class CroemCardsListPage extends StatelessWidget {
  const CroemCardsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );
    return TransparentScaffold(
      selectedOption: "Colegiaturas",
      body: Column(
        children: [
          CustomAppBar(
            height: 160,
            showPageTitle: true,
            pageTitle: AppLocalizations.of(context)!.card_message,
            image: images.appBarShortImg,
            showDrawer: false,
          ),
          Consumer<CardsCroemProvider>(
            builder: (context, cardsCroemProvider, widget) =>
                cardsCroemProvider.cards.length < 3
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                 Navigator.of(context)
                                      .pushNamed(router.createCroemCardRoute);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.credit_score,
                                    color: Color(0xff1b8dda),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.add_card,
                                    style: const TextStyle(
                                      color: Color(0xff1b8dda),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
          ),
          const SizedBox(
            height: 9,
          ),
          Expanded(
            child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    child: Consumer<CardsCroemProvider>(
                      builder: (context, cardsCroemProvider, widget) =>
                          RefreshIndicator(
                        onRefresh: () async {
                          await cardsCroemProvider.getCardList(
                            mainProvider.accessToken,
                            mainProvider.cafeteriaId
                          );
                        },
                        child: ListView(
                          shrinkWrap: false,
                          padding: EdgeInsets.zero,
                          children:cardsCroemProvider.cards
                              .map(
                                (card) => CardComponent(
                                  hideCard: false,
                                  cardId: card?.id.toString() ?? "-1",
                                  holderName: card?.cardHolderName ?? "",
                                  brand:  cardsCroemProvider.getCardBrand(card?.cardNumber ?? ""),
                                  cardNumber: card?.cardNumber ?? "",
                                  expirationDate:
                                      "",
                                  isMainCard: false,
                                  // isDirectCard: cardsInfoProvider.isDirectCard,
                                  accessToken: mainProvider.accessToken,
                                  onChangedMainCard:(String value, String cafeteria, String secondValue, int val, AppLocalizations? appLocalizations  ){},
                                  loadPage: cardsCroemProvider.loadPage,
                                  internalCardId: card?.internalId ?? 0,
                                  // onChangedDirectCard:
                                  //     cardsInfoProvider.onChangeDirectCard,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  Consumer<CardsCroemProvider>(
                    builder: (context, cardsInfoProvider, widget) => CustomBanner(
                      bannerType: cardsInfoProvider.cardListBannerType,
                      bannerMessage: cardsInfoProvider.cardListBannerMessage,
                      hideBanner: cardsInfoProvider.hideListBanner,
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
