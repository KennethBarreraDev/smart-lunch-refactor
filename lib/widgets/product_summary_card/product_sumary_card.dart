import 'package:flutter/material.dart';

class CustomCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var smallLineLength = size.width / 20;
    const smallLineHeight = 20;
    var path = Path();

    path.lineTo(0, size.height - smallLineHeight);

    for (int i = 1; i <= 20; i++) {
      if (i % 2 == 0) {
        path.lineTo(smallLineLength * i, size.height - smallLineHeight);
      } else {
        path.lineTo(smallLineLength * i, size.height);
      }
    }
    path.lineTo(size.width, 20); // Top right corner
    path.arcToPoint(Offset(size.width - smallLineHeight, 0),
        radius: const Radius.circular(20),
        clockwise: false,
    ); // Round top right corner

    path.lineTo(20, 0); // Top left corner
    path.arcToPoint(const Offset(0, 20),
        radius: const Radius.circular(20), clockwise: false); // Round top left corner
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
