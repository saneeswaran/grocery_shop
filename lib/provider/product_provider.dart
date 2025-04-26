import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/http%20error%20handling/http_error_handling.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _product = [];
  List<ProductModel> _filterProduct = [];
  List<ProductModel> get product => _product;
  List<ProductModel> get filterProduct => _filterProduct;

  Future<List<ProductModel>> fetchAllProduct({
    required BuildContext context,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(getAllProductRoute),
        headers: headers,
      );
      if (context.mounted) {
        httpErroHandling(
          context: context,
          response: response,
          onSuccess: () {
            List<dynamic> decoded = jsonDecode(response.body);
            _product =
                decoded.map((json) => ProductModel.fromMap(json)).toList();
            notifyListeners();
            _filterProduct = _product;
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showHttpError(context: context, error: e);
      }
    }
    return _product;
  }

  Future<List<ProductModel>> filterProducts({required String query}) async {
    _filterProduct =
        _product
            .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
    notifyListeners();
    return _filterProduct;
  }
}
