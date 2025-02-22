import 'package:flutter/material.dart';

class DraggableControlButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Offset initialPosition;

  const DraggableControlButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.initialPosition,
  }) : super(key: key);

  @override
  State<DraggableControlButton> createState() => _DraggableControlButtonState();
}

class _DraggableControlButtonState extends State<DraggableControlButton> {
  late Offset position;

  @override
  void initState() {
    super.initState();
    position = widget.initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        feedback: Material(
          color: Colors.transparent,
          child: IconButton(
            icon: Icon(widget.icon),
            onPressed: null,
          ),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) {
          setState(() {
            position = details.offset;
          });
        },
        child: IconButton(
          icon: Icon(widget.icon),
          onPressed: widget.onPressed,
        ),
      ),
    );
  }
}