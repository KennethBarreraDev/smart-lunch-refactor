import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/main_provider.dart';
import 'package:smart_lunch/common_providers/storage_provider.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/history/history_provider.dart';
import 'package:smart_lunch/pages/home/components/rounded_button.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/modal_action_button.dart';

class SelectCafeteriaModal extends StatelessWidget {
  const SelectCafeteriaModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );

    HistoryProvider historyProvider = Provider.of<HistoryProvider>(
      context,
      listen: false,
    );

    StorageProvider storageProvider = Provider.of<StorageProvider>(
      context,
      listen: false,
    );

    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return Dialog(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        insetPadding: EdgeInsets.all(15),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: const BoxDecoration(
              color: colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 56),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...homeProvider.userCafeterias
                            .map(
                              (cafeteria) => ListTile(
                                minVerticalPadding: 12,
                                horizontalTitleGap: 12,
                                contentPadding: EdgeInsets.zero,
                                title: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            cafeteria?.logo ?? "",
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .cafeteria_text,
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 12),
                                        ),
                                        Text(
                                          cafeteria?.name ?? "",
                                          maxLines: 1,
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                trailing: Radio(
                                  value: cafeteria?.id,
                                  groupValue: homeProvider.selectedCafeteriaId,
                                  onChanged: (value) {
                                    homeProvider.setCafeteria(cafeteria);
                                  },
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    return colors.orange;
                                  }),
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                ),
                              ),
                            )
                            .toList(),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        child: !homeProvider.changingCafeteria
                            ? RoundedButton(
                                mainAxisAlignment: MainAxisAlignment.center,
                                color: colors.tuitionGreen,
                                iconData: Icons.check,
                                text:
                                    AppLocalizations.of(context)!.select_button,
                                onTap: () async {
                                  homeProvider.changeCafeteriaStatus(true);
                                  await homeProvider.changeCurrentCafeteria(
                                    storageProvider,
                                    mainProvider,
                                    homeProvider.selectedCafeteriaId,
                                  );

                                  await mainProvider.loadCafeteriaSetting();
                                  await mainProvider.loadBalance();

                                  await mainProvider.loadDebtorsChildren();

                                  await homeProvider.homePageRefresh(
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
                                  homeProvider.changeCafeteriaStatus(false);
                                  Navigator.of(context).pop();
                                },
                              )
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: colors.tuitionGreen,
                                  )
                                ],
                              ),
                      )),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
