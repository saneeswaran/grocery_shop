import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  //register user
  Future<bool> registerUser({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(registerRoute),
        headers: headers,
        body: jsonEncode(<String, String>{
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      final resData = jsonDecode(response.body);
      log("Username: $username");
      log("Email: $email");
      log("Password: $password");

      log(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(resData['message'] ?? "Registration Failed"),
            ),
          );
        }
        return false;
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
      return false;
    }
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

      final resData = jsonDecode(response.body);
      log("Email: $email");
      log("Password: $password");

      log(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final pref = await SharedPreferences.getInstance();
        await pref.setString('token', resData['token']);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(resData['message'] ?? "Login Failed")),
          );
        }
        return true;
      }
      return false;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
      return false;
    }
  }

  Future<bool> verifyToken() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");

    if (token == null) return false;

    final response = await http.get(
      Uri.parse(verifyTokenRoute),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    // Debugging output
    log("Verify Token Response Body: ${response.body}");
    log("Verify Token Content-Type: ${response.headers['content-type']}");

    // Only decode if it's JSON
    if (response.headers['content-type']?.contains('application/json') ==
        true) {
      final data = jsonDecode(response.body);
      return data['valid'] ?? false;
    } else {
      log("Invalid response format. Expected JSON.");
      return false;
    }
  }
}
