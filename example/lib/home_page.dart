import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.sports_soccer, color: Colors.white), // أيقونة بجانب العنوان
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
                        const SizedBox(height: 10.0),
                        TextButton.icon(
                          onPressed: () async {
                            if (await FlutterOverlayWindow.isActive()) return;
                         //  await launchOverlay("ball_game");

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
                          },
                          icon: const Icon(Icons.open_in_new,
                              color: Colors.white),
                          label: const Text(
                            "Show Overlay",
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
                          onPressed: () async {
                            if (await FlutterOverlayWindow.isActive()) return;
                         //   await launchOverlay("new_overlay");

                          },
                          icon: const Icon(Icons.open_in_new,
                              color: Colors.white),
                          label: const Text(
                            "Show Overlay",
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
}
