import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/components/select_cafeteria.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_graphics/vector_graphics.dart';
import 'dart:io' show Platform;
import 'package:smart_lunch/l10n/app_localizations.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      required this.height,
      required this.image,
      this.showSchoolLogo = false,
      this.showPageTitle = false,
      this.pageTitle = "",
      this.titleAlignment = Alignment.bottomLeft,
      this.titleTopPadding = 0.4,
      this.showDrawer = true,
      this.schoolLogoUrl = "",
      this.schoolName = "",
      this.cafeteriaName = "",
      this.secondaryColor = false,
      this.titleSize = 32.0,
      this.hideGoBackText = false});

  final String image;
  final double height;
  final bool showSchoolLogo;
  final bool showPageTitle;
  final String pageTitle;
  final AlignmentGeometry titleAlignment;
  final double titleTopPadding;
  final bool showDrawer;
  final String schoolLogoUrl;
  final String schoolName;
  final String cafeteriaName;
  final bool secondaryColor;
  final double? titleSize;
  final bool hideGoBackText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: height,
          width: MediaQuery.of(context).size.width,
          child: SvgPicture(
            AssetBytesLoader(image),
            semanticsLabel: "App bar",
            fit: BoxFit.fill,
          ),
        ),
        showPageTitle
            ? Padding(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: (height * titleTopPadding) / 2.2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    showDrawer
                        ? Padding(
                            padding: EdgeInsets.only(
                              top: Platform.isIOS ? 30 : 10,
                            ),
                            child: Builder(
                              builder: (BuildContext context) {
                                return IconButton(
                                  icon: const Icon(Icons.menu),
                                  iconSize: 40,
                                  color: Colors.white,
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  tooltip: MaterialLocalizations.of(context)
                                      .openAppDrawerTooltip,
                                );
                              },
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.of(context).maybePop();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: Platform.isIOS ? 30 : 10,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.chevron_left,
                                    color: Colors.white,
                                    size: !hideGoBackText ? 40 : 60,
                                  ),
                                  if (!hideGoBackText)
                                    Text(
                                      AppLocalizations.of(context)!
                                          .go_back_button,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontFamily: "Comfortaa",
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                          top: Platform.isIOS ? 30 : 10,
                        ),
                        child: Text(
                          pageTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: titleSize,
                            fontFamily: "Comfortaa",
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03720930,
                  right: MediaQuery.of(context).size.width * 0.03720930,
                  top: !secondaryColor ? 70 : 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    showDrawer
                        ? Builder(
                            builder: (BuildContext context) {
                              return IconButton(
                                icon: const Icon(Icons.menu),
                                iconSize: 40,
                                color: Colors.white,
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                tooltip: MaterialLocalizations.of(context)
                                    .openAppDrawerTooltip,
                              );
                            },
                          )
                        : Container(),
                    if (showSchoolLogo)
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    cafeteriaName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24.0,
                                      fontFamily: "Comfortaa",
                                    ),
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        child: Icon(
                                          Icons.school,
                                          color: Colors.white.withOpacity(0.75),
                                          size: 16,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          schoolName,
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.75),
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12.0,
                                            fontFamily: "Comfortaa",
                                          ),
                                          textAlign: TextAlign.end,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Row(
                              children: [
                                schoolLogoUrl.isNotEmpty
                                    ? Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              schoolLogoUrl,
                                            ),
                                          ),
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 35,
                                        child: Text(
                                          schoolName.isNotEmpty
                                              ? schoolName[0].toUpperCase()
                                              : "",
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                Consumer<HomeProvider>(
                                  builder: (context, homeProvider, child) {
                                    return 
                                    homeProvider.userCafeterias.length>1 ?
                                    GestureDetector(
                                      child: const Icon(
                                        Icons.sync,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      onTap: () {
                                      
                                        homeProvider.setCafeteria(homeProvider.cafeteria);
                                        showDialog(
                                          context: context,
                                          useSafeArea: true,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return SelectCafeteriaModal();
                                          },
                                        );
                                      },
                                    ):Container();
                                  }
                                )
                              ],
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
      ],
    );
  }
}
