import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/models/history_product.dart';
import 'package:smart_lunch/pages/home/components/sale_details_modal.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/images.dart' as images;

class OrderTile extends StatelessWidget {
  const OrderTile({
    super.key,
    required this.presaleId,
    required this.studentName,
    required this.studentImageUrl,
    required this.orderNumber,
    required this.deliveryDate,
    required this.totalPrice,
    required this.products,
    required this.saleStatus,
    required this.cafeteriaComment,
    this.isPresale = false,
  });

  final String studentName;
  final String studentImageUrl;
  final String orderNumber;
  final String deliveryDate;
  final String totalPrice;
  final bool isPresale;
  final String presaleId;
  final List<HistoryProduct> products;
  final String saleStatus;
  final String cafeteriaComment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          useSafeArea: true,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SaleDetailsModal(
              cafeteriaComment: cafeteriaComment,
              saleStatus: saleStatus,
              presaleId: presaleId,
              totalPrice: totalPrice,
              deliveryDate: deliveryDate,
              studentName: studentName,
              studentImageUrl: studentImageUrl,
              isPresale: isPresale,
              products: products,
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          border: Border.all(
            color: const Color(0xFF413931).withOpacity(.1),
          ),
        ),
        margin: const EdgeInsets.only(
          bottom: 16,
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(63),
                      ),
                      color: 
                       saleStatus == "CANCELED" ?
                       const Color(0xffEF5360).withOpacity(0.2)
                       :
                      isPresale
                          ? const Color(0xff0ca565).withOpacity(0.15)
                          : const Color(0xff0ca565).withOpacity(0.15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    margin: const EdgeInsets.only(bottom: 9),
                    child: saleStatus == "CANCELED"
                        ? RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: AppLocalizations.of(context)!
                                    .canceled_message,
                                style: const TextStyle(
                                  color: Color(0xffEF5360),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0,
                                  fontFamily: "Comfortaa",
                                ),
                              )
                            ]),
                          )
                        : RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "${AppLocalizations.of(context)!.delivery_date}: ",
                                  style: TextStyle(
                                    color: isPresale
                                        ? const Color(0xff0ca565)
                                        : const Color(0xff0ca565),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.0,
                                    fontFamily: "Comfortaa",
                                  ),
                                ),
                                TextSpan(
                                  text: deliveryDate,
                                  style: TextStyle(
                                    color: isPresale
                                        ? const Color(0xff0ca565)
                                        : const Color(0xff0ca565),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.0,
                                    fontFamily: "Comfortaa",
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: studentImageUrl.isNotEmpty
                                ? BoxFit.cover
                                : BoxFit.contain,
                            image: studentImageUrl.isNotEmpty
                                ? NetworkImage(
                                    studentImageUrl,
                                  )
                                : const AssetImage(
                                    images.defaultProfileStudentImage,
                                  ) as ImageProvider<Object>,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                studentName,
                                style: const TextStyle(
                                  color: Color(0xff413931),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                  fontFamily: "Comfortaa",
                                ),
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Consumer<HomeProvider>(
                                builder: (context, homeProvider, child) {
                              return RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      style: const TextStyle(
                                          color: Color(0xff36413d),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 24.0,
                                          fontFamily: "Outfit"),
                                      text: "\$$totalPrice",
                                    ),
                                    TextSpan(
                                      style: const TextStyle(
                                          color: Color(0xff36413d),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.0,
                                          fontFamily: "Outfit"),
                                      text: ((homeProvider.cafeteria?.school
                                                      .country ??
                                                  "") ==
                                              Contries.panama)
                                          ? " USD"
                                          : " MXN",
                                    ),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 1,
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Icon(
                Icons.chevron_right,
                size: 40,
                color: const Color(0xFF413931).withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
