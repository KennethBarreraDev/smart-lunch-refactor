import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:smart_lunch/pages/history/history_provider.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';

class TransparentScaffold extends StatelessWidget {
  const TransparentScaffold({
    super.key,
    required this.body,
    required this.selectedOption,
    this.showDrawer = true,
  });

  final Widget? body;
  final String selectedOption;
  final bool showDrawer;

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: true,
    );
    StorageProvider storageProvider = Provider.of<StorageProvider>(
      context,
      listen: false,
    );
    HomeProvider homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );
    HistoryProvider historyProvider = Provider.of<HistoryProvider>(
      context,
      listen: false,
    );

    CardsInfoProvider cardsInfoProvider = Provider.of<CardsInfoProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colors.white,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(5),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Container(),
        ),
      ),
      drawer: showDrawer
          ? Drawer(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFFA66A),
                      Color(0xFFEF5360),
                    ],
                    begin: FractionalOffset(0, 0),
                    end: FractionalOffset(0, 1),
                    stops: [
                      0,
                      1,
                    ],
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: [
                            SizedBox(
                              height: 400,
                              child: DrawerHeader(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.menu,
                                      style: const TextStyle(
                                        color: Color(0xfff8fdff),
                                        fontSize: 20.0,
                                        fontFamily: "Comfortaa",
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color:
                                                colors.white.withOpacity(0.25),
                                            width: 3,
                                          ),
                                        ),
                                        child: Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: mainProvider.userType ==
                                                          UserRole.tutor ||
                                                      mainProvider.userType ==
                                                          UserRole.teacher
                                                  ? (mainProvider
                                                              .tutor
                                                              ?.profilePictureUrl
                                                              .isNotEmpty ??
                                                          false
                                                      ? BoxFit.cover
                                                      : BoxFit.contain)
                                                  : (mainProvider
                                                              .selectedChild
                                                              ?.imageUrl
                                                              .isNotEmpty ??
                                                          false
                                                      ? BoxFit.cover
                                                      : BoxFit.contain),
                                              image: mainProvider.userType ==
                                                          UserRole.tutor ||
                                                      mainProvider.userType ==
                                                          UserRole.teacher
                                                  ? (mainProvider
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
                                                          Object>)
                                                  : (mainProvider
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
                                                          Object>),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Expanded(
                                      child: Text(
                                        mainProvider.userType ==
                                                    UserRole.tutor ||
                                                mainProvider.userType ==
                                                    UserRole.teacher
                                            ? "${mainProvider.tutor?.firstName} ${mainProvider.tutor?.lastName}"
                                            : "${mainProvider.selectedChild?.childName} ${mainProvider.selectedChild?.childLastName}",
                                        style: const TextStyle(
                                          color: colors.white,
                                          fontSize: 24.0,
                                          fontFamily: "Comfortaa",
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      mainProvider.userType == UserRole.tutor
                                          ? AppLocalizations.of(context)!.tutor
                                          : mainProvider.userType ==
                                                  UserRole.teacher
                                              ? AppLocalizations.of(context)!
                                                  .teacher
                                              : AppLocalizations.of(context)!
                                                  .student,
                                      style: TextStyle(
                                        color: colors.white.withOpacity(0.5),
                                        fontSize: 16.0,
                                        fontFamily: "Comfortaa",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DrawerOption(
                                  title: AppLocalizations.of(context)!.home,
                                  icon: Icons.house,
                                  isSelected: selectedOption == "Inicio",
                                  route: (mainProvider.userType ==
                                              UserRole.tutor &&
                                          (homeProvider.cafeteria?.school
                                                      .country ??
                                                  "") ==
                                              Contries.panama)
                                      ? router.panamaHome
                                      : (mainProvider.userType ==
                                                      UserRole.student &&
                                                  mainProvider.selectedChild!
                                                      .isIndependent) ||
                                              mainProvider.userType ==
                                                  UserRole.teacher
                                          ? router.independentHomeRoute
                                          : router.homeRoute,
                                  onTap: () {
                                    mainProvider.loadCafeteriaSetting();
                                    mainProvider.loadBalance();
   
                                    mainProvider.loadDebtorsChildren();

                                    homeProvider.homePageRefresh(
                                        mainProvider.accessToken,
                                        mainProvider.cafeteriaId,
                                        int.parse(mainProvider.studentId),
                                        mainProvider.userType,
                                        mainProvider.userType == UserRole.tutor
                                            ? false
                                            : mainProvider.selectedChild
                                                    ?.isIndependent ??
                                                false);
                                    historyProvider.initialLoad(
                                        mainProvider.accessToken,
                                        mainProvider.cafeteriaId,
                                        int.parse(mainProvider.studentId),
                                        mainProvider.userType);
                                  },
                                ),
                                mainProvider.userType == UserRole.tutor
                                    ? DrawerOption(
                                        title: AppLocalizations.of(context)!
                                            .children,
                                        icon: Icons.face,
                                        isSelected: selectedOption == "Hijos",
                                        route: router.childrenRoute,
                                      )
                                    : DrawerOption(
                                        title: AppLocalizations.of(context)!
                                            .history,
                                        icon: Icons.bar_chart,
                                        isSelected:
                                            selectedOption == "Historial",
                                        route: router.historyRoute,
                                        onTap: () {
                                          historyProvider.initialLoad(
                                              mainProvider.accessToken,
                                              mainProvider.cafeteriaId,
                                              int.parse(mainProvider.studentId),
                                              mainProvider.userType);
                                        },
                                      ),
                              ],
                            ),
                            mainProvider.userType == UserRole.tutor
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      DrawerOption(
                                        title: AppLocalizations.of(context)!
                                            .history,
                                        icon: Icons.bar_chart,
                                        isSelected:
                                            selectedOption == "Historial",
                                        route: router.historyRoute,
                                        onTap: () {
                                          historyProvider.initialLoad(
                                              mainProvider.accessToken,
                                              mainProvider.cafeteriaId,
                                              int.parse(mainProvider.studentId),
                                              mainProvider.userType);
                                        },
                                      ),
                                      DrawerOption(
                                        title: AppLocalizations.of(context)!
                                            .settings,
                                        icon: Icons.settings,
                                        isSelected: selectedOption == "Ajustes",
                                        route: router.settingsRoute,
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: DrawerOption(
                                          title: AppLocalizations.of(context)!
                                              .settings,
                                          icon: Icons.settings,
                                          isSelected:
                                              selectedOption == "Ajustes",
                                          route: router.settingsRoute,
                                        ),
                                      ),
                                    ],
                                  ),

                            /*
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  DrawerOption(
                                    title: "Ajustes",
                                    icon: Icons.settings,
                                    isSelected: selectedOption == "Ajustes",
                                    route: router.settingsRoute,
                                  ),
                                  Container(width: MediaQuery.of(context).size.width*0.4,)
                                ],
                              ),*/

                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 50,
                              ),
                              child: Column(
                                children: [
                                  const Divider(
                                    color: colors.white,
                                  ),
                                  ListTile(
                                    onTap: () {
                                      cardsInfoProvider.cards.clear();
                                      mainProvider.logout(storageProvider, homeProvider).then(
                                        (value) {
                                          Navigator.of(context).popUntil(
                                            (route) => false,
                                          );
                                          Navigator.pushNamed(
                                            context,
                                            router.loginRoute,
                                          );
                                        },
                                      );
                                    },
                                    horizontalTitleGap: 0,
                                    contentPadding: const EdgeInsets.only(
                                      top: 20,
                                      left: 16,
                                      right: 16,
                                    ),
                                    leading: const Icon(
                                      Icons.logout,
                                      color: colors.white,
                                      size: 32,
                                    ),
                                    title: Text(
                                      AppLocalizations.of(context)!.log_out,
                                      style: const TextStyle(
                                        color: colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20.0,
                                        fontFamily: "Comfortaa",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: body,
    );
  }
}

class DrawerOption extends StatelessWidget {
  const DrawerOption({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.route,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final String route;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap?.call();
          }
          Navigator.of(context).popUntil(
            ModalRoute.withName(router.homeRoute),
          );
          if (route != router.homeRoute) {
            Navigator.of(context).pushNamed(route);
          }
        },
        child: Container(
          margin: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(81),
            ),
            border: Border.all(
              color: colors.white.withOpacity(0.15),
            ),
            color: isSelected
                ? colors.white.withOpacity(0.25)
                : Colors.transparent,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 40,
                color: colors.white,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 12.0,
                  fontFamily: "Comfortaa",
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
