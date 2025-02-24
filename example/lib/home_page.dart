import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:dash_bubble/dash_bubble.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isClickThrough = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.sports_soccer,
                color: Colors.white), // أيقونة بجانب العنوان
            SizedBox(width: 10),
            Text(
              'Ball 8 App',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.teal, // لون خلفية حديث وجذاب
        elevation: 4, // رفع ظل
        shadowColor: Colors.tealAccent, // لون الظل
        centerTitle: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16), // زوايا مستديرة في الأسفل
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title Section
                const Text(
                  "Overlay Control",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 20.0),
                // Request Permission Button
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Column(
                      children: [
                        const Text(
                          "Permissions",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextButton.icon(
                          onPressed: () async {
                            final bool? res =
                                await FlutterOverlayWindow.requestPermission();
                            log("status: $res" as num);
                          },
                          icon: const Icon(Icons.security, color: Colors.white),
                          label: const Text(
                            "Request Permission",
                            style: TextStyle(fontSize: 16),
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Show Overlay Button
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Column(
                      children: [
                        const Text(
                          "Overlay Actions",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 40.0),
                        TextButton.icon(
                          onPressed: reqAccess,
                          icon: const Icon(Icons.open_in_new,
                              color: Colors.white),
                          label: const Text(
                            "Req Access",
                            style: TextStyle(fontSize: 16),
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            startBubble(
                              bubbleOptionas: bubbleOptions(),
                              onTap: ontap,
                            );
                          },
                          icon: const Icon(Icons.open_in_new,
                              color: Colors.white),
                          label: const Text(
                            "Show Bubble",
                            style: TextStyle(fontSize: 16),
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: stopBubble,
                          icon: const Icon(Icons.open_in_new,
                              color: Colors.white),
                          label: const Text(
                            "Stop Bubble",
                            style: TextStyle(fontSize: 16),
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> reqAccess() async {
    final isGranted = await DashBubble.instance.requestOverlayPermission();
    if (isGranted) {
      print('Granted');
    } else {
      print('Denied');
    }
  }

  Future<void> startBubble({
    required BubbleOptions bubbleOptionas,
    VoidCallback? onTap,
  }) async {
    bool hasStarted = false;
    hasStarted = await DashBubble.instance.startBubble(
      bubbleOptions: bubbleOptionas,
      onTap: onTap,
    );
    while (!hasStarted) {
      hasStarted = await DashBubble.instance.startBubble(
        bubbleOptions: bubbleOptionas,
        onTap: onTap,
      );
    }
    if (hasStarted) {
      print('Started');
    } else {
      print('Failed to start');
    }
  }

  Future<void> stopBubble() async {
    final hasStopped = await DashBubble.instance.stopBubble();
    if (hasStopped) {
      print('Stopped');
    } else {
      print('Failed to stop');
    }
  }

  void ontap() async {
    if (await FlutterOverlayWindow.isActive()) {
      DashBubble.instance.isRunning();
      await FlutterOverlayWindow.closeOverlay();
      if (isClickThrough) {
        await FlutterOverlayWindow.showOverlay(
          enableDrag: false,
          overlayTitle: "X-SLAYER",
          overlayContent: 'Overlay Enabled',
          flag: OverlayFlag.defaultFlag,
          visibility: NotificationVisibility.visibilityPublic,
          positionGravity: PositionGravity.auto,
          height: WindowSize.matchParent,
          width: WindowSize.matchParent,
          startPosition: const OverlayPosition(0, 0),
        );
      } else {
        await FlutterOverlayWindow.showOverlay(
          enableDrag: false,
          overlayTitle: "X-SLAYER",
          overlayContent: 'Overlay Enabled',
          flag: OverlayFlag.clickThrough,
          visibility: NotificationVisibility.visibilityPublic,
          positionGravity: PositionGravity.auto,
          height: WindowSize.matchParent,
          width: WindowSize.matchParent,
          startPosition: const OverlayPosition(0, 0),
        );
      }
      await stopBubble();
      await startBubble(
        bubbleOptionas: bubbleOptions(),
        onTap: ontap,
      );
      isClickThrough = !isClickThrough;
    } else {
      await FlutterOverlayWindow.showOverlay(
        enableDrag: false,
        overlayTitle: "X-SLAYER",
        overlayContent: 'Overlay Enabled',
        flag: OverlayFlag.defaultFlag,
        visibility: NotificationVisibility.visibilityPublic,
        positionGravity: PositionGravity.auto,
        height: WindowSize.matchParent,
        width: WindowSize.matchParent,
        startPosition: const OverlayPosition(0, 0),
      );
      await stopBubble();
      await startBubble(
        bubbleOptionas: bubbleOptions(),
        onTap: ontap,
      );
    }
  }

  BubbleOptions bubbleOptions() {
    return BubbleOptions(
      bubbleIcon: 'test',
      bubbleSize: 50,
      distanceToClose: 90,
      enableClose: false,
      enableAnimateToEdge: true,
      enableBottomShadow: true,
      keepAliveWhenAppExit: false,
    );
  }
}
