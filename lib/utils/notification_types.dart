import 'package:flutter/material.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;

enum NotificationTypes {
  generalMessage(colors.lightGreen, Icons.people),
  privateMessage(colors.lightRed, Icons.message),
  groupMessage(colors.coral, Icons.school);

  const NotificationTypes(this.color, this.iconData);
  final Color color;
  final IconData iconData;
}
