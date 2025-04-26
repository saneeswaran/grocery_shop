import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/http%20error%20handling/http_error_handling.dart';
import 'package:grocery_shop/model/category_model.dart';
import 'package:grocery_shop/widgets/custom_snack_bar.dart';
import 'package:http/http.dart' as http;

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> _category = [];
  List<CategoryModel> _filterCategies = [];

  List<CategoryModel> get category => _category;
  List<CategoryModel> get filterCategies => _filterCategies;

  Future<List<CategoryModel>> fetchAllCategory({
    required BuildContext context,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(getAllCategoryRoute),
        headers: headers,
      );

      if (context.mounted) {
        httpErroHandling(
          context: context,
          response: response,
          onSuccess: () {
            successSnackBar("Category Fetched", context);
            final List<dynamic> decoded = jsonDecode(response.body);
            _category =
                decoded.map((item) => CategoryModel.fromMap(item)).toList();
            _filterCategies = _category;
            notifyListeners();
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showHttpError(context: context, error: e);
      }
    }
    return _category;
  }

  Future<List<CategoryModel>> filterCategory({required String query}) async {
    _filterCategies =
        _category
            .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
    notifyListeners();
    return _filterCategies;
  }
}
