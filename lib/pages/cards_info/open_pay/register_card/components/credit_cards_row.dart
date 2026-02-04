import 'package:flutter/material.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;

class CreditCardRow extends StatelessWidget {
  const CreditCardRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
        border: Border.all(
          color: colors.darkBlue.withOpacity(0.08),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      margin: const EdgeInsets.only(
        bottom: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.credit_card,
            style: const TextStyle(
              color: colors.darkBlue,
              fontWeight: FontWeight.w300,
              fontSize: 12.0,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 25,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 32,
                  maxHeight: 32,
                ),
                child: Image.asset(images.americanExpressLogo),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 45,
                  maxHeight: 32,
                ),
                child: Image.asset(images.masterCardText),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 58,
                  maxHeight: 32,
                ),
                child: Image.asset(images.visaLogo),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 58,
                  maxHeight: 32,
                ),
                child: Image.asset(images.carnetLogo),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
