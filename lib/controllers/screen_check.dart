import 'package:flutter/material.dart';
import 'package:haca_review_main/View/home.dart';
import 'package:haca_review_main/mobile/view/mobile_sigin.dart';

class ScreenCheck extends StatelessWidget {
  const ScreenCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, screensize) {
        if (screensize.maxWidth >= 600) {
          return const Home();
        } else {
          return const mobile_sigin();
        }
      },
    );
  }
}
