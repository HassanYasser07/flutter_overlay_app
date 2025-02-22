import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window_example/widgets/control_button.dart';
import 'package:flutter_overlay_window_example/widgets/draggable_control_button.dart';
import 'dart:developer' as developer;
import 'ball_painter.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class BallGameApp extends StatefulWidget {
  const BallGameApp({
    Key? key,
  }) : super(key: key);

  @override
  _BallGameState createState() => _BallGameState();
}

class _BallGameState extends State<BallGameApp> {
  Offset whiteBallPosition = const Offset(100, 100);
  Offset redBallPosition = const Offset(100, 250);
  bool isWhiteBallActive = true;
  Offset? aimPoint;
  double ballRadius = 20.0;
  double tableWidth = 350;
  double tableHeight = 300;
  Offset? initialTouchPosition;
  double cueAngle = 0.3;
  double resizeThreshold = 50;
  double angleStep = 0.09;
  bool isResizing = false;
  bool showControls = false; // ✅ متغير للتحكم في إظهار الأزرار
  double reflectionAngleAdjustment = 0.0; // التحكم في زاوية الانعكاس
  bool isDraggingBall = false;
  bool isCueRotating = false;
  double initialCueAngle =
      0.0; // تحديد نقطة جديدة لوضع عنصر التحكم بناءً على امتداد العصا
  Offset? initialCueTouchPosition;

  bool isOverlayInteractive = true;

  Future<void> toggleOverlayInteraction() async {
    setState(() {
      isOverlayInteractive = !isOverlayInteractive;
    });

    // Toggle between interactive and non-interactive overlay
    await FlutterOverlayWindow.updateFlag(
      isOverlayInteractive ? OverlayFlag.defaultFlag : OverlayFlag.clickThrough,
    );
  }

  Future<void> disableOverlay() async {
    await FlutterOverlayWindow.updateFlag(OverlayFlag.clickThrough);
  }

  void updateBallPositionsAfterResize() {
    // Use the actual rendered height of the game area for the bottom boundary
    final double visibleHeight = MediaQuery.of(context).size.height * 0.79;
    setState(() {
      whiteBallPosition = Offset(
        whiteBallPosition.dx.clamp(ballRadius, tableWidth - ballRadius),
        whiteBallPosition.dy.clamp(ballRadius, visibleHeight - ballRadius),
      );
      redBallPosition = Offset(
        redBallPosition.dx.clamp(ballRadius, tableWidth - ballRadius),
        redBallPosition.dy.clamp(ballRadius, visibleHeight - ballRadius),
      );
    });
  }

  void updateOverlaySize(int newWidth, int newHeight) async {
    bool? success = await FlutterOverlayWindow.resizeOverlay(
      newWidth,
      newHeight,
      false, // تمكين السحب داخل النافذة
    );

    if (success == true) {
      setState(() {
        tableWidth = newWidth.toDouble();
        tableHeight = newHeight.toDouble();
      });
    }
  }

  void _toggleControls() {
    setState(() {
      showControls = !showControls; // ✅ تبديل الحالة عند الضغط
    });
  }

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

