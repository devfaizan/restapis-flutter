import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IconButtons extends StatelessWidget {
  IconData compIcon;
  Color? compColor;
  VoidCallback dothis;
  IconButtons({
    super.key,
    required this.compIcon,
    this.compColor,
    required this.dothis,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: dothis,
      child: Icon(
        compIcon,
        color: compColor,
      ),
    );
  }
}
