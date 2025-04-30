import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/model/category_model.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:grocery_shop/util/util.dart';
import 'package:http/http.dart' as http;

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> _category = [];
  List<ProductModel> _categoryProductById = [];
  List<CategoryModel> get category => _category;
  List<ProductModel> get categoryProductById => _categoryProductById;

  Future<List<CategoryModel>> fetchAllcCategory({
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

  Future<List<ProductModel>> fetchSpecificCategoryProduct({
    required BuildContext context,
    required String categoryId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$getCartProductRoute/$categoryId'),
        headers: headers,
      );
      if (context.mounted) {
        httpErrorHandling(
          context: context,
          response: response,
          onSuccess: () {
            final List<dynamic> decoded = jsonDecode(response.body);
            _categoryProductById =
                decoded.map((json) {
                  final productData = json['productId'];
                  return ProductModel.fromJson(productData);
                }).toList();
            notifyListeners();
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showHttpError(context: context, e: e);
      }
    }
    return _categoryProductById;
  }
}
