import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/models/allergy_model.dart';
import 'package:smart_lunch/pages/children_info/child/child_provider.dart';
import 'package:smart_lunch/pages/children_info/child/components/allergies_modal.dart';
import 'package:smart_lunch/pages/children_info/child/components/spend_limit_modal.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/custom_banner.dart';
import 'package:smart_lunch/widgets/custom_text_input.dart';
import 'package:smart_lunch/widgets/profile_picture_avatar.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';
import 'components/information_card.dart';

class ChildPage extends StatelessWidget {
  const ChildPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllergyProvider allergyProvider = Provider.of<AllergyProvider>(
      context,
      listen: false,
    );

    return TransparentScaffold(
      selectedOption: "Hijos",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer<MainProvider>(
            builder: (context, mainProvider, widget) => CustomAppBar(
              height: 140,
              showPageTitle: true,
              pageTitle: mainProvider.selectedChild?.childName ?? "",
              image: images.appBarShortImg,
              titleAlignment: Alignment.bottomLeft,
              showDrawer: false,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 0,
                          right: 0,
                          // top: 90,
                        ),
                        child: DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              ColoredBox(
                                  color: colors.white,
                                  child: TabBar(
                                    labelColor: colors.orange,
                                    unselectedLabelColor:
                                        colors.orange.withOpacity(0.5),
                                    indicatorColor: colors.orange,
                                    labelPadding: EdgeInsets.zero,
                                    tabs: [
                                      Tab(
                                        text: AppLocalizations.of(context)!
                                            .student_information,
                                      ),
                                      Tab(
                                        text: AppLocalizations.of(context)!
                                            .student_management,
                                      ),
                                    ],
                                  )),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    SingleChildScrollView(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Consumer<ChildAccountProvider>(
                                            builder: (context, accountProvider,
                                                    widget) =>
                                                CustomBanner(
                                              bannerType:
                                                  accountProvider.bannerType,
                                              bannerMessage:
                                                  accountProvider.bannerMessage,
                                              hideBanner:
                                                  accountProvider.hideBanner,
                                            ),
                                          ),
                                          Consumer2<MainProvider,
                                                  ChildAccountProvider>(
                                              builder: (context,
                                                      mainProvider,
                                                      childAccountProvider,
                                                      widget) =>
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 24,
                                                      ),
                                                      ProfilePictureAvatar(
                                                        width: 160,
                                                        height: 160,
                                                        profileImageFile:
                                                            childAccountProvider
                                                                .profileImageFile,
                                                        profileImageUrl:
                                                            mainProvider
                                                                .selectedChild
                                                                ?.imageUrl,
                                                        onPressed:
                                                            childAccountProvider
                                                                .selectProfilePicture,
                                                      ),
                                                      const SizedBox(
                                                        height: 24,
                                                      ),
                                                      const SizedBox(
                                                        height: 24,
                                                      ),
                                                      CustomTextInput(
                                                        label:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .user_name,
                                                        textInputType:
                                                            TextInputType.name,
                                                        textCapitalization:
                                                            TextCapitalization
                                                                .words,
                                                        textEditingController:
                                                            childAccountProvider
                                                                .firstNameController
                                                              ..text = mainProvider
                                                                      .selectedChild
                                                                      ?.childName ??
                                                                  "",
                                                      ),
                                                      CustomTextInput(
                                                        label:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .user_lastname,
                                                        textInputType:
                                                            TextInputType.name,
                                                        textCapitalization:
                                                            TextCapitalization
                                                                .words,
                                                        textEditingController:
                                                            childAccountProvider
                                                                .lastNameController
                                                              ..text = mainProvider
                                                                      .selectedChild
                                                                      ?.childLastName ??
                                                                  "",
                                                      ),
                                                      FractionallySizedBox(
                                                        widthFactor: 1,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              vertical: 13,
                                                              horizontal: 24,
                                                            ),
                                                            backgroundColor:
                                                                colors
                                                                    .tuitionGreen
                                                                    .withOpacity(
                                                                        0.15),
                                                            shadowColor: Colors
                                                                .transparent,
                                                            shape:
                                                                const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    30),
                                                              ),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            mainProvider
                                                                .updateStudent(
                                                                    mainProvider
                                                                        .selectedChild!
                                                                        .id,
                                                                    childAccountProvider
                                                                        .firstNameController
                                                                        .text,
                                                                    childAccountProvider
                                                                        .lastNameController
                                                                        .text,
                                                                    base64Encode(
                                                                      childAccountProvider
                                                                              .profileImageFile
                                                                              ?.readAsBytesSync() ??
                                                                          [],
                                                                    ))
                                                                .then(
                                                              (bannerType) {
                                                                childAccountProvider
                                                                    .resetImage();
                                                                childAccountProvider
                                                                    .updateBanner(
                                                                  bannerType,
                                                                  AppLocalizations
                                                                      .of(context),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: !mainProvider
                                                                  .isLoading
                                                              ? Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .save_button,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        "Comfortaa",
                                                                    color: colors
                                                                        .tuitionGreen,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        16.0,
                                                                  ),
                                                                )
                                                              : const SizedBox(
                                                                  height: 16,
                                                                  width: 16,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: colors
                                                                        .tuitionGreen,
                                                                  ),
                                                                ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: ListView(
                                        padding: const EdgeInsets.only(top: 30),
                                        children: <Widget>[
                                          Consumer<MainProvider>(
                                            builder: (context, mainProvider,
                                                    widget) =>
                                                InformationCard(
                                              color: const Color(0xFF21A76F),
                                              title:
                                                  AppLocalizations.of(context)!
                                                      .daily_limit,
                                              iconData: Icons.attach_money,
                                              information: mainProvider
                                                          .selectedChild
                                                          ?.dailySpendLimit !=
                                                      0
                                                  ? "\$ ${mainProvider.numberFormat.format(mainProvider.selectedChild?.dailySpendLimit)}"
                                                  : AppLocalizations.of(
                                                          context)!
                                                      .unlimited_message,
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  useSafeArea: true,
                                                  builder:
                                                      (BuildContext context) {
                                                    return const SpendLimitModal();
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Consumer<MainProvider>(
                                            builder: (context, mainProvider,
                                                widget) {
                                              String allergy = "";

                                              if (mainProvider.selectedChild
                                                      ?.allergies.isNotEmpty ??
                                                  false) {
                                                List<Allergy> studentAllergies =
                                                    allergyProvider.allergies
                                                        .where(
                                                          (allergy) =>
                                                              mainProvider
                                                                  .selectedChild
                                                                  ?.allergies
                                                                  .contains(
                                                                      allergy
                                                                          .id) ??
                                                              false,
                                                        )
                                                        .toList();
                                                if (mainProvider
                                                    .otherAllergiesController
                                                    .text
                                                    .isNotEmpty) {
                                                  allergy = mainProvider
                                                      .otherAllergiesController
                                                      .text;
                                                  for (Allergy element
                                                      in studentAllergies) {
                                                    allergy +=
                                                        ", ${element.name}";
                                                  }
                                                } else {
                                                  allergy = studentAllergies
                                                      .first.name;
                                                  for (Allergy element
                                                      in studentAllergies
                                                          .skip(1)) {
                                                    allergy +=
                                                        ", ${element.name}";
                                                  }
                                                }
                                              } else if (mainProvider
                                                  .otherAllergiesController
                                                  .text
                                                  .isNotEmpty) {
                                                allergy = mainProvider
                                                    .otherAllergiesController
                                                    .text;
                                              } else {
                                                allergy = AppLocalizations.of(
                                                        context)!
                                                    .none_message;
                                              }

                                              return InformationCard(
                                                color: const Color(0xFFF0BC56),
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .allergies_message,
                                                iconData: Icons.warning_amber,
                                                information: allergy,
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    useSafeArea: true,
                                                    builder:
                                                        (BuildContext context) {
                                                      return const AllergiesModal();
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          Consumer3<MainProvider,
                                              ProductsProvider, HomeProvider>(
                                            builder: (context,
                                                    mainProvider,
                                                    productsProvider,
                                                    homeProvider,
                                                    widget) =>
                                                InformationCard(
                                              color: const Color(0xFFEF5360),
                                              title: !productsProvider
                                                      .loadingProducts
                                                  ? AppLocalizations.of(
                                                          context)!
                                                      .forbidden_products
                                                  : "${AppLocalizations.of(context)!.loading_message}...",
                                              iconData: Icons.no_food,
                                              information:
                                                  "${mainProvider.selectedChild?.forbiddenProducts.length} ${AppLocalizations.of(context)!.products}",
                                              onTap: () {
                                                if (!productsProvider
                                                    .loadingProducts) {
                                                  productsProvider.resetInput();
                                                  productsProvider.getProducts(
                                                      mainProvider.accessToken,
                                                      mainProvider.cafeteriaId,
                                                      (homeProvider
                                                                  .cafeteria
                                                                  ?.school
                                                                  .country ??
                                                              "") ==
                                                          Contries.panama, omitFilters: true);
                                                  Navigator.of(context)
                                                      .pushNamed(router
                                                          .forbiddenProductsRoute);
                                                }
                                              },
                                            ),
                                          ),
                                          Consumer3<MainProvider,
                                              ProductsProvider, HomeProvider>(
                                            builder: (context, mainProvider,
                                                    productsProvider, homeProvider, widget) =>
                                                InformationCard(
                                              color: const Color(0xFFFFA66A),
                                              title: !productsProvider
                                                      .loadingProducts
                                                  ? AppLocalizations.of(
                                                          context)!
                                                      .limited_products
                                                  : "${AppLocalizations.of(context)!.loading_message}...",
                                              iconData: Icons.free_breakfast,
                                              information:
                                                  "${mainProvider.selectedChild?.limitedProducts.length} ${AppLocalizations.of(context)!.products}",
                                              onTap: () {
                                                if (!productsProvider
                                                    .loadingProducts) {
                                                  productsProvider.resetInput();
                                                  productsProvider.getProducts(
                                                      mainProvider.accessToken,
                                                      mainProvider.cafeteriaId,
                                                      (homeProvider
                                                                  .cafeteria
                                                                  ?.school
                                                                  .country ??
                                                              "") ==
                                                          Contries.panama,
                                                          omitFilters: true
                                                      );
                                                  Navigator.of(context)
                                                      .pushNamed(router
                                                          .limitedProductsRoute);
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
