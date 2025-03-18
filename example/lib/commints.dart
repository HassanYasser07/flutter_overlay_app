
//ثلاثه جوانب بشكل صحيح
// if (tMin == tX) {
//   // اصطدام بالحواف الرأسية (يمين أو يسار)
//   double newAngle = pi - currentAngle;
//
//   // التأكد من أن التعديل يجعل الزاوية دائمًا منفرجة وليس حادة
//   if ((sin(currentAngle) > 0 && current.dx > size.width / 2) ||  // اصطدام باليمين
//       (sin(currentAngle) < 0 && current.dx < size.width / 2)) { // اصطدام باليسار
//     newAngle += reflectionAngleAdjustment;
//   } else {
//     newAngle -= reflectionAngleAdjustment;
//   }
//
//   currentAngle = newAngle;
// } else {
//   // اصطدام بالحواف الأفقية (أعلى أو أسفل)
//   double newAngle = -currentAngle;
//
//   // التأكد من أن التعديل يجعل الزاوية دائمًا منفرجة وليس حادة
//   if ((cos(currentAngle) > 0 && current.dy > size.height / 2) ||  // اصطدام بالأسفل
//       (cos(currentAngle) < 0 && current.dy < size.height / 2)) { // اصطدام بالأعلى
//     newAngle += reflectionAngleAdjustment;
//   } else {
//     newAngle -= reflectionAngleAdjustment;
//   }
//
//   currentAngle = newAngle;
// }



//الطرف الاسفل و الايمن يعملا بشكل جيد اما الاعلي و الايسر بايظين
// if (tMin == tX) {
//   // اصطدام بالحواف الرأسية (يمين أو يسار)
//   double newAngle = pi - currentAngle;
//
//   // ضبط زاوية الانعكاس بناءً على الاتجاه السابق للحركة
//   double adjustedAngle = newAngle + reflectionAngleAdjustment * (sin(currentAngle) >= 0 ? 1 : -1);
//
//   currentAngle = adjustedAngle;
// } else {
//   // اصطدام بالحواف الأفقية (أعلى أو أسفل)
//   double newAngle = -currentAngle;
//
//   // ضبط زاوية الانعكاس بناءً على الاتجاه السابق للحركة
//   double adjustedAngle = newAngle + reflectionAngleAdjustment * (cos(currentAngle) >= 0 ? 1 : -1);
//
//   currentAngle = adjustedAngle;
// }



// if (tMin == tX) {
//   // اصطدام بالحواف الرأسية (يمين أو يسار)
//   double newAngle = pi - currentAngle;
//
//   // ضبط زاوية الانعكاس بحيث لا تصبح حادة عند الجهة الأخرى
//   double adjustedAngle = newAngle + reflectionAngleAdjustment * (newAngle > 0 ? 1 : -1);
//
//   currentAngle = adjustedAngle;
// } else {
//   // اصطدام بالحواف الأفقية (أعلى أو أسفل)
//   double newAngle = -currentAngle;
//
//   // ضبط زاوية الانعكاس بنفس منطق الحواف الرأسية
//   double adjustedAngle = newAngle + reflectionAngleAdjustment * (newAngle > 0 ? 1 : -1);
//
//   currentAngle = adjustedAngle;
// }



//  if (tMin == tX) {
//
//    currentAngle = pi - currentAngle + reflectionAngleAdjustment;
//  } else {
//
//    currentAngle = -currentAngle + reflectionAngleAdjustment;
//  }
// // تحديث المسار وإجمالي الطول














