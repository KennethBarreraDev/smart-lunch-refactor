import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/roles.dart';
import 'package:smart_lunch/widgets/ticket_painter/draw_corners.dart';
import 'package:smart_lunch/widgets/ticket_painter/ticket_painter.dart';

class StudentIdentificationPage extends StatelessWidget {
  const StudentIdentificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 2,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xffEF5360),
                Color(0xffFFA66A),
              ],
            )),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.chevron_left,
                                color: Colors.white,
                                size: 45,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                AppLocalizations.of(context)!.digital_card,
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
                    height: 30,
                  ),
                  Consumer<MainProvider>(
                    builder: (context, mainProvider, widget) => Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 30),
                          height: 550,
                          margin: const EdgeInsets.all(16),
                          width: MediaQuery.of(context).size.width,
                          child: CustomPaint(
                            painter: TicketPainter(
                              borderColor: Colors.black,
                              bgColor: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 55),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          mainProvider.userType ==
                                                  UserRole.teacher
                                              ? "${mainProvider.tutor!.firstName} ${mainProvider.tutor!.lastName}"
                                              : "${mainProvider.selectedChild!.childName} ${mainProvider.selectedChild!.childLastName}",
                                          style: const TextStyle(
                                            color: colors.darkBlue,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18.0,
                                            fontFamily: "Comfortaa",
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          mainProvider.userType ==
                                                  UserRole.teacher
                                              ? AppLocalizations.of(context)!.teacher
                                              : AppLocalizations.of(context)!.student,
                                          style: const TextStyle(
                                            fontFamily: "Comfortaa",
                                            color: colors.orange,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.registration,
                                                style: const TextStyle(
                                                  fontFamily: "Comfortaa",
                                                  color: colors.orange,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12.0,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                maxLines: 1,
                                              ),
                                              Text(
                                                mainProvider.userType ==
                                                        UserRole.teacher
                                                    ? mainProvider.tutor!.email
                                                    : mainProvider
                                                        .selectedChild!
                                                        .studentId
                                                        .toString(),
                                                style: const TextStyle(
                                                  fontFamily: "Comfortaa",
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12.0,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(context)!.birth_date_message,
                                                    style: const TextStyle(
                                                      fontFamily: "Comfortaa",
                                                      color: colors.orange,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 11.0,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    maxLines: 1,
                                                  ),
                                                  Text(
                                                    DateFormat("dd - MM - yyyy")
                                                        .format(DateTime.parse(
                                                            mainProvider.userType ==
                                                                    UserRole
                                                                        .teacher
                                                                ? mainProvider
                                                                    .tutor!
                                                                    .birthDate
                                                                    .toString()
                                                                : mainProvider
                                                                    .selectedChild!
                                                                    .birthDate
                                                                    .toString()))
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontFamily: "Comfortaa",
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 12.0,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    maxLines: 1,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      (mainProvider.userType ==
                                                      UserRole.student &&
                                                  (mainProvider.selectedChild
                                                              ?.bands ??
                                                          [])
                                                      .isEmpty) ||
                                              ((mainProvider.userType ==
                                                          UserRole.teacher ||
                                                      mainProvider.userType ==
                                                          UserRole.tutor) &&
                                                  (mainProvider.tutor?.bands ??
                                                          [])
                                                      .isEmpty)
                                          ? Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Icon(
                                                  Icons.credit_card_off_rounded,
                                                  size: 90,
                                                  color: Colors.red
                                                      .withOpacity(0.5),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                    AppLocalizations.of(context)!.missing_smart_id,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontFamily:
                                                            "Comfortaa"),
                                                    textAlign: TextAlign.center),
                                                    const SizedBox(height: 40,)
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 40),
                                                  child: CustomPaint(
                                                    foregroundPainter:
                                                        BorderPainter(),
                                                    child: Container(
                                                      width: 130,
                                                      height: 130,
                                                      color: Colors.white,
                                                      child: Center(
                                                        child: QrImageView(
                                                          data: mainProvider
                                                                      .userType ==
                                                                  UserRole
                                                                      .student
                                                              ? (mainProvider
                                                                          .selectedChild
                                                                          ?.bands
                                                                          ?.first[
                                                                      "rfid"] ??
                                                                  "000")
                                                              : (mainProvider
                                                                          .tutor
                                                                          ?.bands
                                                                          ?.first[
                                                                      "rfid"] ??
                                                                  "000"),
                                                          version:
                                                              QrVersions.auto,
                                                          size: 200.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 15),
                                                  child: Text(mainProvider.userType ==
                                                          UserRole.student
                                                      ? (mainProvider
                                                              .selectedChild
                                                              ?.bands
                                                              ?.first["rfid"] ??
                                                          "000")
                                                      : (mainProvider.tutor?.bands
                                                              ?.first["rfid"] ??
                                                          "000"), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),),
                                                )
                                              ],
                                            ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(top: 70),
                                          child: Column(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.qr_description,
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.black
                                                        .withOpacity(0.5)),
                                              ),
                                              Image.asset(
                                                images.smartLunchIcon,
                                                height: 40,
                                                width: 90,
                                              ), // Image.asset
                                            ],
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            height: 95,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: mainProvider.userType == UserRole.teacher
                                  ? DecorationImage(
                                      fit: BoxFit.fitHeight,
                                      image: mainProvider.tutor!
                                              .profilePictureUrl.isNotEmpty
                                          ? NetworkImage(mainProvider
                                              .tutor!.profilePictureUrl)
                                          : const AssetImage(images
                                                  .defaultProfileStudentImage)
                                              as ImageProvider<Object>,
                                    )
                                  : DecorationImage(
                                      fit: BoxFit.fitHeight,
                                      image: mainProvider.selectedChild!
                                              .imageUrl.isNotEmpty
                                          ? NetworkImage(mainProvider
                                              .selectedChild!.imageUrl)
                                          : const AssetImage(images
                                                  .defaultProfileStudentImage)
                                              as ImageProvider<Object>,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
