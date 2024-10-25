import 'package:flutter/material.dart';

class Mywidgets {
  Widget mytextField(
      {required String labelText, double? width, final validator,required TextEditingController controller}) {
    return SizedBox(
      width: width, // Use the provided width or let it be flexible
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }
}
