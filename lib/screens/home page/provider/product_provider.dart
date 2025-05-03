import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:grocery_shop/util/util.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> _filterProducts = [];
  List<ProductModel> _getAllProductByCategory = [];
  List<ProductModel> _filterProductsBySubcategoryId = [];

  List<ProductModel> get products => _products;
  List<ProductModel> get filterProducts => _filterProducts;
  List<ProductModel> get getAllProductByCategory => _getAllProductByCategory;
  List<ProductModel> get filterProductsBySubcategoryId =>
      _filterProductsBySubcategoryId;

  Future<List<ProductModel>> fetchAllProducts({
    required BuildContext context,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(getAllProductRoute),
        headers: headers,
      );

      if (context.mounted) {
        httpErrorHandling(
          context: context,
          response: response,
          onSuccess: () {
            final List<dynamic> decoded = jsonDecode(response.body);
            _products =
                decoded.map((json) => ProductModel.fromMap(json)).toList();
            _filterProducts = _products;
            notifyListeners();
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showHttpError(context: context, e: e);
      }
    }
    return _products;
  }

  Future<List<ProductModel>> filterProduct({required String query}) async {
    _filterProducts =
        _products
            .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
    notifyListeners();
    return _filterProducts;
  }

  void filterProductBySubcategoryId({required String subcategoryId}) {
    _filterProductsBySubcategoryId =
        _products.where((item) => item.subCategoryId == subcategoryId).toList();
    notifyListeners();
  }

  void filterProductByCategoryId({required String categoryId}) {
    _filterProductsBySubcategoryId =
        _products.where((item) => item.categoryId == categoryId).toList();
    notifyListeners();
  }

  Future<List<ProductModel>> getAllProductsByCategory({
    required BuildContext context,
    required String category,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$getAllProductByCategoryRoute?category=$category'),
        headers: headers,
      );

      if (context.mounted) {
        httpErrorHandling(
          context: context,
          response: response,
          onSuccess: () {
            final List<dynamic> decoded = jsonDecode(response.body);
            _getAllProductByCategory =
                decoded.map((json) => ProductModel.fromMap(json)).toList();
            notifyListeners();
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showHttpError(context: context, e: e);
      }
    }
    return _getAllProductByCategory;
  }
}
