import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/top_up_mercado_pago/top_up_provider.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;

class FeeComponent extends StatelessWidget {
  FeeComponent({super.key, required this.comissionFee, required this.amount});
  double comissionFee;
  double amount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${AppLocalizations.of(context)!.subtotal}",
                  style: const TextStyle(
                    fontFamily: "Outfit",
                    color: colors.darkBlue,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "\$${amount.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontFamily: "Outfit",
                    color: colors.darkBlue,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${AppLocalizations.of(context)!.bank_fee} :",
                  style: const TextStyle(
                    fontFamily: "Outfit",
                    color: colors.darkBlue,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "\$${(amount * (comissionFee / 100)).toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontFamily: "Outfit",
                    color: colors.darkBlue,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Divider(
            color: Colors.grey.withOpacity(0.4),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${AppLocalizations.of(context)!.total_price}: ",
                  style: const TextStyle(
                    fontFamily: "Outfit",
                    color: colors.darkBlue,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "\$${(amount + (amount * (comissionFee / 100))).toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontFamily: "Outfit",
                    color: colors.darkBlue,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