// class BallPainter extends CustomPainter {
//   final Offset whiteBallPosition;
//   final Offset redBallPosition;
//   final Offset? aimPoint;
//   final double cueAngle;
//
//   BallPainter({
//     required this.whiteBallPosition,
//     required this.redBallPosition,
//     this.aimPoint,
//     required this.cueAngle,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     // رسم الشبكة
//     Paint gridPaint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.stroke;
//
//     for (double y = 0; y <= size.height; y += 50) {
//       canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
//     }
//     for (double x = 0; x <= size.width; x += 50) {
//       canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
//     }
//
//
//
//     // رسم الكرات بشكل مفرغ
//     Paint whiteBallPaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3;
//     canvas.drawCircle(whiteBallPosition, 20, whiteBallPaint);
//
//     Paint redBallPaint = Paint()
//       ..color = Colors.red
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3;
//     canvas.drawCircle(redBallPosition, 20, redBallPaint);
//
//
//     // // رسم الكرتين
//     // Paint whiteBallPaint = Paint()..color = Colors.white;
//     // canvas.drawCircle(whiteBallPosition, 20, whiteBallPaint);
//     //
//     // Paint redBallPaint = Paint()..color = Colors.red;
//     // canvas.drawCircle(redBallPosition, 20, redBallPaint);
//
//
//
//     // حساب مسار الكرة البيضاء
//     double totalLineLength = 250;
//     List<Offset> reflectionPath = _calculateReflectionPath(
//         whiteBallPosition, cueAngle, size, totalLineLength);
//
//     // رسم الخط المنقط
//     Paint dottedLinePaint = Paint()
//       ..color = Colors.yellow
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;
//
//     for (int i = 0; i < reflectionPath.length - 1; i++) {
//       _drawDottedLine(canvas, reflectionPath[i], reflectionPath[i + 1], dottedLinePaint);
//     }
//
//
//     for (int i = 0; i < reflectionPath.length - 1; i++) {
//       // تحقق مما إذا كان طرف الخط الأول أو الطرف الثاني يلامس الكرة الحمراء
//       if ((reflectionPath[i] - redBallPosition).distance <= 20 ||
//           (reflectionPath[i + 1] - redBallPosition).distance <= 20) {
//         // تم الكشف عن التصادم، لذا ابدأ رسم الخط الأخضر
//         Paint greenLinePaint = Paint()
//           ..color = Colors.green
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = 2;
//
//         // حساب زاوية الكرة الحمراء ومسار الانعكاس
//         double redBallAngle = _calculateRedBallAngle(whiteBallPosition, redBallPosition);
//         List<Offset> redReflectionPath = _calculateReflectionPath(
//             redBallPosition, redBallAngle, size, totalLineLength / 2);
//
//         // رسم مسار الانعكاس الأخضر (الخط المنقط)
//         for (int j = 0; j < redReflectionPath.length - 1; j++) {
//           _drawDottedLine(canvas, redReflectionPath[j], redReflectionPath[j + 1], greenLinePaint);
//         }
//
//         // اترك الحلقة بعد الكشف عن التصادم الأول
//         break;
//       }
//     }
//
//   }
//
//   List<Offset> _calculateReflectionPath(
//       Offset start, double angle, Size size, double maxLength) {
//     List<Offset> path = [start];
//     Offset current = start;
//     double currentAngle = angle;
//     double currentLength = 0.0;
//     int maxReflections = 3; // الحد الأقصى للانعكاسات
//
//     while (currentLength < maxLength && path.length <= maxReflections) {
//       double remainingLength = maxLength - currentLength;
//       double x = current.dx + remainingLength * cos(currentAngle);
//       double y = current.dy + remainingLength * sin(currentAngle);
//       Offset end = Offset(x, y);
//
//       if (end.dx < 0 || end.dx > size.width) {
//         double t = end.dx < 0
//             ? current.dx / (current.dx - end.dx)
//             : (size.width - current.dx) / (end.dx - current.dx);
//         end = Offset(
//           end.dx < 0 ? 0 : size.width,
//           current.dy + t * (end.dy - current.dy),
//         );
//         currentAngle = pi - currentAngle;
//       }
//
//       if (end.dy < 0 || end.dy > size.height) {
//         double t = end.dy < 0
//             ? current.dy / (current.dy - end.dy)
//             : (size.height - current.dy) / (end.dy - current.dy);
//         end = Offset(
//           current.dx + t * (end.dx - current.dx),
//           end.dy < 0 ? 0 : size.height,
//         );
//         currentAngle = -currentAngle;
//       }
//
//       double segmentLength = (end - current).distance;
//       if (currentLength + segmentLength > maxLength) {
//         double scale = (maxLength - currentLength) / segmentLength;
//         end = Offset(
//           current.dx + (end.dx - current.dx) * scale,
//           current.dy + (end.dy - current.dy) * scale,
//         );
//       }
//
//       path.add(end);
//       currentLength += segmentLength;
//       current = end;
//     }
//
//     return path;
//   }
//
//   bool _doesLineIntersectCircle(
//       Offset lineStart, Offset lineEnd, Offset circleCenter, double radius) {
//     double dx = lineEnd.dx - lineStart.dx;
//     double dy = lineEnd.dy - lineStart.dy;
//     double a = dx * dx + dy * dy;
//     double b = 2 * (dx * (lineStart.dx - circleCenter.dx) +
//         dy * (lineStart.dy - circleCenter.dy));
//     double c = (lineStart - circleCenter).distanceSquared - radius * radius;
//     double discriminant = b * b - 4 * a * c;
//
//     return discriminant >= 0;
//   }
//
//   double _calculateRedBallAngle(Offset whiteBall, Offset redBall) {
//     return atan2(redBall.dy - whiteBall.dy, redBall.dx - whiteBall.dx);
//   }
//
//   void _drawDottedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
//     double dashLength = 10;
//     double gapLength = 5;
//     double distance = (end - start).distance;
//     Offset direction = (end - start) / distance;
//
//     for (double i = 0; i < distance; i += dashLength + gapLength) {
//       final currentStart = start + direction * i;
//       final currentEnd = start + direction * (i + dashLength).clamp(0, distance);
//       canvas.drawLine(currentStart, currentEnd, paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }






