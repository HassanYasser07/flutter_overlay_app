import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_overlay_window_example/home_page.dart';
import 'ball_game.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),

    );
  }
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








// //كود شغال بس مش بيحدث
// import 'dart:developer' as developer;
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_overlay_window/flutter_overlay_window.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'ball_game.dart';
// import 'home_page.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
//
// // ✅ هذه الدالة تُستخدم لتشغيل الـ Overlay مع تحديد الشاشة المناسبة
// Future<void> launchOverlay(String overlayType) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('overlay_type', overlayType); // حفظ نوع الـ Overlay
//
//
//   await FlutterOverlayWindow.showOverlay(
//     enableDrag: false,
//     overlayTitle: "Overlay Running",
//     overlayContent: 'Overlay Enabled',
//     flag: OverlayFlag.defaultFlag,
//     visibility: NotificationVisibility.visibilityPublic,
//     positionGravity: PositionGravity.auto,
//     height: WindowSize.matchParent,
//     width: WindowSize.matchParent,
//   );
// }
//
//
// // ✅ تحديث `overlayMain` لدعم أكثر من شاشة بناءً على البيانات المخزنة مسبقًا
// @pragma("vm:entry-point")
// void overlayMain() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//
//   // تحميل نوع الـ Overlay المخزن مسبقًا
//   final prefs = await SharedPreferences.getInstance();
//   String overlayType = prefs.getString('overlay_type') ?? "ball_game";
//   // تحميل الشاشة بناءً على القيمة المخزنة مسبقًا
//   _loadInitialOverlayScreen();
// }
//
// Future<void> _loadInitialOverlayScreen() async {
//   final prefs = await SharedPreferences.getInstance();
//   final String? overlayType = prefs.getString('overlay_type');
//   _launchOverlayScreen(overlayType ?? "ball_game"); // تشغيل الشاشة الافتراضية إذا لم يتم العثور على بيانات
// }
//
// void _launchOverlayScreen(String overlayType) {
//   Widget screen;
//   if (overlayType == "ball_game") {
//     screen = const BallGameApp();
//   } else if (overlayType == "new_overlay") {
//     screen = const Button();
//   } else {
//     screen = const Center(child: Text("Unknown Overlay"));
//   }
//
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: screen,
//     ),
//   );
// }
//
//
//
//
//
// // ✅ شاشة جديدة لاختبار إضافة Overlay ثاني
// class Button extends StatelessWidget {
//
//
//   const Button({
//     Key? key,
//
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         children: [
//           SizedBox(height: 100,),
//           IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: () {
//               developer.log('Try to close');
//               FlutterOverlayWindow.closeOverlay().then(
//                     (value) => developer.log('STOPPED: value: $value'),
//               );
//             },
//           ),
//           ElevatedButton(
//             onPressed: (){},
//             child: Text('label'),
//           ),
//         ],
//       ),
//     );
//   }
// }








//
//
// import 'dart:developer' as developer;
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_overlay_window/flutter_overlay_window.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'ball_game.dart';
// import 'home_page.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
//
// // ✅ هذه الدالة تُستخدم لتشغيل الـ Overlay مع تحديد الشاشة المناسبة
// Future<void> launchOverlay(String overlayType) async {
//   // First check if there's an active overlay and close it
//   if (await FlutterOverlayWindow.isActive()) {
//     await FlutterOverlayWindow.closeOverlay();
//     // Wait a bit to ensure the overlay is fully closed
//     await Future.delayed(const Duration(milliseconds: 500));
//   }
//
//   // Save the new overlay type
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('overlay_type', overlayType);
//
//   // Launch the new overlay
//   await FlutterOverlayWindow.showOverlay(
//     enableDrag: false,
//     overlayTitle: "Overlay Running",
//     overlayContent: 'Overlay Enabled',
//     flag: OverlayFlag.defaultFlag,
//     visibility: NotificationVisibility.visibilityPublic,
//     positionGravity: PositionGravity.auto,
//     height: WindowSize.matchParent,
//     width: WindowSize.matchParent,
//   );
// }
// // Future<void> launchOverlay(String overlayType) async {
// //   final prefs = await SharedPreferences.getInstance();
// //   await prefs.setString('overlay_type', overlayType);
// //
// //   // ✅ إذا كان الـ Overlay غير مفتوح، قم بفتحه
// //   if (!await FlutterOverlayWindow.isActive()) {
// //
// //     await FlutterOverlayWindow.showOverlay(
// //       enableDrag: false,
// //       overlayTitle: "Overlay Running",
// //       overlayContent: 'Overlay Enabled',
// //       flag: OverlayFlag.defaultFlag,
// //       visibility: NotificationVisibility.visibilityPublic,
// //       positionGravity: PositionGravity.auto,
// //       height: WindowSize.matchParent,
// //       width: WindowSize.matchParent,
// //     );
// //
// //     // ⏳ تأخير لضمان بدء التشغيل قبل إرسال التحديث
// //     await Future.delayed(const Duration(seconds: 1));
// //   }
// //
// //   // ✅ إرسال التحديث إلى الـ Overlay
// //   const MethodChannel channel = MethodChannel('overlay_channel');
// //   try {
// //     await channel.invokeMethod("setOverlayType", overlayType);
// //   } catch (e) {
// //     print("Error setting overlay type: $e");
// //   }
// // }
//
//
//
//
// // ✅ تحديث `overlayMain` لدعم أكثر من شاشة بناءً على البيانات المخزنة مسبقًا
// @pragma("vm:entry-point")
// void overlayMain() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await _loadInitialOverlayScreen();
// }
//
// Future<void> _loadInitialOverlayScreen() async {
//   final prefs = await SharedPreferences.getInstance();
//   final String? overlayType = prefs.getString('overlay_type') ?? "ball_game";
//   _launchOverlayScreen(overlayType!);
// }
// // Future<void> _loadInitialOverlayScreen() async {
// //   final prefs = await SharedPreferences.getInstance();
// //   final String? overlayType = prefs.getString('overlay_type');
// //   _launchOverlayScreen(overlayType ?? "ball_game"); // تشغيل الشاشة الافتراضية إذا لم يتم العثور على بيانات
// // }
//
// void _launchOverlayScreen(String overlayType) {
//   Widget screen;
//   if (overlayType == "ball_game") {
//     screen = const BallGameApp();
//   } else if (overlayType == "new_overlay") {
//     screen = const Button();
//   } else {
//     screen = const Center(child: Text("Unknown Overlay"));
//   }
//
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: screen,
//     ),
//   );
// }
//
// // ✅ شاشة جديدة لاختبار إضافة Overlay ثاني
// class Button extends StatelessWidget {
//
//
//   const Button({
//     Key? key,
//
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         children: [
//           SizedBox(height: 100,),
//           IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: () {
//               developer.log('Try to close');
//               FlutterOverlayWindow.closeOverlay().then(
//                     (value) => developer.log('STOPPED: value: $value'),
//               );
//             },
//           ),
//           ElevatedButton(
//             onPressed: (){},
//             child: Text('label'),
//           ),
//         ],
//       ),
//     );
//   }
// }








//كود بيستخدم method channel لتحديد الشاشة المناسبة
//
// import 'dart:developer' as developer;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_overlay_window/flutter_overlay_window.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'ball_game.dart';
// import 'home_page.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
//
// // ✅ هذه الدالة تُستخدم لتشغيل الـ Overlay مع تحديد الشاشة المناسبة
// Future<void> launchOverlay(String overlayType) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('overlay_type', overlayType); // حفظ نوع الـ Overlay
//
//
//   // 🔹 التحقق مما إذا كان هناك Overlay نشط وإغلاقه قبل تشغيل الجديد
//   if (await FlutterOverlayWindow.isActive()) {
//     await FlutterOverlayWindow.closeOverlay();
//     await Future.delayed(const Duration(milliseconds: 500)); // انتظار الإغلاق
//   }
//   await FlutterOverlayWindow.showOverlay(
//     enableDrag: false,
//     overlayTitle: "Overlay Running",
//     overlayContent: 'Overlay Enabled',
//     flag: OverlayFlag.defaultFlag,
//     visibility: NotificationVisibility.visibilityPublic,
//     positionGravity: PositionGravity.auto,
//     height: WindowSize.matchParent,
//     width: WindowSize.matchParent,
//   );
//
//   // تأخير بسيط لضمان بدء تشغيل الـ Overlay قبل إرسال النوع الجديد
//   await Future.delayed(const Duration(milliseconds: 500));
//
//   // إرسال النوع الجديد إلى الـ Overlay عبر MethodChannel
//   const MethodChannel channel = MethodChannel('overlay_channel');
//   try {
//     await channel.invokeMethod("setOverlayType", overlayType);
//   } catch (e) {
//     print("Error setting overlay type: $e");
//   }
// }
//
//
// // ✅ تحديث `overlayMain` لدعم أكثر من شاشة بناءً على البيانات المخزنة مسبقًا
// @pragma("vm:entry-point")
// void overlayMain() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   String overlayType = prefs.getString('overlay_type') ?? "ball_game";
//
//   runApp(OverlayApp(initialOverlayType: overlayType));
// }
//
// class OverlayApp extends StatefulWidget {
//   final String initialOverlayType;
//
//   const OverlayApp({Key? key, required this.initialOverlayType}) : super(key: key);
//
//   @override
//   State<OverlayApp> createState() => _OverlayAppState();
// }
//
// class _OverlayAppState extends State<OverlayApp> {
//   late String overlayType;
//   static const MethodChannel channel = MethodChannel('overlay_channel');
//
//   @override
//   void initState() {
//     super.initState();
//     overlayType = widget.initialOverlayType;
//
//     // الاستماع لأي تحديثات قادمة من التطبيق الرئيسي
//     channel.setMethodCallHandler((call) async {
//       if (call.method == "setOverlayType") {
//         setState(() {
//           overlayType = call.arguments;
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: _getOverlayScreen(overlayType),
//     );
//   }
//
//   Widget _getOverlayScreen(String overlayType) {
//     if (overlayType == "ball_game") {
//       return const BallGameApp();
//     } else if (overlayType == "new_overlay") {
//       return const Button();
//     } else {
//       return const Center(child: Text("Unknown Overlay"));
//     }
//   }
// }
//
//
// Future<void> _loadInitialOverlayScreen() async {
//   final prefs = await SharedPreferences.getInstance();
//   final String? overlayType = prefs.getString('overlay_type');
//   _launchOverlayScreen(overlayType ?? "ball_game"); // تشغيل الشاشة الافتراضية إذا لم يتم العثور على بيانات
// }
//
// void _launchOverlayScreen(String overlayType) {
//   Widget screen;
//   if (overlayType == "ball_game") {
//     screen = const BallGameApp();
//   } else if (overlayType == "new_overlay") {
//     screen = const Button();
//   } else {
//     screen = const Center(child: Text("Unknown Overlay"));
//   }
//
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: screen,
//     ),
//   );
// }
//
//
//
//
//
// // ✅ شاشة جديدة لاختبار إضافة Overlay ثاني
// class Button extends StatelessWidget {
//
//
//   const Button({
//     Key? key,
//
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         children: [
//           SizedBox(height: 100,),
//           IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: () {
//               developer.log('Try to close');
//               FlutterOverlayWindow.closeOverlay().then(
//                     (value) => developer.log('STOPPED: value: $value'),
//               );
//             },
//           ),
//           ElevatedButton(
//             onPressed: (){},
//             child: Text('label'),
//           ),
//         ],
//       ),
//     );
//   }
// }







// //
// // //كود بيستخدم method channel لتحديد الشاشة المناسبة
// import 'dart:developer' as developer;
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_overlay_window/flutter_overlay_window.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'ball_game.dart';
// import 'home_page.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
//
// // ✅ هذه الدالة تُستخدم لتشغيل الـ Overlay مع تحديد الشاشة المناسبة
// Future<void> launchOverlay(String overlayType) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('overlay_type', overlayType); // حفظ نوع الـ Overlay
//
//
//
//   await FlutterOverlayWindow.showOverlay(
//     enableDrag: false,
//     overlayTitle: "Overlay Running",
//     overlayContent: 'Overlay Enabled',
//     flag: OverlayFlag.defaultFlag,
//     visibility: NotificationVisibility.visibilityPublic,
//     positionGravity: PositionGravity.auto,
//     height: WindowSize.matchParent,
//     width: WindowSize.matchParent,
//   );
//
//   // تأخير بسيط لضمان بدء تشغيل الـ Overlay قبل إرسال النوع الجديد
//   await Future.delayed(const Duration(milliseconds: 500));
//
//   // إرسال النوع الجديد إلى الـ Overlay عبر MethodChannel
//   const MethodChannel channel = MethodChannel('overlay_channel');
//   try {
//     await channel.invokeMethod("setOverlayType", overlayType);
//   } catch (e) {
//     print("Error setting overlay type: $e");
//   }
// }
//
//
// // ✅ تحديث `overlayMain` لدعم أكثر من شاشة بناءً على البيانات المخزنة مسبقًا
// @pragma("vm:entry-point")
// void overlayMain() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   const MethodChannel channel = MethodChannel('overlay_channel');
//
//   // قراءة القيمة المخزنة عند التشغيل لأول مرة
//   final prefs = await SharedPreferences.getInstance();
//   String overlayType = prefs.getString('overlay_type') ?? "ball_game";
//   // تحميل الشاشة بناءً على القيمة المخزنة مسبقًا
//   _loadInitialOverlayScreen();
//   // الاستماع لأي تحديثات قادمة من التطبيق الرئيسي
//   channel.setMethodCallHandler((call) async {
//     if (call.method == "setOverlayType") {
//       overlayType = call.arguments;
//       _launchOverlayScreen(overlayType);
//     }
//   });
// }
//
// Future<void> _loadInitialOverlayScreen() async {
//   final prefs = await SharedPreferences.getInstance();
//   final String? overlayType = prefs.getString('overlay_type');
//   _launchOverlayScreen(overlayType ?? "ball_game"); // تشغيل الشاشة الافتراضية إذا لم يتم العثور على بيانات
// }
//
// void _launchOverlayScreen(String overlayType) {
//   Widget screen;
//   if (overlayType == "ball_game") {
//     screen = const BallGameApp();
//   } else if (overlayType == "new_overlay") {
//     screen = const Button();
//   } else {
//     screen = const Center(child: Text("Unknown Overlay"));
//   }
//
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: screen,
//     ),
//   );
// }
//
//
//
//
//
// // ✅ شاشة جديدة لاختبار إضافة Overlay ثاني
// class Button extends StatelessWidget {
//   const Button({
//     Key? key,
//
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         children: [
//           SizedBox(height: 100,),
//           IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: () {
//               developer.log('Try to close');
//               FlutterOverlayWindow.closeOverlay().then(
//                     (value) => developer.log('STOPPED: value: $value'),
//               );
//             },
//           ),
//           ElevatedButton(
//             onPressed: (){},
//             child: Text('label'),
//           ),
//         ],
//       ),
//     );
//   }
// }






// //كود بيستخدم method channel لتحديد الشاشة المناسبة
// import 'dart:developer' as developer;
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_overlay_window/flutter_overlay_window.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'ball_game.dart';
// import 'home_page.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
//
// // ✅ هذه الدالة تُستخدم لتشغيل الـ Overlay مع تحديد الشاشة المناسبة
// Future<void> launchOverlay(String overlayType) async {
//   // Update shared preferences
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('overlay_type', overlayType);
//   // First ensure we close any existing overlay
//   try {
//     if (await FlutterOverlayWindow.isActive()) {
//       await FlutterOverlayWindow.closeOverlay();
//       // Wait to ensure overlay is fully closed
//       await Future.delayed(const Duration(milliseconds: 500));
//     }
//   } catch (e) {
//     developer.log('Error closing overlay: $e');
//   }
//
//
//   // Wait a moment before showing new overlay
//   await Future.delayed(const Duration(milliseconds: 100));
//
//   // Show the new overlay
//   await FlutterOverlayWindow.showOverlay(
//     enableDrag: false,
//     overlayTitle: "Overlay Running",
//     overlayContent: 'Overlay Enabled',
//     flag: OverlayFlag.defaultFlag,
//     visibility: NotificationVisibility.visibilityPublic,
//     positionGravity: PositionGravity.auto,
//     height: WindowSize.matchParent,
//     width: WindowSize.matchParent,
//   );
// }
//
//
// // ✅ تحديث `overlayMain` لدعم أكثر من شاشة بناءً على البيانات المخزنة مسبقًا
//
// @pragma("vm:entry-point")
// void overlayMain() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Future.delayed(const Duration(milliseconds: 200));
//
//   // Read the overlay type directly from SharedPreferences
//   final prefs = await SharedPreferences.getInstance();
//   final overlayType = prefs.getString('overlay_type') ?? "ball_game";
//
//   // Launch the appropriate screen
//   Widget screen;
//   if (overlayType == "ball_game") {
//     screen = const BallGameApp();
//   } else if (overlayType == "new_overlay") {
//     screen = const Button();
//   } else {
//     screen = const Center(child: Text("Unknown Overlay"));
//   }
//
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: screen,
//     ),
//   );}
//
// class OverlayStateWrapper extends StatefulWidget {
//   const OverlayStateWrapper({Key? key}) : super(key: key);
//
//   @override
//   State<OverlayStateWrapper> createState() => _OverlayStateWrapperState();
// }
//
// class _OverlayStateWrapperState extends State<OverlayStateWrapper> {
//   late String currentOverlayType;
//   static const channel = MethodChannel('overlay_channel');
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeOverlay();
//     _setupMethodChannel();
//   }
//
//   Future<void> _initializeOverlay() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       currentOverlayType = prefs.getString('overlay_type') ?? "ball_game";
//     });
//   }
//
//   void _setupMethodChannel() {
//     channel.setMethodCallHandler((call) async {
//       if (call.method == "setOverlayType") {
//         setState(() {
//           currentOverlayType = call.arguments;
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: _getOverlayScreen(currentOverlayType),
//     );
//   }
//
//   Widget _getOverlayScreen(String overlayType) {
//     switch (overlayType) {
//       case "ball_game":
//         return const BallGameApp();
//       case "new_overlay":
//         return const Button();
//       default:
//         return const Center(child: Text("Unknown Overlay"));
//     }
//   }
// }
//
// Future<void> _loadInitialOverlayScreen() async {
//   final prefs = await SharedPreferences.getInstance();
//   final String? overlayType = prefs.getString('overlay_type');
//   _launchOverlayScreen(overlayType ?? "ball_game"); // تشغيل الشاشة الافتراضية إذا لم يتم العثور على بيانات
// }
//
// void _launchOverlayScreen(String overlayType) {
//   Widget screen;
//   if (overlayType == "ball_game") {
//     screen = const BallGameApp();
//   } else if (overlayType == "new_overlay") {
//     screen = const Button();
//   } else {
//     screen = const Center(child: Text("Unknown Overlay"));
//   }
//
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: screen,
//     ),
//   );
// }
//
// // ✅ شاشة جديدة لاختبار إضافة Overlay ثاني
// class Button extends StatelessWidget {
//   const Button({
//     Key? key,
//
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         children: [
//           SizedBox(height: 100,),
//           IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: () {
//               developer.log('Try to close');
//               FlutterOverlayWindow.closeOverlay().then(
//                     (value) => developer.log('STOPPED: value: $value'),
//               );
//             },
//           ),
//           ElevatedButton(
//             onPressed: (){},
//             child: Text('label'),
//           ),
//         ],
//       ),
//     );
//   }
// }
