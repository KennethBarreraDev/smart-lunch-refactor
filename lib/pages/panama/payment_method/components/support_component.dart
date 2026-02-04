import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;

class SupportComponent extends StatelessWidget {
  const SupportComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return ((homeProvider.cafeteria?.email ?? '').isNotEmpty ||
              (homeProvider.cafeteria?.phone ?? "").isNotEmpty)
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black.withOpacity(0.1),
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: AssetImage(
                                      images.supportImage,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(AppLocalizations.of(context)!
                                  .need_help_question)
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [

                              (homeProvider.cafeteria?.phone ?? '').isNotEmpty ?
                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    size: 17,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    (homeProvider.cafeteria?.phone ?? ''),
                                    style: const TextStyle(
                                        fontFamily: 'Comfortaa',
                                        fontSize: 12),
                                  )
                                ],
                              ):Container(),
                              const SizedBox(
                                width: 10,
                              ),
                              (homeProvider.cafeteria?.email ?? '').isNotEmpty ?
                              Row(
                                children: [
                                  const Icon(
                                    Icons.mail,
                                    size: 17,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    (homeProvider.cafeteria?.email ?? ''),
                                    style: const TextStyle(
                                        fontFamily: 'Comfortaa',
                                        fontSize: 12),
                                  )
                                ],
                              ):
                              Container()
                            ],
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            )
          : Container();
    });
  }
}
