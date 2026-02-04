import 'package:flutter/material.dart';
import 'package:smart_lunch/widgets/product_tile.dart';

class LimitedProductListTile extends StatelessWidget {
  const LimitedProductListTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.productCategory,
    required this.ingredients,
    required this.limit,
    required this.productId,
    required this.items,
    required this.onChanged,
    required this.description
  });

  final String imageUrl;
  final String title;
  final String productCategory;
  final List<String> ingredients;
  final String description;
  final String limit;
  final int productId;
  final List<String> items;
  final void Function(int, String) onChanged;

  @override
  Widget build(BuildContext context) {
    return ProductTile(
      description: description,
      imageUrl: imageUrl,
      title: title,
      productCategory: productCategory,
      ingredients: ingredients,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(
                    items,
                  ),
                );
              }).toList(),
              onChanged: (dynamic value) {
                onChanged(productId, value);
              },
              value: limit,
            ),
          ),
          // Text(
          //   limit,
          //   style: const TextStyle(
          //     color: Color(0xff413931),
          //     fontWeight: FontWeight.w400,
          //     fontFamily: "Comfortaa",
          //     fontStyle: FontStyle.normal,
          //     fontSize: 24.0,
          //   ),
          //   textAlign: TextAlign.left,
          // ),
          // const SizedBox(
          //   width: 10,
          // ),
          // const Icon(
          //   Icons.keyboard_arrow_down,
          // ),
        ],
      ),
    );
  }
}
