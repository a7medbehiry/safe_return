import 'package:flutter/material.dart';
import 'package:safe_return/constants.dart';

import '../styles.dart';

class SnackBarManager {
  static bool _isSnackBarVisible = false;

  static void showSnackBar(BuildContext context, String message) {
    if (_isSnackBarVisible) {
      return;
    }

    _isSnackBarVisible = true;

    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child: Container(
                color: kPrimaryColor,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  message,
                  style: Styles.textStyleMed15,
                ),
              ),
            ),
            duration: const Duration(seconds: 2),
          ),
        )
        .closed
        .then((_) {
      _isSnackBarVisible = false;
    });
  }
}

class LoginSnackBarManager {
  static bool _isSnackBarVisible = false;

  static void showSnackBar(BuildContext context, String message) {
    if (_isSnackBarVisible) {
      return;
    }

    _isSnackBarVisible = true;

    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child: Container(
                color: kSecondColor,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  message,
                  style: Styles.textStyleMed15.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            duration: const Duration(seconds: 2),
          ),
        )
        .closed
        .then((_) {
      _isSnackBarVisible = false;
    });
  }
}