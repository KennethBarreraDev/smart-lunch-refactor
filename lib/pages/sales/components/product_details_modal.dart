import 'package:flutter/material.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/widgets/modal_action_button.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';

class ProductDetailsModal extends StatelessWidget {
  const ProductDetailsModal({
    super.key,
    required this.productImageUrl,
    required this.totalPrice,
    required this.ingredients,
    required this.productTitle,
    required this.productCategory,
    required this.description
  });


  final String productImageUrl;
  final String productTitle;
  final double totalPrice;
  final List<String> ingredients;
  final String description;
  final String productCategory;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: colors.white,
      scrollable: true,
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
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
        AppLocalizations.of(context)!.details,
        style: const TextStyle(fontFamily: "Comfortaa"),
      ),
      content: Container(
        color: colors.white,
        child: Stack(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: productImageUrl.isNotEmpty
                                ? BoxFit.fill
                                : BoxFit.contain,
                            image: productImageUrl.isNotEmpty
                                ? NetworkImage(
                              productImageUrl,
                            )
                                : const AssetImage(
                                images.defaultProductImage,
                            ) as ImageProvider<Object>,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Center(
                    child: Text(
                      productTitle,
                      style: const TextStyle(fontSize: 20, fontFamily: "Comfortaa", fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.fastfood,
                              color: Color(0xffEF5360),
                            ),
                            Text(productCategory, style: const TextStyle(fontFamily: "Comfortaa", color: Color(0xffEF5360)),)
                          ],
                        ),
                        Text('\$$totalPrice', style: const TextStyle(color: Color(0xffffa66a), fontFamily: "Outfit", fontWeight: FontWeight.w500 ,fontSize: 20),),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.format_list_bulleted,
                        color: Color(0xff5CAEFF),
                      ),
                      Text(AppLocalizations.of(context)!.description_message, style: TextStyle(color: Color(0xff5CAEFF), fontFamily: "Comfortaa",),)
                    ],
                  ),
                  Text(description, style: const TextStyle(fontFamily: "Comfortaa",),),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.rice_bowl,
                        color: Color(0xff5CAEFF),
                      ),
                      Text(AppLocalizations.of(context)!.ingredients, style: const TextStyle(color: Color(0xff5CAEFF), fontFamily: "Comfortaa",),)
                    ],
                  ),
                  Text(ingredients.join(", "), style: const TextStyle(fontFamily: "Comfortaa",),),
                  const SizedBox(
                    height: 30,
                  )

                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ModalActionButton(
                  backgroundColor: const Color(0xffffa66a).withOpacity(0.15),
                  primaryColor: const Color(0xffffa66a),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  onTap: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  },
                  text: AppLocalizations.of(context)!.close_button,
                  textFontSize: 24,
                  textFontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TableRow buildPresaleElementTile(String amount, String product, String price) {
  return TableRow(
    children: [
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
          ),
          child: Text(
            product,
            style: TextStyle(
              color: const Color(0xff413931).withOpacity(0.5),
              fontWeight: FontWeight.w300,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
          ),
          child: Text(
            amount,
            style: TextStyle(
              color: const Color(0xff413931).withOpacity(0.5),
              fontWeight: FontWeight.w300,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
          ),
          child: Text(
            "\$$price",
            style: TextStyle(
              color: const Color(0xff413931).withOpacity(0.5),
              fontWeight: FontWeight.w300,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ),
    ],
  );
}
