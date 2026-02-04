import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:smart_lunch/pages/preferences/lang/languaje_provider.dart';
import 'package:smart_lunch/pages/providers.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'components/settings_list_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<CardsInfoProvider>(
      context,
      listen: false,
    );
    Provider.of<MainProvider>(
      context,
      listen: false,
    );

    HomeProvider homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );

    CardsCroemProvider croemCardInfo = Provider.of<CardsCroemProvider>(
      context,
      listen: false,
    );

    return TransparentScaffold(
      selectedOption: "Ajustes",
      body: Column(
        children: [
          Consumer<MainProvider>(
            builder: (context, mainProvider, widget) => Expanded(
              child: Stack(
                children: [
                  CustomAppBar(
                    height: 320,
                    showPageTitle: true,
                    pageTitle: AppLocalizations.of(context)!.settings,
                    titleAlignment: Alignment.topRight,
                    image: images.appBarLongImg,
                    titleTopPadding: 0.3,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 150,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.93,
                        child: GestureDetector(
                          onTap: () {
                            if (mainProvider.userType == UserRole.tutor) {
                              Navigator.of(context)
                                  .pushNamed(router.accountRoute);
                            }
                          },
                          child: Container(
                            height: 135,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                              color: Colors.transparent,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 15,
                            ),
                            margin: const EdgeInsets.only(
                              bottom: 25,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: colors.white.withOpacity(0.25),
                                        width: 3,
                                      ),
                                    ),
                                    child: Container(
                                      width: 160,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: mainProvider.userType ==
                                                UserRole.tutor
                                            ? DecorationImage(
                                                fit: mainProvider
                                                            .tutor
                                                            ?.profilePictureUrl
                                                            .isNotEmpty ??
                                                        false
                                                    ? BoxFit.cover
                                                    : BoxFit.contain,
                                                image: mainProvider
                                                            .tutor
                                                            ?.profilePictureUrl
                                                            .isNotEmpty ??
                                                        false
                                                    ? NetworkImage(
                                                        mainProvider.tutor
                                                                ?.profilePictureUrl ??
                                                            "",
                                                      )
                                                    : const AssetImage(
                                                        images
                                                            .defaultProfileStudentImage,
                                                      ) as ImageProvider<
                                                        Object>,
                                              )
                                            : DecorationImage(
                                                fit: mainProvider
                                                            .selectedChild
                                                            ?.imageUrl
                                                            .isNotEmpty ??
                                                        false
                                                    ? BoxFit.cover
                                                    : BoxFit.contain,
                                                image: mainProvider
                                                            .selectedChild
                                                            ?.imageUrl
                                                            .isNotEmpty ??
                                                        false
                                                    ? NetworkImage(
                                                        mainProvider
                                                                .selectedChild
                                                                ?.imageUrl ??
                                                            "",
                                                      )
                                                    : const AssetImage(
                                                        images
                                                            .defaultProfileStudentImage,
                                                      ) as ImageProvider<
                                                        Object>,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        mainProvider.userType == UserRole.tutor
                                            ? "${mainProvider.tutor?.firstName} ${mainProvider.tutor?.lastName}"
                                            : "${mainProvider.selectedChild?.childName} ${mainProvider.selectedChild?.childLastName}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24.0,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        mainProvider.userType == UserRole.tutor
                                            ? "${AppLocalizations.of(context)!.family_message}: ${mainProvider.tutor?.lastName}"
                                            : "${AppLocalizations.of(context)!.family_message}: ${mainProvider.selectedChild?.childLastName}",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.3),
                                          fontSize: 12.0,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                mainProvider.userType == UserRole.tutor
                                    ? Expanded(
                                        child: Icon(
                                          Icons.chevron_right,
                                          size: 50,
                                          color: Colors.white.withOpacity(0.54),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 310),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 13,
                          ),
                          SettingsListTile(
                            title: AppLocalizations.of(context)!
                                .allow_notifications,
                            iconData: Icons.notifications_active,
                            iconColor: colors.gold,
                            trailing: Switch(
                              onChanged: (value) {},
                              value: true,
                              activeTrackColor: const Color(0xff12db87),
                              activeColor: Colors.white,
                            ),
                          ),
                          const Divider(),
                          Consumer2<MainProvider, CardsInfoProvider>(builder:
                              (context, mainProvider, cardsInfoProvider,
                                  widget) {
                            return (mainProvider
                                        .cafeteriaSetting?.openpayRecharge ??
                                    false)
                                ? Column(
                                    children: [
                                      SettingsListTile(
                                        title: (cardsInfoProvider.loadingCards || croemCardInfo.isLoadingCardList)
                                            ? "${AppLocalizations.of(context)!.loading_message}..."
                                            : AppLocalizations.of(context)!
                                                .payment_method,
                                        iconData: Icons.credit_card,
                                        iconColor: colors.lightGreen,
                                        trailing: Icon(
                                          Icons.chevron_right,
                                          color: const Color(0xff1C1B1F)
                                              .withOpacity(0.25),
                                          size: 35,
                                        ),
                                        onTap: () async {
                                          if (mainProvider.userType ==
                                                  UserRole.tutor &&
                                              (homeProvider.cafeteria?.school
                                                          .country ??
                                                      "") ==
                                                  Contries.panama) {
                                            if (!croemCardInfo
                                                .isLoadingCardList) {
                                              if (cardsInfoProvider
                                                  .cards.isEmpty) {
                                                await croemCardInfo.getCardList(
                                                    mainProvider.accessToken,
                                                    mainProvider.cafeteriaId);
                                              }

                                              Navigator.of(context)
                                                .pushNamed(router.croemCardsRoute);
                                            }
                                          } else if (!cardsInfoProvider
                                              .loadingCards) {
                                            await cardsInfoProvider.getCardList(
                                                mainProvider.accessToken,
                                                mainProvider.cafeteriaId);
                                            Navigator.of(context)
                                                .pushNamed(router.cardsRoute);
                                          }
                                        },
                                      ),
                                      const Divider(),
                                    ],
                                  )
                                : Container();
                          }),

                          Consumer2<LanguageProvider, StorageProvider>(builder:
                              (context, languageProvider, storageProvider,
                                  widget) {
                            return ListTile(
                              title: Text(
                                AppLocalizations.of(context)!.languaje_message,
                                style: const TextStyle(
                                    color: Color(0xff413931),
                                    fontSize: 22.0,
                                    fontFamily: "Comfortaa"),
                              ),
                              leading: const Icon(Icons.language,
                                  size: 35,
                                  color: Colors
                                      .red), // Cambia Colors.red por colors.tuitionRed si está definido
                              trailing: DropdownButton<Locale>(
                                value: languageProvider
                                    .locale, // Puedes cambiar el valor por el valor predeterminado
                                icon: Icon(Icons.arrow_drop_down,
                                    color: const Color(0xff1C1B1F)
                                        .withOpacity(0.25)),
                                underline: const SizedBox(),
                                onChanged: (Locale? newValue) {
                                  if (newValue != null) {
                                    languageProvider.changeLanguage(
                                        newValue, storageProvider);
                                  }
                                },
                                items: const [
                                  DropdownMenuItem(
                                    value: Locale('en'),
                                    child: Text('English'),
                                  ),
                                  DropdownMenuItem(
                                    value: Locale('es'),
                                    child: Text('Español'),
                                  ),
                                ],
                              ),
                              onTap:
                                  null, // Elimina el onTap ya que el DropdownButton se encargará de la interacción
                            );
                          }),

                          // const Divider(),
                          // SettingsListTile(
                          //   title: "Cupones",
                          //   iconData: Icons.local_activity,
                          //   iconColor: colors.tuitionRed,
                          //   trailing: Icon(
                          //     Icons.chevron_right,
                          //     color: const Color(0xff1C1B1F).withOpacity(0.25),
                          //     size: 35,
                          //   ),
                          //   onTap: () {
                          //     Navigator.of(context).pushNamed(router.couponListRoute);
                          //   },
                          // ),
                          // SettingsListTile(
                          //   title: AppLocalizations.of(context)!.change_password,
                          //   iconData: Icons.lock,
                          //   iconColor: colors.tuitionRed,
                          //   trailing: Icon(
                          //     Icons.chevron_right,
                          //     color: const Color(0xff1C1B1F).withOpacity(0.25),
                          //     size: 35,
                          //   ),
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .pushNamed(router.changeTutorPasswordRoute);
                          //   },
                          // ),
                          // const Divider(),

                          // Consumer4<CardsInfoProvider, CardsCroemProvider,
                          //         HomeProvider, MainProvider>(
                          //     builder: (context,
                          //         cardsInfoProvider,
                          //         croemCardInfo,
                          //         homeProvider,
                          //         mainProvider,
                          //         widget) {
                          //   return SettingsListTile(
                          //     title: "Tarjetas",
                          //     iconData: Icons.credit_card,
                          //     iconColor: colors.lightGreen,
                          //     trailing: Icon(
                          //       Icons.chevron_right,
                          //       color:
                          //           const Color(0xff1C1B1F).withOpacity(0.25),
                          //       size: 35,
                          //     ),
                          //     onTap: () async {
                          //       if (mainProvider.userType == UserRole.tutor &&
                          //           (homeProvider.cafeteria?.school.country ??
                          //                   "") ==
                          //               Contries.panama) {
                          //         if (cardsInfoProvider.cards.isEmpty) {
                          //           await croemCardInfo.getCardList(
                          //             mainProvider.accessToken,
                          //             mainProvider.cafeteriaId
                          //           );
                          //         }

                          //         Navigator.of(context)
                          //             .pushNamed(router.croemCardsRoute);
                          //       } else {
                          //         if (cardsInfoProvider.cards.isEmpty) {
                          //           await cardsInfoProvider.getCardList(
                          //             mainProvider.accessToken,
                          //             mainProvider.cafeteriaId
                          //           );
                          //         }
                          //         Navigator.of(context)
                          //             .pushNamed(router.cardsRoute);
                          //       }
                          //     },
                          //   );
                          // }),
                          // const Divider(),

                          // SettingsListTile(
                          //   title: "Promociones",
                          //   iconData: Icons.handyman,
                          //   iconColor: colors.coral,
                          //   trailing: Icon(
                          //     Icons.chevron_right,
                          //     color: const Color(0xff1C1B1F).withOpacity(0.25),
                          //     size: 35,
                          //   ),
                          //   onTap: () async {
                          //     Navigator.of(context)
                          //         .pushNamed(router.promotionsRoute);
                          //   },
                          // )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
