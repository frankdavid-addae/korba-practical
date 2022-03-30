import 'package:flutter/material.dart';
import 'package:korba_practical/constants.dart';

class UserDetailsScreen extends StatefulWidget {
  static const routeName = 'user-details-screen';

  const UserDetailsScreen({Key? key, this.userDetails}) : super(key: key);

  final Map<String, dynamic>? userDetails;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: silverSandColor,
      appBar: AppBar(
        backgroundColor: eerieBlackColor,
        title: Text(
          'User Details',
          style: smallTextStyle.copyWith(
            color: silverSandColor,
            fontWeight: FontWeight.w600,
            fontSize: Constant.kSize(mediaQueryHeight, 24.0, 22.0, 20.0),
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: leftAndRightScreenPadding.copyWith(
          top: 30.0 * multiplier * mediaQueryHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: whiteColor,
              backgroundImage:
                  NetworkImage(widget.userDetails!['profilepicture']),
              radius: 60.0,
            ),
            SizedBox(height: 15.0 * multiplier * mediaQueryHeight),
            Text(
              widget.userDetails!['name'],
              style: smallTextStyle.copyWith(
                color: graniteGrayColor,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w600,
                fontSize: Constant.kSize(mediaQueryHeight, 28.0, 26.0, 24.0),
              ),
            ),
            SizedBox(height: 10.0 * multiplier * mediaQueryHeight),
            Text(
              widget.userDetails!['email'],
              style: smallTextStyle.copyWith(
                color: graniteGrayColor,
                letterSpacing: 1.2,
                fontSize: Constant.kSize(mediaQueryHeight, 24.0, 22.0, 20.0),
              ),
            ),
            SizedBox(height: 10.0 * multiplier * mediaQueryHeight),
            Text(
              widget.userDetails!['location'],
              style: smallTextStyle.copyWith(
                color: graniteGrayColor,
                letterSpacing: 1.5,
                fontSize: Constant.kSize(mediaQueryHeight, 24.0, 22.0, 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
