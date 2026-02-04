import 'package:flutter/material.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/widgets/circled_icon.dart';

Widget getIconFromBannerType(String bannerType) {
  if (bannerType == BannerTypes.successBanner.type) {
    return const CircledIcon(
      iconData: Icons.check_circle,
      color: colors.tuitionGreen,
      padding: 7,
    );
  } else if (bannerType == BannerTypes.warningBanner.type) {
    return const CircledIcon(
      iconData: Icons.warning,
      color: colors.gold,
      padding: 7,
    );
  } else if (bannerType == BannerTypes.errorBanner.type) {
    return const CircledIcon(
      iconData: Icons.report,
      color: colors.tuitionRed,
      padding: 7,
    );
  } else {
    return const CircledIcon(
      iconData: Icons.info,
      color: colors.lightBlue,
      padding: 7,
    );
  }
}

enum BannerTypes {
  successBanner("success"),
  warningBanner("warning"),
  errorBanner("error"),
  infoBanner("info"),
  unknownError("unknown");

  const BannerTypes(this.type);
  final String type;
}
