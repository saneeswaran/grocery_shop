import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_shop/widgets/custom_snack_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

void moveToNextPageWithReplace(context, page) => Navigator.pushReplacement(
  context,
  PageTransition(
    type: PageTransitionType.fade,
    duration: const Duration(milliseconds: 500),
    child: page,
  ),
);

void moveToPage(context, page) => Navigator.push(
  context,
  PageTransition(
    type: PageTransitionType.fade,
    duration: const Duration(milliseconds: 500),
    child: page,
  ),
);

void httpErrorHandling({
  required BuildContext context,
  required http.Response response,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
    case 201:
      onSuccess();
      break;
    case 400:
    case 409:
    case 500:
      try {
        var decoded = jsonDecode(response.body);
        warningSnackBar(
          decoded is String
              ? decoded
              : (decoded['message'] ?? 'Something went wrong'),
          context,
        );
      } catch (e) {
        failedSnackBar('Error parsing server response', context);
      }
      break;
    default:
      failedSnackBar('Unexpected error: ${response.statusCode}', context);
  }
}

void showHttpError({required BuildContext context, required Object? e}) {
  failedSnackBar(e.toString(), context);
}
