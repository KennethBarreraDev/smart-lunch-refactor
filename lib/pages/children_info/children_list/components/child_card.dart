import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/utils/images.dart' as images;

import 'description_text.dart';
import 'status_indicator.dart';

class ChildCard extends StatelessWidget {
  const ChildCard({
    super.key,
    required this.imageUrl,
    required this.childName,
    required this.registrationNumber,
    required this.id,
    required this.status,
    required this.membershipExpiration,
    this.onTap,
  });

  final String imageUrl;
  final String childName;
  final String registrationNumber;
  final String id;
  final String membershipExpiration;
  final String status;
  final void Function()? onTap;

  static const Map<String, Color> statusColor = {
    "Activo": Color(0xff12db87),
    "Inactivo": Color(0xfff0bc56),
  };

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.93,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 135,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
          margin: const EdgeInsets.only(
            bottom: 25,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: imageUrl.isNotEmpty ? BoxFit.cover : BoxFit.contain,
                      image: imageUrl.isNotEmpty
                          ? NetworkImage(
                              imageUrl,
                            )
                          : const AssetImage(
                              images.defaultProfileStudentImage,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      childName,
                      style: const TextStyle(
                        color: Color(0xff413931),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Comfortaa",
                        fontSize: 24,
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        DescriptionText(
                          title: AppLocalizations.of(context)!.registration,
                          description: registrationNumber,
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        DescriptionText(
                          title: "ID: ",
                          description: id,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    if(membershipExpiration.isEmpty)
                    StatusIndicator(
                      color: statusColor[status] ?? Colors.white,
                      status: status,
                    ),
                    if (membershipExpiration.isNotEmpty)
                      DateTime.parse(membershipExpiration)
                              .isBefore(DateTime.now())
                          ? Text(
                              "${AppLocalizations.of(context)!.membership_expiration} : ${DateFormat("dd/MM/yyyy").format(DateTime.parse(membershipExpiration))}",
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Comfortaa",
                              ),
                            )
                          : Text(
                              "${AppLocalizations.of(context)!.membership_expiration} : ${DateFormat("dd/MM/yyyy").format(DateTime.parse(membershipExpiration))}",
                              style: const TextStyle(
                                color: const Color(0xff12db87),
                                fontWeight: FontWeight.w300,
                                fontFamily: "Comfortaa",
                              ),
                            )
                  ],
                ),
              ),
              Expanded(
                child: Icon(
                  Icons.chevron_right,
                  size: 50,
                  color: const Color(0xff413931).withOpacity(.15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
