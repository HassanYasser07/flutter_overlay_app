import 'package:flutter/material.dart';
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BallGameApp(),
    ),
  );
}



// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ResizableBoxScreen(),
//     );
//   }
// }
//
// class ResizableBoxScreen extends StatefulWidget {
//   @override
//   _ResizableBoxScreenState createState() => _ResizableBoxScreenState();
// }
//
// class _ResizableBoxScreenState extends State<ResizableBoxScreen> {
//   double boxWidth = 150;
//   double boxHeight = 150;
//   double topOffset = 100;
//   double leftOffset = 100;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Resizable Box")),
//       body: Stack(
//         children: [
//           Positioned(
//             top: topOffset,
//             left: leftOffset,
//             child: Container(
//               width: boxWidth,
//               height: boxHeight,
//               color: Colors.blue,
//               child: Stack(
//                 children: [
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: GestureDetector(
//                       onPanUpdate: (details) {
//                         setState(() {
//                           boxHeight += details.delta.dy;
//                           boxWidth += details.delta.dx;
//                         });
//                       },
//                       child: Container(
//                         width: 20,
//                         height: 20,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 0,
//                     left: 0,
//                     child: GestureDetector(
//                       onPanUpdate: (details) {
//                         setState(() {
//                           double newHeight = boxHeight - details.delta.dy;
//                           double newWidth = boxWidth - details.delta.dx;
//                           if (newHeight > 50) {
//                             topOffset += details.delta.dy;
//                             boxHeight = newHeight;
//                           }
//                           if (newWidth > 50) {
//                             leftOffset += details.delta.dx;
//                             boxWidth = newWidth;
//                           }
//                         });
//                       },
//                       child: Container(
//                         width: 20,
//                         height: 20,
//                         color: Colors.green,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
