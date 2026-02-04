import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/widgets/modal_action_button.dart';
import 'package:smart_lunch/utils/images.dart' as images;

class StudentInformationModal extends StatelessWidget {
  const StudentInformationModal({
    super.key,
    required this.imageUrl,
    required this.childName,
    required this.dailySpendLimit,
    required this.allergies,
  });

  final String imageUrl;
  final String childName;
  final double dailySpendLimit;
  final List<int> allergies;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: false,
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      insetPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      titleTextStyle: const TextStyle(
        fontSize: 24.0,
        color: Color(0xff413931),
        fontFamily: "Comfortaa",
      ),
      title: Text(
        AppLocalizations.of(context)!.student_information,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Stack(
          children: [
            Container(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: imageUrl.isNotEmpty
                                            ? BoxFit.cover
                                            : BoxFit.contain,
                                        image: imageUrl.isNotEmpty
                                            ? NetworkImage(
                                                imageUrl,
                                              )
                                            : const AssetImage(
                                                images
                                                    .defaultProfileStudentImage,
                                              ) as ImageProvider<Object>,
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
                                        childName,
                                        style: const TextStyle(
                                          color: Color(0xff413931),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Comfortaa",
                                          fontSize: 20,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.monetization_on,
                                    color: Colors.black.withOpacity(0.6)),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.daily_limit,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: 16,
                                      fontFamily: "Comfortaa"),
                                )
                              ],
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 11),
                                child: Text(
                                  "\$${dailySpendLimit.toString()}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Comfortaa",
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.warning_amber,
                                    color: Colors.black.withOpacity(0.6)),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .allergies_message,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: 16,
                                      fontFamily: "Comfortaa"),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Consumer<AllergyProvider>(
                                  builder: (context, allergyProvider, child) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 11),
                                  child: Text(
                                    allergies.isEmpty
                                        ? "Sin alergias"
                                        : allergyProvider.allergies
                                            .where((element) =>
                                                allergies.contains(element.id))
                                            .toList()
                                            .map((e) => e.name)
                                            .toList()
                                            .join(","),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Comfortaa",
                                        fontWeight: FontWeight.normal),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ModalActionButton(
                            backgroundColor:
                                const Color(0xffef5360).withOpacity(0.15),
                            primaryColor: const Color(0xffef5360),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            text: AppLocalizations.of(context)!.close_button,
                            textFontSize: 20,
                            textFontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
