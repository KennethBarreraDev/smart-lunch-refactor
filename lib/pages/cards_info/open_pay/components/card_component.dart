import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/widgets/circled_icon.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_graphics/vector_graphics.dart';

import 'delete_card_modal.dart';

class CardComponent extends StatelessWidget {
  const CardComponent(
      {super.key,
      required this.holderName,
      required this.brand,
      required this.cardNumber,
      required this.expirationDate,
      required this.isMainCard,
      // required this.isDirectCard,
      required this.cardId,
      required this.internalCardId,
      required this.accessToken,
      required this.loadPage,
      this.isDirectCard = false,
      this.onChangedMainCard,
      this.onChangedDirectCard,
      this.appLocalizations,
      this.hideCard = true
      });

  final String holderName;
  final String brand;
  final String cardNumber;
  final String expirationDate;
  final bool isMainCard;
  final bool isDirectCard;
  final String cardId;
  final int internalCardId;
  final String accessToken;
  final AppLocalizations? appLocalizations;
  final void Function(String, String, String, int, AppLocalizations?)?
      onChangedMainCard;
  final void Function(
    bool,
  )? onChangedDirectCard;
  final void Function({int internalCardId, bool isNewCard}) loadPage;
  final bool hideCard;

  @override
  Widget build(BuildContext context) {
    print("Brand is $brand");
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FractionallySizedBox(
          widthFactor: MediaQuery.of(context).size.width > 650 ? 0.7 : 0.95,
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 220,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: colors.cardShadow,
                        offset: Offset(0, 15),
                        blurRadius: 34,
                        spreadRadius: -15,
                      ),
                    ],
                  ),
                  child: const SvgPicture(
                    AssetBytesLoader(images.cardImg),
                    semanticsLabel: "card",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 33,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            holderName.split("").join("\u200b"),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 120,
                            maxHeight: 80,
                          ),
                          child: brand.isNotEmpty
                              ? Image.asset(
                                  images.getCardBrandImage(brand),
                                )
                              : Container(),
                          // Image.asset(images.mastercardLogo),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          !hideCard ? cardNumber :"•••• $cardNumber",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 24.0,
                          ),
                        ),
                        Text(
                          expirationDate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 24.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    /*isMainCard
                        ? const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Row(
                                //   children: [
                                //      Icon(
                                //       Icons.autorenew,
                                //       color: Colors.white,
                                //     ),
                                //      Text(
                                //       "Domiciliar tarjeta",
                                //       style: TextStyle(
                                //         color: Colors.white,
                                //         fontWeight: FontWeight.w300,
                                //         fontSize: 12.0,
                                //       ),
                                //     ),
                                //     Switch(
                                //       value: isDirectCard,
                                //       activeTrackColor: colors.lightGreen,
                                //       activeColor: Colors.white,
                                //       onChanged: onChangedDirectCard,
                                //     ),
                                //   ],
                                // ),
                                Icon(
                                  Icons.credit_score,
                                  color: colors.limeGreen,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "Principal",
                                  style: TextStyle(
                                    color: colors.limeGreen,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  onChangedMainCard?.call(
                                    accessToken,
                                    cardId,
                                    internalCardId,
                                    appLocalizations
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                  ),
                                  backgroundColor: const Color(0xffd8feff),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.credit_score_outlined,
                                      color: colors.lightGreen,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "Elegir como principal",
                                        maxLines: 1,
                                        softWrap: false,
                                        style: TextStyle(
                                          color: colors.lightGreen,
                                          // color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.0,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),*/
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            /*GestureDetector(
              onTap: () {
                loadPage.call(
                  internalCardId: internalCardId,
                  isNewCard: false,
                );
                Navigator.pushNamed(
                  context,
                  router.registerCardRoute,
                  arguments: RegisterCardPageArguments(
                    isNewCard: false,
                  ),
                );
              },
              child: const CircledIcon(
                color: Color(0xFFF0BC56),
                iconData: Icons.edit,
                padding: 8,
                width: 44,
                height: 44,
              ),
            ),
            const SizedBox(
              width: 14,
            ),*/
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  useSafeArea: true,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return DeleteCardModal(
                      cardId: cardId,
                      cardNumber: cardNumber,
                    );
                  },
                );
              },
              child: const CircledIcon(
                color: Color(0xFFf05756),
                iconData: Icons.delete,
                padding: 8,
                width: 44,
                height: 44,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
