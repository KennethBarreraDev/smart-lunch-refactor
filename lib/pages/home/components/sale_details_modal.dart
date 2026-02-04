import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/models/history_product.dart';
import 'package:smart_lunch/pages/providers.dart';
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/widgets/modal_action_button.dart';

class SaleDetailsModal extends StatelessWidget {
  const SaleDetailsModal(
      {super.key,
      required this.cafeteriaComment,
      required this.studentName,
      required this.studentImageUrl,
      required this.deliveryDate,
      required this.totalPrice,
      required this.products,
      this.isPresale = false,
      required this.presaleId,
      required this.saleStatus});

  final String studentName;
  final String studentImageUrl;
  final String deliveryDate;
  final String totalPrice;
  final String saleStatus;
  final bool isPresale;
  final String presaleId;
  final List<HistoryProduct> products;
  final String cafeteriaComment;

  @override
  Widget build(BuildContext context) {
    DateTime dateBeforeDate = DateFormat("dd/MM/yyyy")
        .parse(deliveryDate)
        .subtract(Duration(days: 1));

    DateTime currentDate = DateTime.now();
    print("Previous date is $dateBeforeDate current is $currentDate");

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
        isPresale
            ? AppLocalizations.of(context)!.presale
            : AppLocalizations.of(context)!.sale,
        style: const TextStyle(
          fontFamily: "Comfortaa",
        ),
      ),
      content: Consumer3<MainProvider, SaleProvider, HomeProvider>(
        builder: (context, mainProvider, saleProvider, homeProvider, widget) =>
            saleProvider.cancelPresaleSuccess
                ? Container(
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
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 300,
                                height: 200,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: AssetImage(
                                      images.noResultsLogo,
                                    ) as ImageProvider<Object>,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Center(
                                  child: Text(
                                AppLocalizations.of(context)!.presale_canceled,
                                style: const TextStyle(
                                  fontFamily: "Comfortaa",
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              )),
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
                              backgroundColor:
                                  const Color(0xffffa66a).withOpacity(0.15),
                              primaryColor: const Color(0xffffa66a),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              onTap: () {
                                saleProvider.cancelPresaleSuccess = false;
                                saleProvider.cancelPresaleError = false;
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
                  )
                : saleProvider.cancelPresaleError
                    ? Container(
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 300,
                                    height: 200,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: AssetImage(
                                          images.noResultsLogo,
                                        ) as ImageProvider<Object>,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Center(
                                      child: Text(
                                    AppLocalizations.of(context)!
                                        .cancel_presale_error,
                                    style: const TextStyle(
                                        fontFamily: "Comfortaa",
                                        fontSize: 18,
                                        color: Colors.redAccent),
                                    textAlign: TextAlign.center,
                                  )),
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
                                  backgroundColor:
                                      const Color(0xffffa66a).withOpacity(0.15),
                                  primaryColor: const Color(0xffffa66a),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                  onTap: () {
                                    saleProvider.cancelPresaleSuccess = false;
                                    saleProvider.cancelPresaleError = false;
                                    if (Navigator.of(context).canPop()) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  text: AppLocalizations.of(context)!
                                      .close_button,
                                  textFontSize: 24,
                                  textFontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
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
                                    height: 23,
                                  ),
                                  Row(
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
                                                    images
                                                        .defaultProfileStudentImage,
                                                  ) as ImageProvider<Object>,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            studentName,
                                            style: const TextStyle(
                                              color: Color(0xff413931),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0,
                                              fontFamily: "Comfortaa",
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  style: const TextStyle(
                                                      color: Color(0xff36413d),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 24.0,
                                                      fontFamily: "Outfit"),
                                                  text: "\$$totalPrice",
                                                ),
                                                TextSpan(
                                                  style: const TextStyle(
                                                      color: Color(0xff36413d),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12.0,
                                                      fontFamily: "Outfit"),
                                                  text: ((homeProvider
                                                                  .cafeteria
                                                                  ?.school
                                                                  .country ??
                                                              "") ==
                                                          Contries.panama)
                                                      ? " USD"
                                                      : " MXN",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(63),
                                          ),
                                          color: saleStatus == "CANCELED"
                                              ? const Color(0xffEF5360)
                                                  .withOpacity(0.2)
                                              : isPresale
                                                  ? const Color(0xff0ca565)
                                                      .withOpacity(0.15)
                                                  : const Color(0xff0ca565)
                                                      .withOpacity(0.15),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 6,
                                          horizontal: 12,
                                        ),
                                        margin: const EdgeInsets.only(
                                          right: 25,
                                        ),
                                        child: saleStatus == "CANCELED"
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text: AppLocalizations.of(
                                                              context)!
                                                          .canceled_message,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xffEF5360),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12.0,
                                                        fontFamily: "Comfortaa",
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                              )
                                            : RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "${AppLocalizations.of(context)!.delivery_date}: ",
                                                      style: TextStyle(
                                                        color: isPresale
                                                            ? const Color(
                                                                0xff0ca565)
                                                            : const Color(
                                                                0xff0ca565),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12.0,
                                                        fontFamily: "Comfortaa",
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: deliveryDate,
                                                      style: TextStyle(
                                                        color: isPresale
                                                            ? const Color(
                                                                0xff0ca565)
                                                            : const Color(
                                                                0xff0ca565),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12.0,
                                                        fontFamily: "Comfortaa",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(63),
                                          ),
                                          color: isPresale &&
                                                  saleStatus != "CANCELED"
                                              ? const Color(0xffEF5360)
                                                  .withOpacity(0.15)
                                              : Colors.transparent,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 6,
                                          horizontal: 12,
                                        ),
                                        child: (isPresale &&
                                                    saleStatus != "CANCELED" &&
                                                    (homeProvider
                                                                .cafeteria
                                                                ?.school
                                                                .country ??
                                                            "") !=
                                                        Contries.panama) ||
                                                (isPresale &&
                                                    saleStatus != "CANCELED" &&
                                                    ((dateBeforeDate.day !=
                                                            currentDate.day) ||
                                                        (dateBeforeDate.day ==
                                                                currentDate
                                                                    .day &&
                                                            currentDate.hour <
                                                                13)))
                                            ? GestureDetector(
                                                onTap: () async {
                                                  //print(presaleId)
                                                  print(DateFormat("dd/MM/yyyy")
                                                      .parse(deliveryDate));
                                                  return await saleProvider
                                                      .cancelPresale(
                                                          presaleId,
                                                          mainProvider
                                                              .accessToken,
                                                          mainProvider
                                                              .cafeteriaId,
                                                          context);
                                                },
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .remove_circle_outline,
                                                      color: Color(0xffEF5360),
                                                    ),
                                                    // Button
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .cancel_button,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xffef5360),
                                                        fontSize: 12.0,
                                                        fontFamily: "Comfortaa",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),

                                  Row(
                                    children: [
                                      Text("${AppLocalizations.of(context)!.comments_message}: $cafeteriaComment")
                                    ],
                                  ),

                                  const SizedBox(height: 12,),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .product_message,
                                          style: const TextStyle(
                                            color: Color(0xff413931),
                                            fontSize: 12.0,
                                            fontFamily: "Comfortaa",
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .amount_message,
                                          style: const TextStyle(
                                            color: Color(0xff413931),
                                            fontSize: 12.0,
                                            fontFamily: "Comfortaa",
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .price_message,
                                          style: const TextStyle(
                                            color: Color(0xff413931),
                                            fontSize: 12.0,
                                            fontFamily: "Outfit",
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  DottedLine(
                                    lineLength:
                                        MediaQuery.of(context).size.width * 0.8,
                                    dashColor: const Color(0xff413931)
                                        .withOpacity(0.5),
                                    dashLength: 11,
                                    dashGapLength: 11,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(4),
                                      1: FlexColumnWidth(1),
                                      2: FlexColumnWidth(2),
                                    },
                                    children: products
                                        .map(
                                          (product) => buildPresaleElementTile(
                                            product.amount.toString(),
                                            product.productName,
                                            NumberFormat("###,##0.00")
                                                .format(product.price),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: ModalActionButton(
                                  backgroundColor:
                                      const Color(0xffffa66a).withOpacity(0.15),
                                  primaryColor: const Color(0xffffa66a),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                  onTap: () {
                                    saleProvider.cancelPresaleSuccess = false;
                                    saleProvider.cancelPresaleError = false;
                                    if (Navigator.of(context).canPop()) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  text: AppLocalizations.of(context)!
                                      .close_button,
                                  textFontSize: 24,
                                  textFontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
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
