import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/modal_action_button.dart';
import 'package:smart_lunch/routes/router.dart' as router;

class PendingMembershipModal extends StatelessWidget {
  const PendingMembershipModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );
    return AlertDialog(
      backgroundColor: colors.white,
      scrollable: true,
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      titlePadding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      titleTextStyle: const TextStyle(
        fontFamily: "Comfortaa",
        color: colors.darkBlue,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${AppLocalizations.of(context)!.pending_membership}",
            style: const TextStyle(fontFamily: "Comfortaa"),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 30,),
            color: colors.darkBlue,
            onPressed: () {
              Navigator.of(context).pop(); 
            },
          ),
        ],
      ),
      content: Container(
        color: colors.white,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: 30,
                top: 30,
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
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 240,
                        height: 240,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(
                              images.membershipDebt,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      "${AppLocalizations.of(context)!.pending_membership_payment}  ${mainProvider.userType == UserRole.student ? AppLocalizations.of(context)!.payment_by_guardian : ''}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "Comfortaa",
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
            if (mainProvider.userType == UserRole.tutor)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ModalActionButton(
                    backgroundColor: const Color(0xffffa66a).withOpacity(0.15),
                    primaryColor: const Color(0xffffa66a),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    onTap: () {
                      mainProvider.resetMembershipCart();
                      Navigator.of(context).pushNamed(
                        router.panamaMembershipDeptors,
                      );
                    },
                    text: AppLocalizations.of(context)!.pay_now,
                    textFontSize: 20,
                    textFontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
