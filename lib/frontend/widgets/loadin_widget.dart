import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadinWidget extends StatefulWidget {
  final double width;
  const LoadinWidget({super.key, required this.width});

  @override
  State<LoadinWidget> createState() => _LoadinWidgetState();
}

class _LoadinWidgetState extends State<LoadinWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "assets/animation/loading_ani.json",
      width: widget.width,
      controller: _controller,
    );
  }
}
