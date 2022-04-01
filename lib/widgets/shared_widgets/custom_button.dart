// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:korba_practical/constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double height;
  final String text;
  final Color color;
  final Color? iconColor;
  final TextStyle textStyle;
  final Color? disabledColor;
  final Color? borderColor;
  final double elevation;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.color,
    this.iconColor,
    required this.textStyle,
    this.disabledColor,
    this.borderColor = Colors.transparent,
    this.height = 35.0,
    this.elevation = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;

    return Material(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.0, color: borderColor!),
        borderRadius: BorderRadius.circular(
          8.0 * multiplier * mediaQueryHeight,
        ),
      ),
      color: color,
      child: MaterialButton(
        onPressed: onPressed,
        height: height,
        disabledColor: disabledColor,
        child: Center(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
