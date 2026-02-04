import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_components/providers/multiple_sale_provider.dart';
import 'package:smart_lunch/widgets/modal_action_button.dart';
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/colors.dart' as colors;

class CommentsModal extends StatelessWidget {
  CommentsModal({super.key, required this.controller, required this.onTap});

  var controller = TextEditingController();
  final void Function() onTap;

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
        AppLocalizations.of(context)!.add_comment,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
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
                                  child: TextField(
                                    controller: controller,
                                    onChanged: (value) {},
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)!
                                          .comments_message,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15.0, horizontal: 5),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color:
                                                Colors.black.withOpacity(0.2)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color:
                                                Colors.black.withOpacity(0.2)),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                    ),
                                  )),
                              const SizedBox(
                                width: 14,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ModalActionButton(
                          backgroundColor:
                              colors.tuitionGreen.withOpacity(0.15),
                          primaryColor: colors.tuitionGreen,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          onTap: ()=>{
                            onTap(),
                            Navigator.of(context).pop()
                          },
                          text: AppLocalizations.of(context)!.add_comment,
                          textFontSize: 14,
                          textFontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
