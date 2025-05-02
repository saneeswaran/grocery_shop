import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/model/subcategory_model.dart';
import 'package:grocery_shop/util/util.dart';
import 'package:http/http.dart' as http;

class SubcategoryProvider extends ChangeNotifier {
  List<SubCategoryModel> _subcategory = [];
  List<SubCategoryModel> get subcategory => _subcategory;

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
}
