import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScafold;
  final Widget desktopScafold;
  const ResponsiveLayout(
      {super.key, required this.mobileScafold, required this.desktopScafold});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 500) {
        return mobileScafold;
      } else {
        return desktopScafold;
      }
    });
  }
}
