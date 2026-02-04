import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/main_provider.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/models/product_model.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multiple_sale_provider.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multiple_sale_provider.dart';
import 'package:smart_lunch/pages/providers.dart';
import 'package:smart_lunch/pages/sales/components/product_details_modal.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/roles.dart';

class MultisaleMenuItemTile extends StatelessWidget {
  const MultisaleMenuItemTile({
    super.key,
    required this.product,
    required this.category,
    required this.removeItems,
    required this.addItems,
    required this.numberFormat,
    required this.balanceLimitStatus,
    required this.amount,
  });

  final Product product;
  final String category;
  final void Function(Product) removeItems;
  final void Function(Product) addItems;
  final bool Function() balanceLimitStatus;
  final NumberFormat numberFormat;
  final int amount;


  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width > 600 ? 40.0 : 30.0;

    MainProvider mainProvider= Provider.of<MainProvider>(
        context,
        listen: false
    );
    MultisaleProvider multisaleProvider= Provider.of<MultisaleProvider>(
        context,
        listen: false
    );



    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      child: ListTile(
        minVerticalPadding: 12,
        leading: Container(
          width: MediaQuery.of(context).size.width*0.15,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              fit: product.imageUrl.isNotEmpty ? BoxFit.cover : BoxFit.contain,
              image: product.imageUrl.isNotEmpty
                  ? NetworkImage(
                      product.imageUrl,
                    )
                  : const AssetImage(
                      images.defaultProductImage,
                    ) as ImageProvider<Object>,
            ),
          ),
        ),
        // SizedBox(
        //   height: 80,
        //   width: 60,
        //   child: ClipRRect(
        //     borderRadius: const BorderRadius.all(
        //       Radius.circular(16),
        //     ),
        //     child: Image.network(
        //       product.imageUrl,
        //       fit: BoxFit.fitHeight,
        //     ),
        //   ),
        // ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        horizontalTitleGap: 12,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.productName,
              style: const TextStyle(
                color: colors.darkBlue,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                fontFamily: "Comfortaa",
              ),
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 2,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              category,
              style: TextStyle(
                color: colors.coral.withOpacity(0.75),
                fontWeight: FontWeight.w700,
                fontSize: 10,
                fontFamily: "Comfortaa",
              ),
            ), Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        useSafeArea: true,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return ProductDetailsModal(
                            productImageUrl: product.imageUrl,
                            productTitle: product.productName,
                            totalPrice: product.price,
                            ingredients: product.ingredients,
                            productCategory: category,
                            description: product.description,
                          );
                        },
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      backgroundColor: colors.lightBlue.withOpacity(0.15),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.details,
                      style: const TextStyle(
                        color: colors.lightBlue,
                        fontSize: 11.0,
                        fontFamily: "Comfortaa",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "\$${numberFormat.format(product.price)}",
                      style: const TextStyle(
                        color: colors.orange,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Outfit",
                      ),
                    ),
                  ),

                  IconButton(
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: colors.orange,
                    ),
                    iconSize: iconSize,
                    onPressed: () {
                        removeItems.call(product);
                    },
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "$amount",
                      style: const TextStyle(
                        color: colors.darkBlue,
                        fontSize: 15.0,

                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add_circle,
                      color: colors.orange,

                    ),
                    iconSize: iconSize,
                    onPressed: () {
                      if(mainProvider.userType==UserRole.teacher){
                        addItems.call(product);
                      }
                      else if(multisaleProvider.selectedChild!.dailySpendLimit == 0 || (multisaleProvider.selectedSaleDate.totalPrice + product.price)<=multisaleProvider.selectedChild!.dailySpendLimit){
                        if(mainProvider.selectedChild?.limitedProducts[product.id]!=null){
                          int maximumAmount=0;
                          maximumAmount = mainProvider.selectedChild?.limitedProducts[product.id] ?? 0;
                          if(multisaleProvider.selectedSaleDate.cart?[product.id]!=null && (multisaleProvider.selectedSaleDate.cart?[product.id] ?? 0)>=maximumAmount){
                            final snackBar = SnackBar(
                              elevation: 0,
                              behavior:
                              SnackBarBehavior.floating,
                              backgroundColor:
                              Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: AppLocalizations.of(context)!.please_wait,
                                message:
                                "${AppLocalizations.of(context)!.maximun_products_warning_p1} $maximumAmount ${AppLocalizations.of(context)!.maximun_products_warning_p2}",

                                /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                contentType:
                                ContentType.warning,
                              ),
                            );

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          }
                          else{
                            addItems.call(product);
                          }
                        }
                        else{
                          addItems.call(product);
                        }
                      }
                      else{
                        final snackBar = SnackBar(
                          elevation: 0,
                          behavior:
                          SnackBarBehavior.floating,
                          backgroundColor:
                          Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: AppLocalizations.of(context)!.please_wait,
                            message:
                            "${AppLocalizations.of(context)!.daily_limit_warning}  \$${mainProvider.selectedChild?.dailySpendLimit ?? 0}",

                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                            contentType:
                            ContentType.warning,
                          ),
                        );

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      }
                    },
                  ),
                ],
              ),
          ],
        ),
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: const Color(0xffffa66a).withOpacity(0.5)),
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
    );
  }
}

