import 'package:flutter/material.dart';
import 'package:korba_practical/constants.dart';

class SuccessModal extends StatelessWidget {
  const SuccessModal({
    Key? key,
    this.text = 'Done',
    required this.onPressed,
  }) : super(key: key);

  final String? text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(
        top: 30 * multiplier * mediaQueryHeight,
        left: 10 * multiplier * mediaQueryHeight,
        bottom: Constant.kSize(mediaQueryHeight, 0, 0, 10),
        right: 10 * multiplier * mediaQueryHeight,
      ),
      height: 200 * multiplier * mediaQueryHeight,
      width: 150 * multiplier * mediaQueryHeight,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Flexible(
            flex: 4,
            child: Container(
              height: 60.0 * multiplier * mediaQueryHeight,
              width: 60.0 * multiplier * mediaQueryHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: neonGreenColor.withOpacity(0.2),
              ),
              child: Icon(
                Icons.check,
                size: 40.0 * multiplier * mediaQueryHeight,
                color: neonGreenColor,
              ),
            ),
          ),
          SizedBox(height: Constant.kSize(mediaQueryHeight, 0, 0, 5)),
          Flexible(
            flex: 6,
            child: TextButton(
              onPressed: onPressed,
              child: Text(
                text ?? 'Done',
                style: smallTextStyle.copyWith(
                  color: Colors.black,
                  fontSize: Constant.kSize(mediaQueryHeight, 16, 16, 14),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
