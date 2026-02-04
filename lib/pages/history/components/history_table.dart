import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/models/history_product.dart';
import 'package:smart_lunch/pages/history/components/products_table_header.dart';
import 'package:smart_lunch/pages/history/components/stacked_texts.dart';

class HistoryTable extends StatelessWidget {
  const HistoryTable(
      {super.key,
      required this.saleId,
      required this.saleType,
      required this.saleTime,
      required this.products,
      this.status = '',
      this.comments = ''});

  final String saleId;
  final String saleType;
  final String saleTime;
  final List<HistoryProduct> products;
  final String? status;
  final String? comments;

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: StackedTexts(
                title: "ID",
                subtitle: saleId,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: StackedTexts(
                title: products.isNotEmpty
                    ? AppLocalizations.of(context)!.sale_type
                    : AppLocalizations.of(context)!.platfotm_message,
                subtitle: saleType,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: StackedTexts(
                title: AppLocalizations.of(context)!.time,
                subtitle: saleTime,
              ),
            ),
          ],
        ),
        if (products.isNotEmpty)
          Column(
            children: [
              (status != null &&
                      (status ?? "").isNotEmpty &&
                      status == "CANCELED")
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              "Status: ${AppLocalizations.of(context)!.canceled_message}"),
                        ],
                      ),
                    )
                  : Container(),
              (comments != null &&
                      (comments ?? "").isNotEmpty
                      )
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              comments ?? ""),
                        ],
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              const ProductsTableHeader(),
              const SizedBox(
                height: 5,
              ),
              DottedLine(
                dashColor: const Color(0xFF413931).withOpacity(0.25),
                dashGapLength: 11,
                dashLength: 11,
              ),
              const SizedBox(
                height: 24,
              ),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                },
                children: products
                    .map(
                      (product) => buildProductTableRow(
                        product.productName,
                        product.amount.toString(),
                        mainProvider.numberFormat.format(product.price),
                      ),
                    )
                    .toList(),
              ),
            ],
          )
      ],
    );
  }

  TableRow buildProductTableRow(
      String productName, String amount, String price) {
    return TableRow(
      children: [
        TableCell(
          child: Text(
            productName,
            style: TextStyle(
                color: const Color(0xff413931).withOpacity(0.5),
                fontWeight: FontWeight.w300,
                fontSize: 16.0,
                fontFamily: "Comfortaa"),
          ),
        ),
        TableCell(
          child: Text(
            amount,
            style: TextStyle(
                color: const Color(0xff413931).withOpacity(0.5),
                fontWeight: FontWeight.w300,
                fontSize: 16.0,
                fontFamily: "Comfortaa"),
            textAlign: TextAlign.center,
          ),
        ),
        TableCell(
          child: Text(
            "\$ $price",
            style: TextStyle(
                color: const Color(0xff413931).withOpacity(0.5),
                fontWeight: FontWeight.w300,
                fontSize: 16.0,
                fontFamily: "Outfit"),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
