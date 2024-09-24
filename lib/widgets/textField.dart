import 'package:flutter/material.dart';

class Mywidgets {
  Widget mytextField({required String labelText, double? width}) {
    return SizedBox(
      width: width, // Use the provided width or let it be flexible
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
