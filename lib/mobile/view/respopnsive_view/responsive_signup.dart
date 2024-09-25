import 'package:flutter/material.dart';
// Import your web interface

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScreen;
  final Widget webScreen;

  const ResponsiveLayout({
    required this.mobileScreen,
    required this.webScreen,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          // Show mobile UI if width is less than 800
          return mobileScreen;
        } else {
          // Show web UI if width is greater than or equal to 800
          return webScreen;
        }
      },
    );
  }
}
