import 'package:flutter/material.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';


class ProductsTableHeader extends StatelessWidget {
  const ProductsTableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      children:[
        TableRow(
          children: [
            TableCell(
              child: Text(
                AppLocalizations.of(context)!.product_message,
                style: const TextStyle(
                  color: Color(0xff413931),
                  fontFamily: "Comfortaa",
                  fontSize: 12.0,
                ),
              ),
            ),
            TableCell(
              child: Text(
                AppLocalizations.of(context)!.amount_message,
                style: const TextStyle(
                  color: Color(0xff413931),
                  fontFamily: "Comfortaa",
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            TableCell(
              child: Text(
                AppLocalizations.of(context)!.price_message,
                style: const TextStyle(
                  color: Color(0xff413931),
                  fontFamily: "Comfortaa",
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
