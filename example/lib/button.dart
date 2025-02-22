import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              developer.log('Try to close');
              FlutterOverlayWindow.closeOverlay().then(
                (value) => developer.log('STOPPED: value: $value'),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('label'),
          ),
        ],
      ),
    );
  }
}
