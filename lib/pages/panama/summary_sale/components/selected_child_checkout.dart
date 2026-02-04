import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/pages/providers.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';

class SelectedChildCheckout extends StatelessWidget {
  const SelectedChildCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<MainProvider, SaleProvider>(
        builder: (context, mainProvider, saleProvider, child) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.order_information,
              style: const TextStyle(
                color: colors.darkBlue,
                fontWeight: FontWeight.w600,
                fontSize: 12.0,
                fontFamily: "Comfortaa",
              ),
            ),
            Divider(color: colors.darkBlue.withOpacity(0.15)),
            const SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.11,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: mainProvider.userType == UserRole.teacher
                          ? mainProvider.tutor!.profilePictureUrl.isNotEmpty
                              ? NetworkImage(
                                  mainProvider.tutor!.profilePictureUrl)
                              : const AssetImage(
                                      images.defaultProfileStudentImage)
                                  as ImageProvider<Object>
                          : mainProvider.selectedChild!.imageUrl.isNotEmpty
                              ? NetworkImage(
                                  mainProvider.selectedChild!.imageUrl)
                              : const AssetImage(
                                      images.defaultProfileStudentImage)
                                  as ImageProvider<Object>,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    mainProvider.userType == UserRole.teacher
                        ? "${mainProvider.tutor!.firstName} ${mainProvider.tutor!.lastName}"
                        : "${mainProvider.selectedChild!.childName} ${mainProvider.selectedChild!.childLastName}",
                    style: const TextStyle(
                      color: colors.darkBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: 15.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!.delivery_date,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontFamily: "Comfortaa"),
            ),
            saleProvider.saleType != "PS"
                ? Text(
                    (mainProvider.selectedChild?.isIndependent ?? false)
                        ? DateFormat(
                                "EEEE',' d 'de' MMMM  'de' y',' HH:mm", 'es')
                            .format(saleProvider.timeScheduled)
                            .toString()
                        : DateFormat(
                                "EEEE',' d 'de' MMMM  'de' y", 'es')
                            .format(saleProvider.timeScheduled)
                            .toString(),
                    style: const TextStyle(
                        color: Colors.black, fontFamily: "Comfortaa"),
                  )
                : Text(
                  (mainProvider.selectedChild?.isIndependent ?? false)?
                    DateFormat("EEEE',' d 'de' MMMM  'de' y',' HH:mm", 'es')
                        .format(saleProvider.selectedDate)
                        .toString():
                         DateFormat("EEEE',' d 'de' MMMM  'de' y", 'es')
                        .format(saleProvider.selectedDate)
                        .toString()
                        
                        ,
                    style: const TextStyle(
                        color: Colors.black, fontFamily: "Comfortaa"),
                  )
          ],
        ),
      );
    });
  }
}