import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

// class BallPainter extends CustomPainter {
//   final Offset whiteBallPosition;
//   final Offset redBallPosition;
//   final Offset? aimPoint;
//   final double cueAngle;
//
//   BallPainter({
//     required this.whiteBallPosition,
//     required this.redBallPosition,
//     this.aimPoint,
//     required this.cueAngle,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint gridPaint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.stroke;
//
//     for (double y = 0; y <= size.height; y += 50) {
//       canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
//     }
//     for (double x = 0; x <= size.width; x += 50) {
//       canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
//     }
//
//     Paint whiteBallPaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3;
//     canvas.drawCircle(whiteBallPosition, 20, whiteBallPaint);
//
//     Paint redBallPaint = Paint()
//       ..color = Colors.red
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3;
//     canvas.drawCircle(redBallPosition, 20, redBallPaint);
//
//     double totalLineLength = 250;
//     List<Offset> reflectionPath = _calculateReflectionPath(
//         whiteBallPosition, cueAngle, size, totalLineLength);
//
//     Paint dottedLinePaint = Paint()
//       ..color = Colors.yellow
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;
//
//     for (int i = 0; i < reflectionPath.length - 1; i++) {
//       _drawDottedLine(canvas, reflectionPath[i], reflectionPath[i + 1], dottedLinePaint);
//       if ((reflectionPath[i] - redBallPosition).distance <= 20 ||
//           (reflectionPath[i + 1] - redBallPosition).distance <= 20) {
//         double reflectedAngle = _calculateReflectedAngle(cueAngle, whiteBallPosition, redBallPosition);
//         List<Offset> reflectedPath = _calculateReflectionPath(
//             redBallPosition, reflectedAngle, size, totalLineLength / 2);
//         Paint reflectedPaint = Paint()
//           ..color = Colors.yellow
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = 2;
//         for (int j = 0; j < reflectedPath.length - 1; j++) {
//           _drawDottedLine(canvas, reflectedPath[j], reflectedPath[j + 1], reflectedPaint);
//         }
//
//         double whiteBallNewAngle = _calculateWhiteBallPostCollisionAngle(cueAngle, whiteBallPosition, redBallPosition);
//         List<Offset> whiteBallPath = _calculateReflectionPath(
//             redBallPosition, whiteBallNewAngle, size, totalLineLength / 2);
//         Paint whiteBallPaint = Paint()
//           ..color = Colors.cyan
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = 2;
//         for (int k = 0; k < whiteBallPath.length - 1; k++) {
//           _drawDottedLine(canvas, whiteBallPath[k], whiteBallPath[k + 1], whiteBallPaint);
//         }
//         break;
//       }
//     }
//   }
//
//   double _calculateReflectedAngle(double incomingAngle, Offset whiteBall, Offset redBall) {
//     double normalAngle = atan2(whiteBall.dy - redBall.dy, whiteBall.dx - redBall.dx);
//     return 2 * normalAngle - incomingAngle;
//   }
//
//   double _calculateWhiteBallPostCollisionAngle(double incomingAngle, Offset whiteBall, Offset redBall) {
//     double impactAngle = atan2(redBall.dy - whiteBall.dy, redBall.dx - whiteBall.dx);
//     double outgoingAngle = 2 * impactAngle - incomingAngle + pi / 2;
//     return outgoingAngle;
//   }
//
//   List<Offset> _calculateReflectionPath(
//       Offset start, double angle, Size size, double maxLength) {
//     List<Offset> path = [start];
//     Offset current = start;
//     double currentAngle = angle;
//     double currentLength = 0.0;
//     int maxReflections = 3;
//
//     while (currentLength < maxLength && path.length <= maxReflections) {
//       double remainingLength = maxLength - currentLength;
//       double x = current.dx + remainingLength * cos(currentAngle);
//       double y = current.dy + remainingLength * sin(currentAngle);
//       Offset end = Offset(x, y);
//
//       if (end.dx < 0 || end.dx > size.width) {
//         double t = end.dx < 0
//             ? current.dx / (current.dx - end.dx)
//             : (size.width - current.dx) / (end.dx - current.dx);
//         end = Offset(
//           end.dx < 0 ? 0 : size.width,
//           current.dy + t * (end.dy - current.dy),
//         );
//         currentAngle = pi - currentAngle;
//       }
//
//       if (end.dy < 0 || end.dy > size.height) {
//         double t = end.dy < 0
//             ? current.dy / (current.dy - end.dy)
//             : (size.height - current.dy) / (end.dy - current.dy);
//         end = Offset(
//           current.dx + t * (end.dx - current.dx),
//           end.dy < 0 ? 0 : size.height,
//         );
//         currentAngle = -currentAngle;
//       }
//
//       double segmentLength = (end - current).distance;
//       if (currentLength + segmentLength > maxLength) {
//         double scale = (maxLength - currentLength) / segmentLength;
//         end = Offset(
//           current.dx + (end.dx - current.dx) * scale,
//           current.dy + (end.dy - current.dy) * scale,
//         );
//       }
//
//       path.add(end);
//       currentLength += segmentLength;
//       current = end;
//     }
//     return path;
//   }
//
//   void _drawDottedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
//     double dashLength = 10;
//     double gapLength = 5;
//     double distance = (end - start).distance;
//     Offset direction = (end - start) / distance;
//
//     for (double i = 0; i < distance; i += dashLength + gapLength) {
//       final currentStart = start + direction * i;
//       final currentEnd = start + direction * (i + dashLength).clamp(0, distance);
//       canvas.drawLine(currentStart, currentEnd, paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }


