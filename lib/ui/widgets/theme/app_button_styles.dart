import 'package:flutter/material.dart';

abstract class AppButtonStyles {
  static const auth = ButtonStyle(
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
    ),
    minimumSize: WidgetStatePropertyAll(
      Size(0, 0),
    ),
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
  );
}
