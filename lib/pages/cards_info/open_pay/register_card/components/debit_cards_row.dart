import 'package:flutter/material.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;

class DebitCardsRow extends StatelessWidget {
  const DebitCardsRow({
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
        bottom: 23,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.debit_cards,
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
            runSpacing: 2,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 71,
                  maxHeight: 20,
                ),
                child: Image.asset(images.citibanamexLogo),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 61,
                  maxHeight: 20,
                ),
                child: Image.asset(images.inbursaLogo),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 71,
                  maxHeight: 20,
                ),
                child: Image.asset(images.santanderLogo),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 36,
                  maxHeight: 20,
                ),
                child: Image.asset(images.scotiabankLogo),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 36,
                  maxHeight: 20,
                ),
                child: Image.asset(images.bancoAztecaLogo),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 45,
                  maxHeight: 20,
                ),
                child: Image.asset(images.bbvaLogo),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
