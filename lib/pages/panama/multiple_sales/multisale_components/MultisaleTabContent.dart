import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/models/product_model.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multiple_sale_provider.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/MultisaleMenuItemTile.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multiple_sale_provider.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multisale_products_provider.dart';
import 'package:smart_lunch/pages/sales/sale/components/menu_item_tile.dart';
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;

class MultisaleTabContent extends StatelessWidget {
  const MultisaleTabContent(
      {super.key,
      required this.numberFormat,
      required this.products,
      required this.addItem,
      required this.removeItem,
      required this.cart,
      required this.balanceLimitStatus,
      required this.isPresale,
      required this.saleDate});

  final NumberFormat numberFormat;
  final List<Product> products;
  final void Function(Product) addItem;
  final void Function(Product) removeItem;
  final bool Function() balanceLimitStatus;
  final Map<int, int> cart;
  final bool isPresale;
  final DateTime saleDate;

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );

    HomeProvider homeProvider = Provider.of<HomeProvider>(
      context,
      listen: true,
    );

    MultisaleProvider multisaleProvider = Provider.of<MultisaleProvider>(
      context,
      listen: false,
    );

    MultisaleProductsProvider multisaleProductsProvider =
        Provider.of<MultisaleProductsProvider>(
      context,
      listen: false,
    );

    ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (isTop) {
        } else {
          multisaleProductsProvider.getProducts(
              mainProvider.accessToken,
              mainProvider.cafeteriaId,
              (homeProvider.cafeteria?.school.country ?? "") == Contries.panama,
              multisaleProvider.selectedSaleDate.saleDate,
              incrementPage: true,
              omitFilters: false,
              isPresale: isPresale);
        }
      }
    });

    return Consumer<MultisaleProvider>(
      builder: (context, multisaleProvider, widget) {
        // Mover el scroll al final cuando se termina de cargar los productos
        return multisaleProductsProvider.fetchingData
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    ...products
                        .map((product) => MultisaleMenuItemTile(
                              product: product,
                              category: product.category.name,
                              addItems: addItem,
                              removeItems: removeItem,
                              balanceLimitStatus: balanceLimitStatus,
                              numberFormat: numberFormat,
                              amount: cart.containsKey(product.id)
                                  ? (cart[product.id] ?? 0)
                                  : 0,
                            ))
                        .toList(),
                    if (multisaleProductsProvider.loadingProducts)
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                  ],
                ),
              );
      },
    );
  }
}
