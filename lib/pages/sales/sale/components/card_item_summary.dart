import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/pages/sales/sale/sale_provider.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;

class CartItemSummary extends StatelessWidget {
  const CartItemSummary({
    super.key,
    required this.productName,
    required this.productImageUrl,
    required this.amount,
    required this.price,
    required this.numberFormat,
    required this.productID,
  });

  final int productID;
  final String productImageUrl;
  final String productName;
  final int amount;
  final double price;
  final NumberFormat numberFormat;

  @override
  Widget build(BuildContext context) {

    return Consumer<SaleProvider>(
        builder: (context, saleProvider, widget) =>
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    minVerticalPadding: 12,
                    horizontalTitleGap: 12,
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: productImageUrl.isNotEmpty ? BoxFit.cover : BoxFit.contain,
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
                    title: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                productName,
                                style: const TextStyle(
                                  color: colors.darkBlue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  fontFamily: "Comfortaa",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                softWrap: false,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "x $amount",
                                  style: TextStyle(
                                    color: colors.darkBlue.withOpacity(0.75),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Comfortaa",
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "\$${numberFormat.format(price)} c/u",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Comfortaa",
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "\$${numberFormat.format(amount * price)}",
                              style: const TextStyle(
                                color: colors.orange,
                                fontSize: 16.0,
                                fontFamily: "Outfit",
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(color: Colors.grey.withOpacity(0.2),),
                  ),
                ],
              ),
            )
    );
  }
}
