import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/models/register_card_page_arguments.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/providers.dart';
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;

class YappiButton extends StatelessWidget {
  const YappiButton({super.key, required this.onTap, required this.loading});

    final void Function() onTap;
    final bool loading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 8),
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: onTap,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xff004C97),
                    side: const BorderSide(color: Color(0xff004C97)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: 
                 loading ?
                 const Center(child: CircularProgressIndicator(color: Colors.white,)) :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.pay_with,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Comfortaa",
                            fontSize: 15),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: 90,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: AssetImage(
                              images.yappiImage,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
