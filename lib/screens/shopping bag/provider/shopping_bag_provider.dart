import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:grocery_shop/util/util.dart';
import 'package:grocery_shop/widgets/custom_snack_bar.dart';
import 'package:http/http.dart' as http;

class ShoppingBagProvider extends ChangeNotifier {
  List<ProductModel> _cart = [];
  List<ProductModel> _filterCart = [];
  List<ProductModel> get cart => _cart;
  List<ProductModel> get filterCart => _filterCart;

  Future<List<ProductModel>> fetchAllCartProduct({
    required BuildContext context,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(getCartProductRoute),
        headers: headers,
      );

      if (context.mounted) {
        httpErrorHandling(
          context: context,
          response: response,
          onSuccess: () {
            final List<dynamic> decoded = jsonDecode(response.body);
            _cart = decoded.map((json) => ProductModel.fromMap(json)).toList();
            _filterCart = _cart;
            notifyListeners();
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showHttpError(context: context, e: e);
      }
    }
    return _cart;
  }

  Future<bool> addToCart({
    required BuildContext context,
    required String userId,
    required String productId,
    required ProductModel product,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(addToCartRoute),
        headers: headers,
        body: jsonEncode({
          'userId': userId,
          'productId': productId,
          'quantity': 1,
        }),
      );
      if (context.mounted) {
        httpErrorHandling(
          context: context,
          response: response,
          onSuccess: () {
            _cart.add(product);
            _filterCart = _cart;
            successSnackBar("Product added successfully", context);
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

  Future<bool> deleteProductFromCart({
    required BuildContext context,
    required String userId,
    required String productId,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse(deleteFromCartRoute),
        headers: headers,
        body: jsonEncode({'userId': userId, 'productId': productId}),
      );
      if (context.mounted) {
        httpErrorHandling(
          context: context,
          response: response,
          onSuccess: () {
            _cart.removeWhere((item) => item.id == productId);
            _filterCart = _cart;
            successSnackBar("Product removed successfullt", context);
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

  Future<List<ProductModel>> filterCartProduct({required String query}) async {
    _filterCart =
        _cart
            .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
    return _filterCart;
  }
}
