import 'package:flutter/material.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/widgets/product_tile.dart';

class ForbiddenProductListTile extends StatelessWidget {
  const ForbiddenProductListTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.productCategory,
    required this.ingredients,
    required this.isForbidden,
    required this.onChanged,
    required this.index,
    required this.description
  });

  final String imageUrl;
  final String title;
  final String productCategory;
  final List<String> ingredients;
  final String description;
  final bool isForbidden;
  final void Function(int) onChanged;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ProductTile(
      description: description,
      imageUrl: imageUrl,
      title: title,
      productCategory: productCategory,
      ingredients: ingredients,
      trailing: SizedBox(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Text(
                isForbidden ? AppLocalizations.of(context)!.forbidden_message : AppLocalizations.of(context)!.allowed_message,
                style: TextStyle(
                  color: isForbidden ? colors.coral :  Colors.grey.withOpacity(0.5),
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Switch(
                thumbColor:  const MaterialStatePropertyAll<Color>(Colors.white),
                value: isForbidden,
                onChanged: (bool value) {
                  onChanged(index);
                },
                activeTrackColor: colors.coral,
                activeColor: Colors.white,
                inactiveTrackColor:  Colors.grey.withOpacity(0.5),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
