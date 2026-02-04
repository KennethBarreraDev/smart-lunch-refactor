import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/widgets/labeled_checkbox.dart';
import 'package:smart_lunch/widgets/modal_action_button.dart';

class SpendLimitModal extends StatelessWidget {
  const SpendLimitModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: false,
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      insetPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      titleTextStyle: const TextStyle(
        fontSize: 24.0,
        color: Color(0xff413931),
        fontFamily: "Comfortaa",
      ),
      title: Text(
        AppLocalizations.of(context)!.daily_limit,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
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
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Divider(),
                  Text(
                    AppLocalizations.of(context)!.enter_amount,
                    style: const TextStyle(
                      color: Color(0xff413931),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Comfortaa",
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Consumer<MainProvider>(
                    builder: (context, mainProvider, widget) => TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                      controller: mainProvider.dailySpendLimitController,
                      enabled: mainProvider.dailySpendHasLimit,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'),
                        ),
                      ],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<MainProvider>(
                    builder: (context, mainProvider, widget) => LabeledCheckbox(
                      label: AppLocalizations.of(context)!.unlimited_message,
                      value: !mainProvider.dailySpendHasLimit,
                      onChanged:
                          mainProvider.selectedChildHasDailySpendLimitChange,
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<MainProvider>(
                  builder: (context, mainProvider, widget) => ModalActionButton(
                    backgroundColor: const Color(0xff21a76f).withOpacity(0.15),
                    primaryColor: const Color(0xff21a76f),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        mainProvider.updateSpendingLimit(
                          AppLocalizations.of(context),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    text: AppLocalizations.of(context)!.save_button,
                    isLoading: mainProvider.isUpdatingSpendingLimit,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
