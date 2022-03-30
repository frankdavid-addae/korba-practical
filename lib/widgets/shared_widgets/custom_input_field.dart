// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:korba_practical/constants.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.autofocus = false,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.left,
    this.maxLines = 1,
    this.controller,
    this.readOnly = false,
    this.suffixIcon,
    this.prefix,
    this.inputFormatters,
    this.fillColor = whiteColor,
    this.maxLength,
  }) : super(key: key);

  final onSaved;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final bool autofocus;
  final String? hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextAlign textAlign;
  final int? maxLines;
  final TextEditingController? controller;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final Color fillColor;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    // double mediaQueryWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: Constant.size(mediaQueryHeight, 0.12, 0.11, 0.1),
      child: TextFormField(
        obscureText: obscureText,
        autofocus: autofocus,
        keyboardType: keyboardType,
        textAlign: textAlign,
        style: smallTextStyle.copyWith(
          fontSize: Constant.kSize(mediaQueryHeight, 17.0, 16.0, 15.0),
          color: darkJungleGreenColor,
        ),
        validator: validator,
        onChanged: onChanged,
        maxLines: maxLines,
        readOnly: readOnly,
        controller: controller,
        inputFormatters: inputFormatters,
        cursorHeight: Constant.kSize(mediaQueryHeight, 24.0, 22.0, 20.0),
        cursorColor: darkJungleGreenColor,
        cursorWidth: 2.0,
        maxLength: maxLength,
        decoration: InputDecoration(
          hintText: hintText,
          prefix: prefix,
          suffixIcon: suffixIcon,
          hintStyle: smallTextStyle.copyWith(
            fontSize: Constant.kSize(mediaQueryHeight, 17.0, 16.0, 15.0),
            color: darkJungleGreenColor,
          ),
          counterText: '',
          helperText: ' ',
          fillColor: fillColor.withOpacity(0.5),
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: Constant.kSize(mediaQueryHeight, 22.0, 20.0, 18.0),
            horizontal: 20.0 * mediaQueryHeight * multiplier,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: graniteGrayColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(
              8.0 * multiplier * mediaQueryHeight,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: graniteGrayColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(
              8.0 * multiplier * mediaQueryHeight,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: graniteGrayColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(
              8.0 * multiplier * mediaQueryHeight,
            ),
          ),
        ),
      ),
    );
  }
}
