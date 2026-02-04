import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/main_provider.dart';
import 'package:smart_lunch/common_providers/products_provider.dart';
import 'package:smart_lunch/models/child_model.dart';
import 'package:smart_lunch/models/product_model.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;

import 'limited_products_list_tile.dart';

class ProductsTabContent extends StatelessWidget {
  const ProductsTabContent({
    super.key,
    required this.products,
    required this.selectedChild,
    required this.items,
    required this.onChanged,
  });

  final List<Product> products;
  final Child? selectedChild;
  final List<String> items;
  final void Function(int, String) onChanged;

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );

    ProductsProvider productsProvider = Provider.of<ProductsProvider>(
      context,
      listen: false,
    );
    HomeProvider homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );

    ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (isTop) {
        } else {
          productsProvider.getProducts(
              mainProvider.accessToken,
              mainProvider.accessToken,
              (homeProvider.cafeteria?.school.country ?? "") == Contries.panama,
              incrementPage: true,
              omitFilters: true,
              );
        }
      }
    });
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          ...products
              .map((product) => LimitedProductListTile(
                    imageUrl: product.imageUrl,
                    title: product.productName,
                    productCategory: product.category.name,
                    ingredients: product.ingredients,
                    description: product.description,
                    limit: (selectedChild?.limitedProducts
                                .containsKey(product.id.toInt()) !=
                            false)
                        ? (selectedChild?.limitedProducts[product.id]
                                .toString() ??
                            "")
                        : "-",
                    productId: product.id,
                    items: items,
                    onChanged: onChanged,
                  ))
              .toList(),
          if (productsProvider.loadingProducts)
            const Center(
              child: CircularProgressIndicator(
                color: colors.orange,
              ),
            )
        ],
      ),
    );
  }
}
