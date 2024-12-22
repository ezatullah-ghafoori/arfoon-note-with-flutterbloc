import 'package:arfoon_note/frontend/responsive/Responsive_layout.dart';
import 'package:arfoon_note/frontend/responsive/home_desktop_scafold.dart';
import 'package:arfoon_note/frontend/responsive/home_mobile_scafold.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
        mobileScafold: HomeMobileScafold(),
        desktopScafold: HomeDesktopScafold());
  }
}
