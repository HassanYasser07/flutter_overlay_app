import 'package:flutter/material.dart';
import 'dart:math';

class BallPainter extends CustomPainter {
  final Offset whiteBallPosition;
  final int maxReflections;
  final Offset redBallPosition;
  final Offset? aimPoint;
  final double cueAngle;
  double reflectionAngleAdjustment;
  final double ballRadius;
  final double lineLength;
  BallPainter(
      {required this.whiteBallPosition,
      required this.redBallPosition,
      this.aimPoint,
      required this.cueAngle,
      this.reflectionAngleAdjustment = 0.0,
      required this.ballRadius,
      required this.lineLength,required this.maxReflections});

  Offset _closestPointOnSegment(Offset p, Offset a, Offset b) {
    double ax = a.dx, ay = a.dy, bx = b.dx, by = b.dy;
    double px = p.dx, py = p.dy;
    double abx = bx - ax, aby = by - ay;
    double apx = px - ax, apy = py - ay;
    double abLenSq = abx * abx + aby * aby;
    double apDotAb = apx * abx + apy * aby;
    double t = apDotAb / abLenSq;
    t = t.clamp(0.0, 1.0);
    return Offset(ax + abx * t, ay + aby * t);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint gridPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    for (double y = 0; y <= size.height; y += 50) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    for (double x = 0; x <= size.width; x += 50) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    Paint whiteBallPaint = Paint()
      ..color = Colors.yellowAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(whiteBallPosition, ballRadius, whiteBallPaint);
    Paint redBallPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(redBallPosition, ballRadius, redBallPaint);
    double totalLineLength = lineLength;
    List<Offset> reflectionPath = _calculateReflectionPath(
        whiteBallPosition, cueAngle, size, totalLineLength);
    //  whiteBallPosition, cueAngle + reflectionAngleAdjustment, size, totalLineLength);

    Paint dottedLinePaint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (int i = 0; i < reflectionPath.length - 1; i++) {
      Offset start = reflectionPath[i];
      Offset end = reflectionPath[i + 1];

// **حساب أقرب نقطة تصادم مع الكرة الحمراء**
      Offset closestPoint = _closestPointOnSegment(redBallPosition, start, end);

      if ((closestPoint - redBallPosition).distance <= 20) {
        end = closestPoint; // **توقف الخط عند نقطة الاصطدام تمامًا**
        _drawDottedLine(canvas, start, end, dottedLinePaint);


        // حساب الزاوية الجديدة للكرة البيضاء بعد التصادم
        double newWhiteBallAngle = _calculateWhiteBallPostCollisionAngle(
            cueAngle, whiteBallPosition, redBallPosition);

// رسم مسار الكرة البيضاء بعد التصادم
        List<Offset> whiteBallPath = _calculateReflectionPath(
            end, newWhiteBallAngle, size, totalLineLength / 2);

        Paint whiteBallPathPaint = Paint()
          ..color = Colors.green
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

        for (int k = 0; k < whiteBallPath.length - 1; k++) {
          _drawDottedLine(canvas, whiteBallPath[k], whiteBallPath[k + 1],
              whiteBallPathPaint);
        }

// حساب الزاوية الجديدة للكرة الحمراء بعد التصادم
        double newRedBallAngle = _calculateReflectedAngle(
            cueAngle, whiteBallPosition, redBallPosition);

// رسم مسار الكرة الحمراء بعد التصادم
        List<Offset> redBallPath = _calculateReflectionPath(
            redBallPosition, newRedBallAngle, size, totalLineLength / 2);

        Paint redBallPathPaint = Paint()
          ..color = Colors.yellow
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

        for (int j = 0; j < redBallPath.length - 1; j++) {
          _drawDottedLine(canvas, redBallPath[j], redBallPath[j + 1], redBallPathPaint);
        }

        break; // **توقف عن رسم باقي الخط بعد التصادم**
      }
      _drawDottedLine(canvas, start, end, dottedLinePaint);
    }
  }

  double _calculateReflectedAngle(
      double incomingAngle, Offset whiteBall, Offset redBall) {
    double impactAngle =
        atan2(whiteBall.dy - redBall.dy, whiteBall.dx - redBall.dx);
    // Calculate the normal vector at the point of impact
    double normalAngle = impactAngle;
    // Calculate the reflection angle based on the normal
    double reflectedAngle = 2 * normalAngle - incomingAngle;
    
    // Apply adjustment based on the quadrant of impact
    double adjustmentSign = sin(normalAngle - incomingAngle) > 0 ? 1 : -1;
    return reflectedAngle + (reflectionAngleAdjustment * adjustmentSign);
  }

