import 'package:flutter/material.dart';

class ImageRowphone {
  Widget phoneimgrow(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    // Define sizes based on screen height
    double imageWidth = screenHeight > 800 ? 82 : 70;
    double imageHeight = screenHeight > 800 ? 48 : 38;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              'asset/images/coding.png',
              width: imageWidth,
              height: imageHeight,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'asset/images/design.png',
              width: imageWidth,
              height: imageHeight,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              'asset/images/marketing.png',
              width: imageWidth,
              height: imageHeight,
            ),
          ),
        ],
      ),
    );
  }
}
