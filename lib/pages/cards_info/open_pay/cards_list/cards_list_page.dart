import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/models/register_card_page_arguments.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/custom_banner.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';

import '../components/card_component.dart';

class CardsListPage extends StatelessWidget {
  const CardsListPage({Key? key}) : super(key: key);

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
          Consumer<CardsInfoProvider>(
            builder: (context, cardsInfoProvider, widget) =>
                cardsInfoProvider.cards.length < 3
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
                                if (cardsInfoProvider.cards.length < 3 &&
                                    !cardsInfoProvider.isLoadingCardList) {
                                  cardsInfoProvider.loadPage(
                                    isNewCard: true,
                                  );
                                  Navigator.pushNamed(
                                    context,
                                    router.registerCardRoute,
                                    arguments: RegisterCardPageArguments(
                                      isNewCard: true,
                                    ),
                                  );
                                }
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
                    child: Consumer<CardsInfoProvider>(
                      builder: (context, cardsInfoProvider, widget) =>
                          RefreshIndicator(
                        onRefresh: () async {
                          await cardsInfoProvider.getCardList(
                            mainProvider.accessToken,
                            mainProvider.cafeteriaId
                          );
                        },
                        child: ListView(
                          shrinkWrap: false,
                          padding: EdgeInsets.zero,
                          children: cardsInfoProvider.cards
                              .map(
                                (card) => CardComponent(
                                  cardId: card?.id ?? "-1",
                                  holderName: card?.holderName ?? "",
                                  brand: card?.brand ?? "visa",
                                  cardNumber: card?.cardNumber ?? "",
                                  expirationDate:
                                      "${card?.expirationMonth}/${card?.expirationYear}",
                                  isMainCard:
                                      cardsInfoProvider.mainCardId == card?.id,
                                  internalCardId: card?.internalId ?? -2,
                                  // isDirectCard: cardsInfoProvider.isDirectCard,
                                  accessToken: mainProvider.accessToken,
                                  onChangedMainCard:
                                      cardsInfoProvider.onChangedMainCard,
                                  loadPage: cardsInfoProvider.loadPage,
                                
                                  // onChangedDirectCard:
                                  //     cardsInfoProvider.onChangeDirectCard,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  
                  Consumer<CardsInfoProvider>(
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
