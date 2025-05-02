import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/model/subcategory_model.dart';
import 'package:grocery_shop/util/util.dart';
import 'package:http/http.dart' as http;

class SubcategoryProvider extends ChangeNotifier {
  List<SubCategoryModel> _subcategory = [];
  List<SubCategoryModel> _filterSubcategory = [];

  List<SubCategoryModel> get subcategory => _subcategory;
  List<SubCategoryModel> get filterSubcategory => _filterSubcategory;

  Future<List<SubCategoryModel>> fetchSubcategoryByCategoryId({
    required BuildContext context,
    required String categoryId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$getSubcategryByCategoryIdRoute/$categoryId'),
        headers: headers,
      );

      if (context.mounted) {
        httpErrorHandling(
          context: context,
          response: response,
          onSuccess: () {
            log(response.body);
            log(jsonDecode(response.body).toString());
            final List<dynamic> decoded = jsonDecode(response.body);
            _subcategory =
                decoded.map((json) => SubCategoryModel.fromMap(json)).toList();
            notifyListeners();
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showHttpError(context: context, e: e);
      }
    }
    return _subcategory;
  }

  Future<List<SubCategoryModel>> filterSubcategoryByCategoryId({
    required String categoryId,
  }) async {
    _filterSubcategory =
        _subcategory.where((item) => item.categoryId == categoryId).toList();
    notifyListeners();
    return _filterSubcategory;
  }
}
