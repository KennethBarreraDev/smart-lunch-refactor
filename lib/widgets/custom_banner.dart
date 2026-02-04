import 'package:flutter/material.dart';
import 'package:smart_lunch/utils/banner_utils.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;

class CustomBanner extends StatelessWidget {
  const CustomBanner({
    super.key,
    required this.bannerType,
    required this.bannerMessage,
    required this.hideBanner,
  });

  final String bannerType;
  final String bannerMessage;
  final void Function()? hideBanner;

  @override
  Widget build(BuildContext context) {
    return bannerType.isNotEmpty
        ? Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4,
                  spreadRadius: 0,
                  offset: const Offset(
                    0,
                    4,
                  ),
                )
              ],
            ),
            child: MaterialBanner(
              content: Text(
                bannerMessage,
                style: const TextStyle(
                  color: colors.darkBlue,
                  fontWeight: FontWeight.w300,
                  fontSize: 18.0,
                ),
              ),
              leading: getIconFromBannerType(
                bannerType,
              ),
              forceActionsBelow: true,
              actions: [
                TextButton(
                  onPressed: hideBanner,
                  child: const Text(
                    "Cerrar",
                    style:  TextStyle(
                      color: Color(0xff1e2f97),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
