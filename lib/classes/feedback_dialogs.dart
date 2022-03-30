import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:korba_practical/constants.dart';
import 'package:korba_practical/widgets/shared_widgets/error_modal.dart';
import 'package:korba_practical/widgets/shared_widgets/internet_error_modal.dart';
import 'package:korba_practical/widgets/shared_widgets/success_modal.dart';

enum DialogAction { yes, abort }

class FeedbackDialog {
  errorDialog(BuildContext context, [String? message, bool isShort = true]) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          titlePadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          content: ErrorModal(
            isError: isShort,
            errorMessage: message ?? 'Something went wrong. Try again later.',
            onPressed: () {
              Navigator.of(context).pop(DialogAction.abort);
            },
          ),
        );
      },
    );
  }

  timeoutDialog(BuildContext context, [String? message, bool isShort = true]) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          titlePadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          content: ErrorModal(
            isError: isShort,
            errorMessage: message ??
                'Request is taking long. Please check your internet connection!',
            onPressed: () {
              Navigator.of(context).pop(DialogAction.abort);
            },
          ),
        );
      },
    );
  }

  internetError(BuildContext context, [String? message]) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          titlePadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          content: InternetErrorModal(
            errorMessage: message ??
                'Could not connect to server. Please check your internet connection!',
            onPressed: () {
              Navigator.of(context).pop(DialogAction.abort);
            },
          ),
        );
      },
    );
  }

  alertDialog(BuildContext context, [String? text]) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0.0,
          contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          titlePadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          backgroundColor: Colors.transparent,
          content: SuccessModal(
            text: text,
            onPressed: () {
              Navigator.of(context).pop(DialogAction.abort);
            },
          ),
        );
      },
    );
  }

  Future<void> loadingDialog(BuildContext context, GlobalKey key,
      [String? loadingText]) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: blackColor.withOpacity(0.6),
      builder: (BuildContext context) {
        return BackdropFilter(
          child: WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              elevation: 0.0,
              contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              titlePadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              key: key,
              backgroundColor: Colors.transparent,
              children: const <Widget>[
                Center(
                  child: SpinKitDoubleBounce(
                    color: darkJungleGreenColor,
                    size: 50.0,
                  ),
                ),
              ],
            ),
          ),
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        );
      },
    );
  }
}
