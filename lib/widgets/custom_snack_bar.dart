import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';

void successSnackBar(String message, BuildContext context) {
  DelightToastBar(
    builder:
        (context) => ToastCard(
          color: mainColor,
          title: Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
    position: DelightSnackbarPosition.top,
    autoDismiss: true,
    snackbarDuration: const Duration(seconds: 2),
  ).show(context);
}

void failedSnackBar(String message, BuildContext context) {
  DelightToastBar(
    builder:
        (context) => ToastCard(
          color: Colors.red,
          title: Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
    snackbarDuration: const Duration(seconds: 2),
    autoDismiss: true,
    position: DelightSnackbarPosition.top,
  ).show(context);
}