// class BallPainter extends CustomPainter {
//   final Offset whiteBallPosition;
//   final Offset redBallPosition;
//   final Offset? aimPoint;
//   final double cueAngle;
//
//   BallPainter({
//     required this.whiteBallPosition,
//     required this.redBallPosition,
//     this.aimPoint,
//     required this.cueAngle,
//   });
//   void _drawDottedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
//     double dashLength = 10;
//     double gapLength = 5;
//     double distance = (end - start).distance;
//     Offset direction = (end - start) / distance;
//
//     for (double i = 0; i < distance; i += dashLength + gapLength) {
//       final currentStart = start + direction * i;
//       final currentEnd = start + direction * (i + dashLength).clamp(0, distance);
//       canvas.drawLine(currentStart, currentEnd, paint);
//     }
//   }
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint gridPaint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.stroke;
//
//     for (double y = 0; y <= size.height; y += 50) {
//       canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
//     }
//     for (double x = 0; x <= size.width; x += 50) {
//       canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
//     }
//
//     Paint whiteBallPaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3;
//     canvas.drawCircle(whiteBallPosition, 20, whiteBallPaint);
//
//     Paint redBallPaint = Paint()
//       ..color = Colors.red
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3;
//     canvas.drawCircle(redBallPosition, 20, redBallPaint);
//
//     double totalLineLength = 250;
//     List<Offset> reflectionPath = _calculateReflectionPath(
//         whiteBallPosition, cueAngle, size, totalLineLength);
//
//     Paint dottedLinePaint = Paint()
//       ..color = Colors.yellow
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;
//
//     Offset collisionPoint = redBallPosition;
//
//     for (int i = 0; i < reflectionPath.length - 1; i++) {
//       _drawDottedLine(canvas, reflectionPath[i], reflectionPath[i + 1], dottedLinePaint);
//       if ((reflectionPath[i] - redBallPosition).distance <= 20 ||
//           (reflectionPath[i + 1] - redBallPosition).distance <= 20) {
//         collisionPoint = reflectionPath[i + 1];
//         double reflectedAngle = _calculateReflectedAngle(cueAngle, whiteBallPosition, redBallPosition);
//         List<Offset> reflectedPath = _calculateReflectionPath(
//             redBallPosition, reflectedAngle, size, totalLineLength / 2);
//         Paint reflectedPaint = Paint()
//           ..color = Colors.yellow
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = 2;
//         for (int j = 0; j < reflectedPath.length - 1; j++) {
//           _drawDottedLine(canvas, reflectedPath[j], reflectedPath[j + 1], reflectedPaint);
//         }
//
//         double whiteBallNewAngle = _calculateWhiteBallPostCollisionAngle(cueAngle, whiteBallPosition, redBallPosition);
//         List<Offset> whiteBallPath = _calculateReflectionPath(
//             collisionPoint, whiteBallNewAngle, size, totalLineLength / 2);
//         Paint whiteBallPaint = Paint()
//           ..color = Colors.cyan
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = 2;
//         for (int k = 0; k < whiteBallPath.length - 1; k++) {
//           _drawDottedLine(canvas, whiteBallPath[k], whiteBallPath[k + 1], whiteBallPaint);
//         }
//         break;
//       }
//     }
//   }
//
//   double _calculateReflectedAngle(double incomingAngle, Offset whiteBall, Offset redBall) {
//     double normalAngle = atan2(whiteBall.dy - redBall.dy, whiteBall.dx - redBall.dx);
//     return 2 * normalAngle - incomingAngle;
//   }
//
//   double _calculateWhiteBallPostCollisionAngle(double incomingAngle, Offset whiteBall, Offset redBall) {
//     double impactAngle = atan2(redBall.dy - whiteBall.dy, redBall.dx - whiteBall.dx);
//     double outgoingAngle = 2 * impactAngle - incomingAngle;
//     return outgoingAngle;
//   }
//
//   List<Offset> _calculateReflectionPath(
//       Offset start, double angle, Size size, double maxLength) {
//     List<Offset> path = [start];
//     Offset current = start;
//     double currentAngle = angle;
//     double currentLength = 0.0;
//     int maxReflections = 3;
//
//     while (currentLength < maxLength && path.length <= maxReflections) {
//       double remainingLength = maxLength - currentLength;
//       double x = current.dx + remainingLength * cos(currentAngle);
//       double y = current.dy + remainingLength * sin(currentAngle);
//       Offset end = Offset(x, y);
//
//       if (end.dx < 0 || end.dx > size.width) {
//         double t = end.dx < 0
//             ? current.dx / (current.dx - end.dx)
//             : (size.width - current.dx) / (end.dx - current.dx);
//         end = Offset(
//           end.dx < 0 ? 0 : size.width,
//           current.dy + t * (end.dy - current.dy),
//         );
//         currentAngle = pi - currentAngle;
//       }
//
//       if (end.dy < 0 || end.dy > size.height) {
//         double t = end.dy < 0
//             ? current.dy / (current.dy - end.dy)
//             : (size.height - current.dy) / (end.dy - current.dy);
//         end = Offset(
//           current.dx + t * (end.dx - current.dx),
//           end.dy < 0 ? 0 : size.height,
//         );
//         currentAngle = -currentAngle;
//       }
//
//       double segmentLength = (end - current).distance;
//       if (currentLength + segmentLength > maxLength) {
//         double scale = (maxLength - currentLength) / segmentLength;
//         end = Offset(
//           current.dx + (end.dx - current.dx) * scale,
//           current.dy + (end.dy - current.dy) * scale,
//         );
//       }
//
//       path.add(end);
//       currentLength += segmentLength;
//       current = end;
//     }
//     return path;
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
