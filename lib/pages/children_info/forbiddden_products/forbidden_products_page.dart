import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/home/components/components.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/custom_banner.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';

import 'components/products_tab_content.dart';

class ForbiddenProductsPage extends StatelessWidget {
  const ForbiddenProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransparentScaffold(
      selectedOption: "",
      body: Column(
        children: [
          CustomAppBar(
            height: 160,
            showPageTitle: true,
            pageTitle: AppLocalizations.of(context)!.forbidden_products,
            image: images.appBarShortImg,
            showDrawer: false,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Consumer2<ProductsProvider, MainProvider>(
                    builder:
                        (context, productsProvider, mainProvider, widget) =>
                            DefaultTabController(
                      length: productsProvider.categories.length + 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ColoredBox(
                            color: colors.white,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.menu,
                                  style: const TextStyle(
                                    color: Color(0xffffa66a),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Comfortaa",
                                    fontSize: 24.0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                Expanded(
                                  child: TabBar(
                                    indicatorColor: const Color(0xffffa66a),
                                    labelColor: const Color(0xff413931),
                                    unselectedLabelColor:
                                        const Color(0xff413931)
                                            .withOpacity(0.25),
                                    labelPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    isScrollable: true,
                                    tabs: [
                                      const Tab(
                                        text: "Todos",
                                      ),
                                      ...productsProvider.categories
                                          .map(
                                            (category) => Tab(
                                              text: category.name,
                                            ),
                                          )
                                          .toList(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Expanded(
                            child: TabBarView(
                              children: mainProvider.fetchingData
                                  ? [
                                      const Center(
                                        child: CircularProgressIndicator(
                                          color: colors.orange,
                                        ),
                                      ),
                                      ...productsProvider.categories
                                          .map((e) => const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: colors.orange,
                                                ),
                                              ))
                                          .toList()
                                    ]
                                  : [
                                      Consumer<MainProvider>(
                                        builder:
                                            (context, mainProvider, widget) =>
                                                ProductsTabContent(
                                          products: productsProvider.products,
                                          selectedChild:
                                              mainProvider.selectedChild,
                                          onChanged: mainProvider
                                              .changeForbiddenProduct,
                                        ),
                                      ),
                                      ...productsProvider.categories
                                          .map(
                                            (category) =>
                                                Consumer<MainProvider>(
                                              builder: (context, mainProvider,
                                                      widget) =>
                                                  ProductsTabContent(
                                                products: productsProvider
                                                    .getProductFromCategory(
                                                        category,
                                                        mainProvider
                                                            .selectedChild),
                                                selectedChild:
                                                    mainProvider.selectedChild,
                                                onChanged: mainProvider
                                                    .changeForbiddenProduct,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ],
                            ),
                          ),
                          Consumer<MainProvider>(
                            builder: (context, mainProvider, widget) =>
                                SizedBox(
                              height: 100,
                              child: !mainProvider.isUpdatingForbiddenProducts
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: RoundedButton(
                                            color: colors.tuitionGreen,
                                            iconData: Icons.fastfood,
                                            text: AppLocalizations.of(context)!
                                                .save_button,
                                            verticalPadding: 14,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            onTap: () {
                                              mainProvider
                                                  .saveRestrictedProducts(
                                                "forbidden",
                                                AppLocalizations.of(context),
                                              );
                                            },
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
                                        )
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Consumer<MainProvider>(
                  builder: (context, mainProvider, widget) => CustomBanner(
                    bannerType: mainProvider.forbiddenProductsBannerType,
                    bannerMessage: mainProvider.forbiddenProductsBannerMessage,
                    hideBanner: mainProvider.hideForbiddenProductsBanner,
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
