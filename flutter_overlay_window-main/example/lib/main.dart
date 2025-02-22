import 'package:flutter/material.dart';
import 'package:flutter_overlay_window_example/home_page.dart';
import 'package:flutter_overlay_window_example/overlays/true_caller_overlay.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BallGameApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class BallGameApp extends StatelessWidget {
  const BallGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.5,
        child: const BallGame(),
      ),
    );
  }
}

class BallGame extends StatefulWidget {
  const BallGame({Key? key}) : super(key: key);

  @override
  _BallGameState createState() => _BallGameState();
}

class _BallGameState extends State<BallGame> {
  Offset whiteBallPosition = const Offset(200, 200);
  Offset redBallPosition = const Offset(300, 300);
  bool isWhiteBallActive = true;
  Offset? aimPoint;
  double tableWidth = 250;
  double tableHeight = 500;
  Offset? initialTouchPosition;

  double resizeThreshold = 50;

  @override
  void initState() {
    super.initState();

    whiteBallPosition = Offset(
      (tableWidth / 4).clamp(20, tableWidth - 20),
      (tableHeight / 4).clamp(20, tableHeight - 20),
    );

    redBallPosition = Offset(
      (tableWidth * 3 / 4).clamp(20, tableWidth - 20),
      (tableHeight * 3 / 4).clamp(20, tableHeight - 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  if (initialTouchPosition != null) {
                    if (initialTouchPosition!.dx >
                            tableWidth - resizeThreshold &&
                        initialTouchPosition!.dy >
                            tableHeight - resizeThreshold) {
                      double deltaX =
                          details.localPosition.dx - initialTouchPosition!.dx;
                      double deltaY =
                          details.localPosition.dy - initialTouchPosition!.dy;

                      tableWidth = (tableWidth + deltaX).clamp(250, 600);
                      tableHeight = (tableHeight + deltaY).clamp(500, 1000);

                      initialTouchPosition = details.localPosition;
                    } else if (initialTouchPosition!.dx < resizeThreshold &&
                        initialTouchPosition!.dy < resizeThreshold) {
                      double deltaX =
                          details.localPosition.dx - initialTouchPosition!.dx;
                      double deltaY =
                          details.localPosition.dy - initialTouchPosition!.dy;

                      tableWidth = (tableWidth - deltaX).clamp(250, 600);
                      tableHeight = (tableHeight - deltaY).clamp(500, 1000);

                      initialTouchPosition = details.localPosition;
                    } else {
                      if (isWhiteBallActive) {
                        final newWhitePosition =
                            whiteBallPosition + details.delta;
                        whiteBallPosition = Offset(
                          newWhitePosition.dx.clamp(20, tableWidth - 20),
                          newWhitePosition.dy.clamp(20, tableHeight - 20),
                        );
                      } else {
                        final newRedPosition = redBallPosition + details.delta;
                        redBallPosition = Offset(
                          newRedPosition.dx.clamp(20, tableWidth - 20),
                          newRedPosition.dy.clamp(20, tableHeight - 20),
                        );
                      }
                    }
                  }
                });
              },
              onPanStart: (details) {
                setState(() {
                  initialTouchPosition = details.localPosition;
                });
              },
              onPanEnd: (details) {
                setState(() {
                  initialTouchPosition = null;
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
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: resizeThreshold,
                      height: resizeThreshold,
                      color: Colors.blue.withOpacity(0.5),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: resizeThreshold,
                      height: resizeThreshold,
                      color: Colors.red.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isWhiteBallActive = true;
                    });
                  },
                  child: const Text('Move White Ball'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isWhiteBallActive = false;
                    });
                  },
                  child: const Text('Move Red Ball'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BallPainter extends CustomPainter {
  final Offset whiteBallPosition;
  final Offset redBallPosition;
  final Offset? aimPoint;

  BallPainter({
    required this.whiteBallPosition,
    required this.redBallPosition,
    this.aimPoint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // حفظ الطبقة الأصلية للرسم الشفاف
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    Paint gridPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke;

    for (double y = 0; y <= size.height; y += 50) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    for (double x = 0; x <= size.width; x += 50) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    Paint whiteBallPaint = Paint()..color = Colors.white;
    canvas.drawCircle(whiteBallPosition, 20, whiteBallPaint);

    Paint redBallPaint = Paint()..color = Colors.red;
    canvas.drawCircle(redBallPosition, 20, redBallPaint);

    // استعادة الطبقة الأصلية
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
