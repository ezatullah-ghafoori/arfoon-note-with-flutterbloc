import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ContentLoadingWidget extends StatelessWidget {
  const ContentLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset("assets/animation/loading_ani.json");
  }
}
