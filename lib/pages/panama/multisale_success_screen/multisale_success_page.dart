import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multiple_sale_provider.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/routes/router.dart' as router;

import 'dart:math';
import 'package:vector_graphics/vector_graphics.dart';

class MultisaleSuccessPage extends StatelessWidget {
  const MultisaleSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 2,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                colors.tuitionGreen.withOpacity(0.2),
                colors.tuitionGreen,
              ],
            )),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).maybePop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                AppLocalizations.of(context)!
                                    .purchase_successfully_mesage,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 150,
                    child: SvgPicture(
                      AssetBytesLoader(images.successfulSaleImage),
                      semanticsLabel: "successfulSaleImage",
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Consumer<MultisaleProvider>(
                            builder: (context, multisaleProvider, child) {
                          return Container(
                            height: multisaleProvider.multisaleProducts
                                        .where((element) => element.selected)
                                        .length <
                                    3
                                ? 400
                                : 600,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .summary_sale_message,
                                      style: const TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: (multisaleProvider
                                                          .selectedChild
                                                          ?.imageUrl ??
                                                      "")
                                                  .isNotEmpty
                                              ? NetworkImage((multisaleProvider
                                                      .selectedChild
                                                      ?.imageUrl ??
                                                  ""))
                                              : const AssetImage(images
                                                      .defaultProfileStudentImage)
                                                  as ImageProvider<Object>,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${multisaleProvider.selectedChild?.childName} ${multisaleProvider.selectedChild?.childLastName}",
                                      style: const TextStyle(
                                          color: colors.darkBlue,
                                          fontSize: 18,
                                          fontFamily: "Comfortaa",
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  color: Colors.white,
                                  height: multisaleProvider.multisaleProducts
                                              .where(
                                                  (element) => element.selected)
                                              .length <
                                          3
                                      ? 180
                                      : 380,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: multisaleProvider
                                          .multisaleProducts
                                          .where((element) => element.selected)
                                          .map((element) => Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: const Color.fromARGB(
                                                            255, 184, 184, 184)
                                                        .withOpacity(0.1)
                                                        .withOpacity(0.1)),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .delivery_date_message,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  "Comfortaa",
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .price_message,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  "Comfortaa",
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          DateFormat(
                                                                  "EEEE',' d 'de' MMMM  'de' y",
                                                                  'es')
                                                              .format(element
                                                                  .saleDate),
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  "Comfortaa"),
                                                        ),
                                                        Text(
                                                          element.totalPrice
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  "Comfortaa"),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Divider(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    )
                                                  ],
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    mainProvider.getFamilyBalance();
                                    multisaleProvider.resetValues();
                                    Navigator.of(context).pushNamed(
                                      router.panamaHome,
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: const Color(0xffffa66a)
                                                .withOpacity(0.2)),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.arrow_back,
                                              color: Color(0xffffa66a),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Regresar",
                                              style: TextStyle(
                                                  color: Color(0xffffa66a),
                                                  fontFamily: "Comfortaa"),
                                            )
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
