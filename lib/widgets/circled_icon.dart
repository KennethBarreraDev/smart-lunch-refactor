import 'package:flutter/material.dart';

class CircledIcon extends StatelessWidget {
  const CircledIcon({
    super.key,
    required this.color,
    required this.iconData,
    this.width = 56,
    this.height = 57,
    this.padding = 12,
  });

  final Color color;
  final IconData iconData;
  final double width;
  final double height;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(28),
        ),
        color: color.withOpacity(0.15),
      ),
      child: FittedBox(
        child: Icon(
          iconData,
          color: color,
        ),
      ),
    );
  }
}
