import 'package:flutter/material.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height;
    double sw = size.width;
    double cornerSide = sh * 0.15;

    Paint paint = Paint()
      ..color = colors.orange
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    Path path = Path()
      ..moveTo(cornerSide, 0)
      ..lineTo(0, 0)
      ..lineTo(0, cornerSide);

    path.moveTo(sw - cornerSide, 0);
    path.lineTo(sw, 0);
    path.lineTo(sw, cornerSide);

    path.moveTo(sw, sh - cornerSide);
    path.lineTo(sw, sh);
    path.lineTo(sw - cornerSide, sh);


    path.moveTo(cornerSide, sh);
    path.lineTo(0, sh);
    path.lineTo(0, sh - cornerSide);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}
