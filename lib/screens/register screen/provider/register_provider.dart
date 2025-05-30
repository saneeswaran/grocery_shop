import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/util/util.dart';
import 'package:grocery_shop/widgets/custom_snack_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterProvider extends ChangeNotifier {
  Future<bool> registerUser({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
    String type = "user",
  }) async {
    try {
      final response = await http.post(
        Uri.parse(registerRoute),
        headers: headers,
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
          'type': type,
        }),
      );

      if (context.mounted) {
        bool isSuccess = false;
        httpErrorHandling(
          context: context,
          response: response,
          onSuccess: () {
            successSnackBar(
              "User registered successfully. Please Login",
              context,
            );
            isSuccess = true;
            notifyListeners();
          },
        );
        return isSuccess;
      }
      return false;
    } catch (e) {
      if (context.mounted) {
        showHttpError(context: context, e: e);
      }
    }
    return false;
  }

  Future<Map<String, String>> getAuthHeaders() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token') ?? '';
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<bool> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(loginRoute),
        headers: headers,
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (context.mounted) {
        httpErrorHandling(
          context: context,
          response: response,
          onSuccess: () async {
            final pref = await SharedPreferences.getInstance();
            final token = jsonDecode(response.body)['token'];
            final userId = jsonDecode(response.body)['user']['id'];
            final username = jsonDecode(response.body)['user']['username'];
            final email = jsonDecode(response.body)['user']['email'];

            // Store token and user data in SharedPreferences
            await pref.setString('userId', userId);
            await pref.setString('username', username);
            await pref.setString('email', email);
            await pref.setString('token', token);

            notifyListeners();
          },
        );
        return true;
      }
    } catch (e) {
      if (context.mounted) {
        showHttpError(context: context, e: e);
      }
    }
    return false;
  }
}
