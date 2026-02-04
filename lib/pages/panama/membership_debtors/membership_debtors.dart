import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/home/components/rounded_button.dart';
import 'package:smart_lunch/pages/panama/membership_debtors/student_membership_component.dart';
import 'package:smart_lunch/pages/panama/membership_modal/membership_provider.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/custom_banner.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';

class PanamaMembershipDebtors extends StatelessWidget {
  const PanamaMembershipDebtors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MembershipProvider membershipProvider = Provider.of<MembershipProvider>(
      context,
      listen: false,
    );

    CardsCroemProvider croemCardInfo = Provider.of<CardsCroemProvider>(
      context,
      listen: false,
    );

    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );
    return TransparentScaffold(
      selectedOption: "Hijos",
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    CustomAppBar(
                      height: 140,
                      showDrawer: false,
                      showPageTitle: true,
                      pageTitle:
                          AppLocalizations.of(context)!.membership_payment,
                      image: images.appBarShortImg,
                      titleAlignment: Alignment.centerLeft,
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.user_message,
                                style: const TextStyle(
                                    fontFamily: "Comfortaa", fontSize: 16),
                              ),
                              Text(
                                AppLocalizations.of(context)!.amount_message,
                                style: const TextStyle(
                                    fontFamily: "Comfortaa", fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Expanded(
                          child: Consumer<MainProvider>(
                            builder: (context, mainProvider, widget) =>
                                ListView(
                              shrinkWrap: false,
                              padding: EdgeInsets.zero,
                              children: [
                                ...mainProvider.membershipDebtors
                                    .map((child) => StudentMembershipComponent(
                                          image: mainProvider.children
                                              .where((element) =>
                                                  element.id == child.id)
                                              .first
                                              .imageUrl,
                                          name: child.childName,
                                          lastName: child.childLastName,
                                          membershipAmount: mainProvider
                                                  .membershipCart
                                                  .containsKey(child.id)
                                              ? (mainProvider.membershipCart[
                                                      child.id] ??
                                                  0)
                                              : 0,
                                          studentId: child.id,
                                          addItems: mainProvider.addItem,
                                          removeItems: mainProvider.removeItem,
                                          expiration:
                                              (child.membershipExpiration ??
                                                  ""),
                                          minMembeshipAmount: (DateTime.tryParse(
                                                          child.membershipExpiration ??
                                                              "") !=
                                                      null &&
                                                  (DateTime.tryParse(child
                                                                  .membershipExpiration ??
                                                              "")
                                                          ?.isBefore(
                                                              DateTime.now()) ??
                                                      false)
                                              ? 0
                                              : 0),
                                        ))
                                    .toList(),
                                Consumer<MainProvider>(
                                    builder: (context, mainProvider, widget) =>
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .subtotal,
                                                style: const TextStyle(
                                                  fontFamily: "Comfortaa",
                                                  fontSize: 18,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                maxLines: 1,
                                              ),
                                              Text(
                                                "\$${mainProvider.membershipTotalPrice.abs().toStringAsFixed(2)}",
                                                style: const TextStyle(
                                                  fontFamily: "Comfortaa",
                                                  fontSize: 25,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                maxLines: 1,
                                              )
                                            ],
                                          ),
                                        )),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    "* ${AppLocalizations.of(context)!.pay_membership_legend}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Comfortaa",
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Consumer<MainProvider>(
                            builder: (context, mainProvider, child) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RoundedButton(
                              color: mainProvider.membershipCart.isEmpty
                                  ? Colors.grey
                                  : colors.tuitionGreen,
                              iconData: Icons.payments,
                              text: "Pagar",
                              verticalPadding: 14,
                              mainAxisAlignment: MainAxisAlignment.center,
                              onTap: () async {
                                if (mainProvider.membershipCart.isNotEmpty) {
                                  if (croemCardInfo.cards.isEmpty) {
                                    await croemCardInfo.getCardList(
                                        mainProvider.accessToken,
                                        mainProvider.cafeteriaId);
                                  }
                                  Navigator.of(context).pushNamed(
                                    router.payMembership,
                                    //router.mercadoPagoPage
                                  );
                                }
                              },
                            ),
                          );
                        })
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Consumer<MembershipProvider>(
              builder: (context, membershipProvider, widget) => CustomBanner(
                bannerType: membershipProvider.membershipPaymentStatus,
                bannerMessage:
                    membershipProvider.membershipPaymentBannerMessage,
                hideBanner: membershipProvider.hideBanner,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
