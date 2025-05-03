import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/model/user_model.dart';
import 'package:grocery_shop/util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileProvider extends ChangeNotifier {
  UserModel _user = UserModel(username: '', email: '', password: '');

  UserModel get user => _user;

  void getUser() async {
    final pref = await SharedPreferences.getInstance();
    _user = UserModel(
      username: pref.getString('username') ?? '',
      email: pref.getString('email') ?? '',
      password: '',
    );
    notifyListeners();
  }

  Future<bool> updateUser({
    required BuildContext context,
    required String id,
    required String username,
    required String email,
    required String currentPassword, // pass current password here
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$updateProfileRoute/$id'),
        headers: headers,
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': currentPassword, // Send the current password
          'type': 'user',
        }),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      httpErrorHandling(
        context: context,
        response: response,
        onSuccess: () async {
          final pref = await SharedPreferences.getInstance();
          final username = jsonDecode(response.body)['user']['username'];
          final email = jsonDecode(response.body)['user']['email'];
          pref.setString('username', username);
          pref.setString('email', email);
          _user = UserModel(
            username: username,
            email: email,
            password: currentPassword,
          );
          notifyListeners();
        },
      );
      return true;
    } catch (e) {
      if (context.mounted) {
        print("Error: $e");
        showHttpError(context: context, e: e);
      }
      return false;
    }
  }
}