  Offset settingsButtonPosition = const Offset(10, 10);
  Offset chartButtonPosition = const Offset(60, 10);
  bool showgrid = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                DraggableControlButton(
                  icon: showControls ? Icons.visibility_off : Icons.settings,
                  onPressed: _toggleControls,
                  initialPosition: settingsButtonPosition,
                ),
                DraggableControlButton(
                  icon: Icons.show_chart,
                  onPressed: () {
                    setState(() {
                      showgrid = !showgrid;
                    });
                  },
                  initialPosition: chartButtonPosition,
                ),
              ],
            ),
            showgrid
                ? GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        if (initialTouchPosition != null) {
                          if (isCueRotating) {
                            Offset center = whiteBallPosition;
                            Offset newTouch = details.localPosition;

                            double newAngle = atan2(newTouch.dy - center.dy,
                                newTouch.dx - center.dx);
                            double oldAngle = atan2(
                                initialCueTouchPosition!.dy - center.dy,
                                initialCueTouchPosition!.dx - center.dx);

                            double angleDifference = newAngle - oldAngle;
                            cueAngle =
                                (initialCueAngle + angleDifference) % (2 * pi);
                          } else if (isResizing) {
                            // إذا كان المستخدم يقوم بتغيير الحجم فقط
                            double deltaX = details.localPosition.dx -
                                initialTouchPosition!.dx;
                            double deltaY = details.localPosition.dy -
                                initialTouchPosition!.dy;

                            tableWidth = (tableWidth + deltaX).clamp(150, 400);
                            tableHeight =
                                (tableHeight + deltaY).clamp(200, 800);
                            updateOverlaySize(
                                tableWidth.toInt(), tableHeight.toInt());
                            updateBallPositionsAfterResize();
                            initialTouchPosition = details.localPosition;
                          } else if (isDraggingBall) {
                            // ✅ فقط إذا كان المستخدم يسحب الكرة نفسها
                            if (isWhiteBallActive) {
                              // تحريك الكرة البيضاء فقط إذا كان السحب بدأ من عليها
                              final newWhitePosition =
                                  whiteBallPosition + details.delta;
                              whiteBallPosition = Offset(
                                newWhitePosition.dx
                                    .clamp(ballRadius, tableWidth - ballRadius),
                                newWhitePosition.dy.clamp(
                                    ballRadius, tableHeight - ballRadius),
                              );
                            } else {
                              // تحريك الكرة الحمراء فقط إذا كان السحب بدأ من عليها
                              final newRedPosition =
                                  redBallPosition + details.delta;
                              redBallPosition = Offset(
                                newRedPosition.dx
                                    .clamp(ballRadius, tableWidth - ballRadius),
                                newRedPosition.dy.clamp(
                                    ballRadius, tableHeight - ballRadius),
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
                        double distanceFromWhiteBall =
                            (details.localPosition - whiteBallPosition)
                                .distance;

                        // التحقق مما إذا كانت النقطة داخل حدود الكرة البيضاء
                        if ((dx - whiteBallPosition.dx).abs() < ballRadius &&
                            (dy - whiteBallPosition.dy).abs() < ballRadius) {
                          isWhiteBallActive = true;
                          isDraggingBall =
                              true; // ✅ السماح بالسحب فقط إذا كان المستخدم بدأ من الكرة
                        }
                        // التحقق مما إذا كانت النقطة داخل حدود الكرة الحمراء
                        else if ((dx - redBallPosition.dx).abs() < ballRadius &&
                            (dy - redBallPosition.dy).abs() < ballRadius) {
                          isWhiteBallActive = false;
                          isDraggingBall =
                              true; // ✅ السماح بالسحب فقط إذا كان المستخدم بدأ من الكرة
                        }
                        // التحقق مما إذا كانت نقطة اللمس داخل منطقة تغيير الحجم (أسفل اليمين)
                        else if (dx > tableWidth - resizeThreshold &&
                            dy > tableHeight - resizeThreshold) {
                          isResizing = true;
                        }
                        // التحقق مما إذا كانت نقطة اللمس داخل الزاوية العلوية اليسرى
                        else if (dx < resizeThreshold && dy < resizeThreshold) {
                          isResizing = true;
                        } else if (distanceFromWhiteBall > ballRadius &&
                            distanceFromWhiteBall <= ballRadius + 150) {
                          isCueRotating = true; // ✅ تفعيل تحريك العصا
                          isWhiteBallActive = false;
                          //  isRedBallActive = false;     //////////////////////////////////////////////////////////////////////
                          //  isResizingTable = false;
                          initialCueTouchPosition = details
                              .localPosition; // ✅ تخزين نقطة اللمس الأولية
                          initialCueAngle =
                              cueAngle; // ✅ تخزين الزاوية الأولية للعصا
                        } else {
                          isResizing = false;
                          isDraggingBall =
                              false; // ✅ السماح بالسحب فقط إذا كان المستخدم بدأ من الكرة
                        }
                      });
                    },
                    onPanEnd: (details) {
                      setState(() {
                        initialTouchPosition = null;
                        isResizing = false;
                        isDraggingBall =
                            false; // ✅ السماح بالسحب فقط إذا كان المستخدم بدأ من الكرة
                        isCueRotating = false;
                        initialCueTouchPosition = null;
                      });
                    },
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: Size(tableWidth, tableHeight),
                          painter: BallPainter(
                              whiteBallPosition: whiteBallPosition,
                              redBallPosition: redBallPosition,
                              aimPoint: aimPoint,
                              cueAngle: cueAngle,
                              reflectionAngleAdjustment:
                                  reflectionAngleAdjustment,
                              ballRadius: ballRadius),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: resizeThreshold,
                            height: resizeThreshold,
                            color: Colors.blue.withValues(alpha: 0.5),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: resizeThreshold,
                            height: resizeThreshold,
                            color: Colors.red.withValues(alpha: 0.5),
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
                                          ballRadius =
                                              (ballRadius + 5).clamp(10, 35);
                                        });
                                      },
                                    ),
                                    ControlButton(
                                      icon: Icons.remove_circle,
                                      label: 'Shrink',
                                      onPressed: () {
                                        setState(() {
                                          ballRadius =
                                              (ballRadius - 5).clamp(10, 35);
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
                                      label: 'Reflect +',
                                      onPressed: _adjustReflectionAngle,
                                    ),
                                    ControlButton(
                                      icon: Icons.arrow_downward,
                                      label: 'Reflect -',
                                      onPressed: _adjustReflectionAngleNegative,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
