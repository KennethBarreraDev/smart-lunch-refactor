import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/panama/static_values.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/colors.dart' as colors;

class StudentMembershipComponent extends StatelessWidget {
  const StudentMembershipComponent(
      {super.key,
      required this.image,
      required this.name,
      required this.lastName,
      required this.addItems,
      required this.removeItems,
      required this.membershipAmount,
      required this.studentId,
      required this.expiration,
      required this.minMembeshipAmount
      });

  final String image;
  final String name;
  final String lastName;
  final int studentId;
  final int minMembeshipAmount;
  final int membershipAmount;
  final void Function(int minumunAmount, int studentId) removeItems;
  final void Function(int studentId) addItems;
  final String expiration;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: image.isNotEmpty
                            ? NetworkImage(image)
                            : const AssetImage(
                                    images.defaultProfileStudentImage)
                                as ImageProvider<Object>,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${name} ${lastName}",
                        style: const TextStyle(
                            color: colors.darkBlue,
                            fontSize: 16,
                            fontFamily: "Comfortaa",
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${AppLocalizations.of(context)!.membership_expiration }: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(expiration))}",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Comfortaa",
                            color: 
                            DateTime.parse(expiration).isBefore(DateTime.now()) ? 
                            Colors.red :
                            colors.tuitionGreen),
                      )
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: colors.orange,
                        ),
                        iconSize: 30,
                        onPressed: () {
                          removeItems.call(minMembeshipAmount,studentId);
                        },
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "$membershipAmount",
                          style: const TextStyle(
                            color: colors.darkBlue,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add_circle,
                          color: colors.orange,
                        ),
                        iconSize: 30,
                        onPressed: () {
                          addItems.call(studentId);
                        },
                      ),
                    ],
                  ),
                  Text(
                    "\$${(YappyValues.membershipPrice * membershipAmount).toStringAsFixed(2)}",
                    style: const TextStyle(
                        color: colors.darkBlue,
                        fontSize: 15,
                        fontFamily: "Comfortaa",
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Divider(
            color: Colors.grey.withOpacity(0.2),
          ),
          const SizedBox(
            height: 21,
          ),
        ],
      ),
    );
  }
}
