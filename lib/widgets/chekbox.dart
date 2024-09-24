import 'package:flutter/material.dart';

class RememberMeCheckbox extends StatefulWidget {
  final String labelText; // New parameter to accept custom text

  const RememberMeCheckbox({super.key, this.labelText = 'Remember me'});

  @override
  // ignore: library_private_types_in_public_api
  _RememberMeCheckboxState createState() => _RememberMeCheckboxState();
}

class _RememberMeCheckboxState extends State<RememberMeCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            Text(widget.labelText), 
          ],
        ),
      ],
    );
  }
}
