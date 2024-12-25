import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ContentLoadingWidget extends StatefulWidget {
  final double? width;
  const ContentLoadingWidget({super.key, this.width});

  @override
  State<ContentLoadingWidget> createState() => _ContentLoadingWidgetState();
}

class _ContentLoadingWidgetState extends State<ContentLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
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
      "assets/animation/content_loading.json",
      width: widget.width,
      controller: _controller,
    );
  }
}
