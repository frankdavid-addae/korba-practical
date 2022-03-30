import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const multiplier = 0.0012;
const multiplierHalf = 0.0006;
const fS10 = 10.0 * multiplier;
const fS11 = 11.0 * multiplier;
const fS12 = 12.0 * multiplier;
const fS13 = 13.0 * multiplier;
const fS14 = 14.0 * multiplier;
const fS15 = 15.0 * multiplier;
const fS16 = 16.0 * multiplier;
const fS17 = 17.0 * multiplier;
const fS18 = 18.0 * multiplier;
const fS19 = 19.0 * multiplier;
const fS20 = 20.0 * multiplier;
const fS22 = 22.0 * multiplier;
const fS24 = 24.0 * multiplier;
const fS26 = 26.0 * multiplier;
const fS28 = 28.0 * multiplier;
const fS30 = 30.0 * multiplier;
const fS32 = 32.0 * multiplier;
const fS34 = 34.0 * multiplier;
const fS36 = 36.0 * multiplier;

const whiteColor = Color(0xFFFFFFFF);
const blackColor = Color(0xFF000000);
const silverSandColor = Color(0xFFC8CACB);
const graniteGrayColor = Color(0xFF5F646A);
const redMunsellColor = Color(0xFFED1944);
const neonGreenColor = Color(0xFF42EC18);
const eerieBlackColor = Color(0xFF1B1C1E);

class ImageStrings {
  // static String topRightCornerImg = 'assets/images/top_right_corner.png';
  // static String backgroundImg = 'assets/images/background.png';
}

const bigScreenHeight = 800;
const smallScreenHeight = 600;

class Constant {
  static double size(double mediaQueryHeight, double onSmallScreen,
      double onMediumScreen, double onBigScreen) {
    return mediaQueryHeight <= smallScreenHeight
        ? onSmallScreen * mediaQueryHeight
        : mediaQueryHeight <= bigScreenHeight
            ? onMediumScreen * mediaQueryHeight
            : onBigScreen * mediaQueryHeight;
  }

  static double kSize(double mediaQueryHeight, double onSmallScreen,
      double onMediumScreen, double onBigScreen) {
    return mediaQueryHeight <= smallScreenHeight
        ? (onSmallScreen * multiplier) * mediaQueryHeight
        : mediaQueryHeight <= bigScreenHeight
            ? (onMediumScreen * multiplier) * mediaQueryHeight
            : (onBigScreen * multiplier) * mediaQueryHeight;
  }
}

const kPagePadding = 20.0;
const leftAndRightScreenPadding =
    EdgeInsets.only(left: kPagePadding, right: kPagePadding);

TextStyle bigTextStyle = GoogleFonts.montserrat(
  color: blackColor,
  fontSize: 24.0,
  fontWeight: FontWeight.w500,
);

TextStyle mediumTextStyle = GoogleFonts.montserrat(
  color: blackColor,
  fontSize: 20.0,
);

TextStyle smallTextStyle = GoogleFonts.montserrat(
  color: blackColor,
  fontSize: 15.0,
);
