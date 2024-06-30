import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle thickheading = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  static const TextStyle normal = TextStyle(
    fontSize: 16.0,
  );
  static const TextStyle highlighter = TextStyle(
    fontWeight: FontWeight.bold,
  );
  static TextStyle buttonNormal(ThemeData theme) {
    return TextStyle(
      fontSize: 16.0,
      color: theme.primaryColor,
    );
  }
}
