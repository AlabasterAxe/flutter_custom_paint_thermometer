import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _ThermometerPainter extends CustomPainter {
  final double fullness;
  _ThermometerPainter(this.fullness);

  @override
  void paint(Canvas canvas, Size size) {
    double bulbRadius = size.width / 2;
    double stemHeight = size.height - bulbRadius;
    double stemWidth = bulbRadius;
    double inset = 10;
    Offset bulbCenter = Offset(size.width / 2, size.height - bulbRadius);

    Rect glassStem = Rect.fromCenter(
        center: Offset(size.width / 2, stemHeight / 2),
        width: stemWidth,
        height: stemHeight);

    Rect fullContents = glassStem.deflate(inset);
    Rect emptyContents = Rect.fromCenter(
        center: bulbCenter, height: 0, width: stemWidth - (inset * 2));

    Paint glassContainer = Paint()
      ..color = Color(0xffcfe2f3)
      ..style = PaintingStyle.fill;

    Paint thermometerContents = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawRect(glassStem, glassContainer);
    canvas.drawCircle(bulbCenter, bulbRadius, glassContainer);

    canvas.drawRect(
        Rect.lerp(emptyContents, fullContents, fullness), thermometerContents);
    canvas.drawCircle(bulbCenter, bulbRadius - inset, thermometerContents);
  }

  @override
  bool shouldRepaint(_ThermometerPainter oldDelegate) =>
      oldDelegate.fullness != fullness;
}

class Thermometer extends StatelessWidget {
  final double fullness;
  const Thermometer({Key key, this.fullness}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _ThermometerPainter(fullness));
  }
}
