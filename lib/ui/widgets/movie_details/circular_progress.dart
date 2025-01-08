import 'dart:math';
import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final double percentage;
  final double circleSize;
  final double textSize;
  final double strokeWidth;

  const CircularProgress({
    super.key,
    required this.percentage,
    this.circleSize = 54,
    this.textSize = 14,
    this.strokeWidth = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: circleSize, // Размер круга
        height: circleSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Темный круг (фон)
            Container(
              width: circleSize,
              height: circleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            ),

            // Прогресс линия
            CustomPaint(
              size: Size(circleSize - 5, circleSize - 5),
              painter: _ProgressPainter(percentage, strokeWidth),
            ),

            // Текст в центре
            Text(
              '${percentage.toInt()}%',
              style: TextStyle(
                fontSize: textSize,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;

  _ProgressPainter(this.percentage, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    // Фон линии
    final Paint backgroundPaint = Paint()
      ..color = Colors.grey.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Прогресс линия
    final Paint progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.red, Colors.yellow],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Рисуем фон
    canvas.drawCircle(center, radius, backgroundPaint);

    // Угол прогресса
    final double sweepAngle = 2 * pi * (percentage / 100);

    // Рисуем прогресс
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Начало сверху
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Перерисовка на каждое обновление
  }
}
