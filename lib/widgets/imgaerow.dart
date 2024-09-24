import 'package:flutter/material.dart';

class Imgaerow {
  Widget imgrow() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20),
      child: Row(
        children: [
          Image.asset('asset/images/coding.png'),
          const SizedBox(
            width: 25,
          ),
          Image.asset('asset/images/design.png'),
          const SizedBox(
            width: 25,
          ),
          Image.asset('asset/images/marketing.png'),
        ],
      ),
    );
  }
}
