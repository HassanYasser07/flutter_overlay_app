import 'dart:math';

import 'package:flutter/material.dart';

import '../ball_painter.dart';
import 'control_button.dart';

class Overlay8Ball extends StatefulWidget {
  const Overlay8Ball({Key? key, required this.tableWidth, required this.tableHeight}) : super(key: key);
  final double tableWidth;
  final double tableHeight;
  @override
  State<Overlay8Ball> createState() => _Overlay8BallState();
}

class _Overlay8BallState extends State<Overlay8Ball> {
  double lineLength = 250;
  int maxReflections = 2;
  Offset whiteBallPosition = const Offset(100, 100);
  Offset redBallPosition = const Offset(100, 250);
  bool isWhiteBallActive = true;
  Offset? aimPoint;
  double ballRadius = 20.0;

  Offset? initialTouchPosition;
  double cueAngle = 0.3;
  double resizeThreshold = 50;
  double angleStep = 0.09;
  bool showControls = false;
  double reflectionAngleAdjustment = 0.0;
  bool isDraggingBall = false;
  bool isCueRotating = false;
  double initialCueAngle = 0.0;
  Offset? initialCueTouchPosition;
  late Offset originalWhiteBallPosition;
  late Offset originalRedBallPosition;
  void _increaseAngle() {
    setState(() {
      cueAngle += angleStep;
    });
  }

  void _decreaseAngle() {
    setState(() {
      cueAngle = (cueAngle - angleStep) % (2 * pi);
    });
  }

  void _adjustReflectionAngle() {
    setState(() {
      reflectionAngleAdjustment += 0.1; // تعديل زاوية الانعكاس
    });
  }

  void _adjustReflectionAngleNegative() {
    setState(() {
      reflectionAngleAdjustment -=
      0.1; // تعديل زاوية الانعكاس في الاتجاه المعاكس
    });
  }

  void _increaseLineLength() {
    setState(() {
      lineLength += 20;
    });
  }

  void _decreaseLineLength() {
    setState(() {
      lineLength -= 20;
    });
  }

  void _increaseMaxReflections() {
    setState(() {
      maxReflections += 1;
    });
  }

  void _decreaseMaxReflections() {
    setState(() {
      maxReflections -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          if (initialTouchPosition != null) {
            if (isCueRotating) {
              Offset center = whiteBallPosition;
              Offset newTouch = details.localPosition;
              double newAngle =
              atan2(newTouch.dy - center.dy, newTouch.dx - center.dx);
              double oldAngle = atan2(
                initialCueTouchPosition!.dy - center.dy,
                initialCueTouchPosition!.dx - center.dx,
              );
              double angleDifference = newAngle - oldAngle;
              cueAngle = (initialCueAngle + angleDifference) % (2 * pi);
            } else if (isDraggingBall) {
              if (isWhiteBallActive) {
                Offset newWhitePosition = whiteBallPosition + details.delta;
                whiteBallPosition = Offset(
                  newWhitePosition.dx
                      .clamp(ballRadius, widget.tableWidth - ballRadius),
                  newWhitePosition.dy
                      .clamp(ballRadius, widget.tableHeight - ballRadius),
                );
              } else {
                Offset newRedPosition = redBallPosition + details.delta;
                redBallPosition = Offset(
                  newRedPosition.dx.clamp(ballRadius, widget.tableWidth - ballRadius),
                  newRedPosition.dy.clamp(ballRadius, widget.tableHeight - ballRadius),
                );
              }
            }
          }
        });
      },
      onPanStart: (details) {
        setState(() {
          initialTouchPosition = details.localPosition;
          double dx = details.localPosition.dx;
          double dy = details.localPosition.dy;
          originalWhiteBallPosition = whiteBallPosition;
          originalRedBallPosition = redBallPosition;
          // Keep existing ball dragging and cue rotation logic
          if ((dx - whiteBallPosition.dx).abs() < ballRadius &&
              (dy - whiteBallPosition.dy).abs() < ballRadius) {
            isWhiteBallActive = true;
            isDraggingBall = true;
          } else if ((dx - redBallPosition.dx).abs() < ballRadius &&
              (dy - redBallPosition.dy).abs() < ballRadius) {
            isWhiteBallActive = false;
            isDraggingBall = true;
          } else {
            double distanceFromWhiteBall =
                (details.localPosition - whiteBallPosition).distance;
            if (distanceFromWhiteBall > ballRadius &&
                distanceFromWhiteBall <= ballRadius + 150) {
              isCueRotating = true;
              initialCueTouchPosition = details.localPosition;
              initialCueAngle = cueAngle;
            }
          }
        });
      },
      onPanEnd: (details) {
        setState(() {
          initialTouchPosition = null;
          isDraggingBall = false;
          isCueRotating = false;
          initialCueTouchPosition = null;
        });
      },
      child: Stack(
        children: [
          CustomPaint(
            size: Size(widget.tableWidth, widget.tableHeight),
            painter: BallPainter(
              whiteBallPosition: whiteBallPosition,
              redBallPosition: redBallPosition,
              aimPoint: aimPoint,
              cueAngle: cueAngle,
              reflectionAngleAdjustment: reflectionAngleAdjustment,
              ballRadius: ballRadius,
              lineLength: lineLength,
              maxReflections: maxReflections,
            ),
          ),
          Visibility(
            visible: showControls,
            child: Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    alignment: WrapAlignment.center,
                    children: [
                      ControlButton(
                        icon: Icons.add_circle,
                        label: 'Enlarge',
                        onPressed: () {
                          setState(() {
                            ballRadius = (ballRadius + 5).clamp(10, 35);
                          });
                        },
                      ),
                      ControlButton(
                        icon: Icons.remove_circle,
                        label: 'Shrink',
                        onPressed: () {
                          setState(() {
                            ballRadius = (ballRadius - 5).clamp(10, 35);
                          });
                        },
                      ),
                      ControlButton(
                        icon: Icons.rotate_right,
                        label: 'Increase Angle',
                        onPressed: _increaseAngle,
                      ),
                      ControlButton(
                        icon: Icons.rotate_left,
                        label: 'Decrease Angle',
                        onPressed: _decreaseAngle,
                      ),
                      ControlButton(
                        icon: Icons.arrow_upward,
                        label: 'Reflect',
                        onPressed: _adjustReflectionAngle,
                      ),
                      ControlButton(
                        icon: Icons.arrow_downward,
                        label: 'Reflect',
                        onPressed: _adjustReflectionAngleNegative,
                      ),
                      ControlButton(
                        icon: Icons.arrow_upward,
                        label: 'Increase line length',
                        onPressed: _increaseLineLength,
                      ),
                      ControlButton(
                        icon: Icons.arrow_downward,
                        label: 'Decrease line length',
                        onPressed: _decreaseLineLength,
                      ),
                      ControlButton(
                        icon: Icons.arrow_upward,
                        label: 'Increase max reflections',
                        onPressed: _increaseMaxReflections,
                      ),
                      ControlButton(
                        icon: Icons.arrow_downward,
                        label: 'Decrease max reflections',
                        onPressed: _decreaseMaxReflections,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
