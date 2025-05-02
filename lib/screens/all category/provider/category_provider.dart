import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/model/category_model.dart';
import 'package:grocery_shop/util/util.dart';
import 'package:http/http.dart' as http;

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> _category = [];
  List<CategoryModel> get category => _category;

  Future<List<CategoryModel>> fetchAllCategory({
    required BuildContext context,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(getAllCategoryRoute),
        headers: headers,
      );

      if (context.mounted) {
        httpErrorHandling(
          context: context,
          response: response,
          onSuccess: () {
            final List<dynamic> decoded = jsonDecode(response.body);
            _category =
                decoded.map((json) => CategoryModel.fromMap(json)).toList();
            notifyListeners();
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showHttpError(context: context, e: e);
      }
    }
    return _category;
  }
}
