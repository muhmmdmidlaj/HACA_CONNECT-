import 'package:flutter/material.dart';

class Imgaerow {
  Widget imgrow() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: Image.asset('asset/images/coding.png')),
          // const SizedBox(
          //   width: 25,
          // ),
          Expanded(child: Image.asset('asset/images/design.png')),
          // const SizedBox(
          //   width: 25,
          // ),
          Expanded(child: Image.asset('asset/images/marketing.png')),
        ],
      ),
    );
  }
}
