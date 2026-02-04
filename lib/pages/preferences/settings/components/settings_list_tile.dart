import 'package:flutter/material.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    required this.title,
    required this.iconData,
    required this.iconColor,
    required this.trailing,
    this.onTap,
  });

  final String title;
  final IconData iconData;
  final Color iconColor;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xff413931),
          fontSize: 22.0,
            fontFamily: "Comfortaa"
        ),
      ),
      leading: Icon(
        iconData,
        color: iconColor,
        size: 35,
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