  double _calculateWhiteBallPostCollisionAngle(
      double incomingAngle, Offset whiteBall, Offset redBall) {
    double impactAngle =
        atan2(redBall.dy - whiteBall.dy, redBall.dx - whiteBall.dx);
    // Calculate the normal vector at the point of impact
    double normalAngle = impactAngle;
    // Calculate the outgoing angle based on the normal
    double outgoingAngle = 2 * normalAngle - incomingAngle + pi;
    
    // Apply adjustment based on the quadrant of impact
    double adjustmentSign = sin(normalAngle - incomingAngle) > 0 ? -1 : 1;
    return outgoingAngle + (reflectionAngleAdjustment * adjustmentSign);
  }

  List<Offset> _calculateReflectionPath(
      Offset start, double angle, Size size, double maxLength) {
    List<Offset> path = [start];
    Offset current = start;
    double currentAngle = angle;
    double currentLength = 0.0;
    int maxReflections = this.maxReflections;
    while (currentLength < maxLength && path.length <= maxReflections) {
      double remainingLength = maxLength - currentLength;
      double x = current.dx + remainingLength * cos(currentAngle);
      double y = current.dy + remainingLength * sin(currentAngle);
      Offset end = Offset(x, y);
      double tX = 1.0, tY = 1.0;

      if (end.dx < 0 || end.dx > size.width) {
        tX = end.dx < 0
            ? (0 - current.dx) / (end.dx - current.dx)
            : (size.width - current.dx) / (end.dx - current.dx);
      }

      if (end.dy < 0 || end.dy > size.height) {
        tY = end.dy < 0
            ? (0 - current.dy) / (end.dy - current.dy)
            : (size.height - current.dy) / (end.dy - current.dy);
      }
      double tMin = min(tX, tY);
      end = Offset(
        current.dx + (end.dx - current.dx) * tMin,
        current.dy + (end.dy - current.dy) * tMin,
      );

      if (tMin == tX) {
        // اصطدام بالحواف الرأسية (يمين أو يسار)
        double newAngle = pi - currentAngle;
        bool isRightCollision = end.dx >= size.width - 1;
        
        if (isRightCollision) {
          newAngle += reflectionAngleAdjustment * (sin(currentAngle) > 0 ? 1 : -1);
        } else {
          newAngle += reflectionAngleAdjustment * (sin(currentAngle) < 0 ? 1 : -1);
        }
        
        currentAngle = (newAngle + 2 * pi) % (2 * pi);
      } else {
        // اصطدام بالحواف الأفقية (أعلى أو أسفل)
        double newAngle =  - currentAngle;
        bool isBottomCollision = end.dy >= size.height - 1;
        
        if (isBottomCollision) {
          newAngle += reflectionAngleAdjustment * (cos(currentAngle) > 0 ? -1 : 1);
        } else {
          newAngle += reflectionAngleAdjustment * (cos(currentAngle) < 0 ? -1 : 1);
        }
        
        currentAngle = (newAngle + 2 * pi) % (2 * pi);
      }

      double segmentLength = (end - current).distance;
      if (currentLength + segmentLength > maxLength) {
        double scale = (maxLength - currentLength) / segmentLength;
        end = Offset(
          current.dx + (end.dx - current.dx) * scale,
          current.dy + (end.dy - current.dy) * scale,
        );
      }
      path.add(end);
      currentLength += segmentLength;
      current = end;
    }
    return path;
  }

  void _drawDottedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    double dashLength = 10;
    double gapLength = 5;
    double distance = (end - start).distance;
    Offset direction = (end - start) / distance;

    for (double i = 0; i < distance; i += dashLength + gapLength) {
      final currentStart = start + direction * i;
      final currentEnd =
          start + direction * (i + dashLength).clamp(0, distance);

// **تأكد أن الخط لا يتجاوز end حتى لو كانت خطوة كبيرة**
      if ((currentEnd - start).distance > distance) break;

      canvas.drawLine(currentStart, currentEnd, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
