import 'package:flutter/material.dart';

class Button {
  Widget textbutton({
    required VoidCallback onPressed,
    required String text,
    Widget? image, // Optional image parameter
    Color? backgroundColor,
    Color? textColor,
    double? fontSize, // Optional fontSize parameter
  }) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: backgroundColor ?? const Color(0xFF0075FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null) ...[
              image, // Display the image if provided
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: fontSize ?? 16, // Use fontSize if provided, default to 16
              ),
            ),
          ],
        ),
      ),
    );
  }
}
