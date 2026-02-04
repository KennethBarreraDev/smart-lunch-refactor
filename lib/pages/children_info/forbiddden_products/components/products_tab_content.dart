import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/main_provider.dart';
import 'package:smart_lunch/common_providers/products_provider.dart';
import 'package:smart_lunch/models/child_model.dart';
import 'package:smart_lunch/models/product_model.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;

import 'forbidden_products_list_tile.dart';

class ProductsTabContent extends StatelessWidget {
  const ProductsTabContent({
    super.key,
    required this.products,
    required this.selectedChild,
    required this.onChanged,

  });

  final List<Product> products;
  final Child? selectedChild;
  final void Function(int) onChanged;

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
              mainProvider.cafeteriaId,
              (homeProvider.cafeteria?.school.country ?? "") == Contries.panama,
              incrementPage: true,
              omitFilters: true
              );
        }
      }
    });

    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          ...products
              .map((product) => ForbiddenProductListTile(
                    imageUrl: product.imageUrl,
                    title: product.productName,
                    productCategory: product.category.name,
                    ingredients: product.ingredients,
                    description: product.description,
                    isForbidden:
                        selectedChild?.forbiddenProducts.contains(product.id) ??
                            false,
                    onChanged: onChanged,
                    index: product.id,
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
