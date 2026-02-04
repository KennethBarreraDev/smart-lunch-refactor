import 'package:flutter/material.dart';

class CouponPainter extends CustomPainter {
  final Color borderColor;
  final Color bgColor;

  CouponPainter({required this.bgColor, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final maxWidth = size.width;
    final maxHeight = size.height;
    const double cornerGap = 20;
    const double arcRadius = 9;
    const double arcStart = 90;
    const double arcEnd = 110;

    final paintBg = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..color = bgColor;

    final paintBorder = Paint()
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = borderColor;

    final paintDottedLine = Paint()
      ..color = borderColor.withOpacity(0.2)
      ..strokeWidth = 1.2;

    var path = Path();

    path.moveTo(cornerGap, 0);
    path.lineTo(arcStart, 0);
    //path.quadraticBezierTo(105, size.height*0.15, 115, 0);
    path.arcToPoint(
      const Offset(arcEnd, 0),
      radius: const Radius.circular(arcRadius), 
      clockwise: false, 
    );
    path.lineTo(maxWidth - cornerGap, 0);
    _drawCornerArc(path, maxWidth, cornerGap);
    path.lineTo(maxWidth, maxHeight - cornerGap);
    _drawCornerArc(path, maxWidth - cornerGap, maxHeight);

    path.lineTo(arcEnd, maxHeight);
    path.arcToPoint(
      Offset(arcStart, maxHeight),
      radius: const Radius.circular(arcRadius), 
      clockwise: false, 
    );
    path.lineTo(cornerGap, maxHeight);
    _drawCornerArc(path, 0, maxHeight - cornerGap);
    path.lineTo(0, cornerGap);
    _drawCornerArc(path, cornerGap, 0);

    canvas.drawPath(path, paintBg);
    canvas.drawPath(path, paintBorder);
    for (double y = 0; y <= maxHeight; y += 10 + 6) {
      if (y < maxHeight - arcRadius && y > arcRadius) {
        canvas.drawLine(Offset(100, y), Offset(100, y + 6), paintDottedLine);
      }
    }
  }

  _drawCornerArc(Path path, double endPointX, double endPointY) {
    path.arcToPoint(
      Offset(endPointX, endPointY),
      radius: const Radius.circular(20),
    );
  }

  @override
  bool shouldRepaint(CouponPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CouponPainter oldDelegate) => false;
}
