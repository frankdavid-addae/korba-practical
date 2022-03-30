import 'package:flutter/material.dart';
import 'package:korba_practical/constants.dart';

class InternetErrorModal extends StatelessWidget {
  const InternetErrorModal({
    Key? key,
    required this.errorMessage,
    required this.onPressed,
  }) : super(key: key);

  final String errorMessage;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(
        top: 30 * multiplier * mediaQueryHeight,
        left: 15 * multiplier * mediaQueryHeight,
        right: 15 * multiplier * mediaQueryHeight,
      ),
      height: Constant.kSize(mediaQueryHeight, 250.0, 250.0, 250.0),
      width: 150 * multiplier * mediaQueryHeight,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60.0 * multiplier * mediaQueryHeight,
            width: 60.0 * multiplier * mediaQueryHeight,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: redMunsellColor.withOpacity(0.2),
            ),
            child: Icon(
              Icons.wifi_off_outlined,
              size: 40.0 * multiplier * mediaQueryHeight,
              color: redMunsellColor,
            ),
          ),
          SizedBox(height: 20.0 * multiplier * mediaQueryHeight),
          Expanded(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: errorMessage,
                style: smallTextStyle.copyWith(
                  color: Colors.black,
                  fontSize: Constant.kSize(mediaQueryHeight, 16.0, 16.0, 14.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0 * multiplier * mediaQueryHeight),
          Container(
            alignment: Alignment.center,
            height: 35.0 * multiplier * mediaQueryHeight,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
            child: OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor: darkJungleGreenColor,
                side: BorderSide.none,
              ),
              child: Text(
                'Close',
                style: smallTextStyle.copyWith(
                  fontSize: 15.0 * multiplier * mediaQueryHeight,
                  color: whiteColor,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0 * multiplier * mediaQueryHeight),
        ],
      ),
    );
  }
}
