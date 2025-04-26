import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_shop/widgets/custom_snack_bar.dart';
import 'package:http/http.dart' as http;

void httpErroHandling({
  required BuildContext context,
  required http.Response response,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess;
      break;
    case 400 || 401:
      failedSnackBar(jsonDecode(response.body)['message'], context);
      break;
    case 500:
      failedSnackBar(jsonDecode(response.body)['error'], context);
      break;
    default:
      failedSnackBar(jsonDecode(response.body), context);
  }
}

Future<Object?> showHttpError({
  required BuildContext context,
  required Object? error,
}) async {
  failedSnackBar(error.toString(), context);
}
