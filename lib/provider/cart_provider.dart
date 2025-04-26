import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/http%20error%20handling/http_error_handling.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:grocery_shop/widgets/custom_snack_bar.dart';
import 'package:http/http.dart' as http;

class CartProvider extends ChangeNotifier {
  List<ProductModel> _cart = [];
  List<ProductModel> _filterProducts = [];

  List<ProductModel> get cart => _cart;
  List<ProductModel> get filterProducts => _filterProducts;

  Future<List<ProductModel>> fetchCartProducts({
    required BuildContext context,
    required String userId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$getCartProductRoute/$userId'),
        headers: headers,
      );
      if (context.mounted) {
        httpErroHandling(
          context: context,
          response: response,
          onSuccess: () {
            List<dynamic> decoded = jsonDecode(response.body);
            _cart = decoded.map((json) => ProductModel.fromMap(json)).toList();
            _filterProducts = _cart;
            notifyListeners();
            successSnackBar("Cart Fetched", context);
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showHttpError(context: context, error: e);
      }
    }
    return _cart;
  }

  Future<bool> addToCart({
    required BuildContext context,
    required String userId,
    required String productId,
    int quantity = 1,
    required ProductModel product,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(addToCartRoute),
        headers: headers,
        body: jsonEncode({
          'userId': userId,
          'productId': productId,
          'quantity': quantity,
        }),
      );

      if (context.mounted) {
        bool isSuccess = false;
        httpErroHandling(
          context: context,
          response: response,
          onSuccess: () {
            final bool existsProduct = _cart.any(
              (item) => item.id == productId,
            );

            if (existsProduct) {
              failedSnackBar("Product already added", context);
            } else {
              _cart.add(product.copyWith(quantity: 1));
              notifyListeners();
              successSnackBar("Added to Cart", context);
              isSuccess = true;
            }
          },
        );
        return isSuccess;
      }
    } catch (e) {
      if (context.mounted) {
        showHttpError(context: context, error: e);
      }
    }
    return false;
  }

  Future<bool> deleteFromCart({
    required BuildContext context,
    required String userId,
    required String productId,
    required ProductModel product,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('$deleteFromCartRoute/$productId'),
        headers: headers,
      );

      if (context.mounted) {
        bool isSuccess = false;
        httpErroHandling(
          context: context,
          response: response,
          onSuccess: () {
            _cart.removeWhere((item) => item.id == productId);
            notifyListeners();
            isSuccess = true;
          },
        );
        return isSuccess;
      }
    } catch (e) {
      if (context.mounted) {
        showHttpError(context: context, error: e);
      }
    }
    return false;
  }

  Future<List<ProductModel>> filterProduct({required String query}) async {
    _filterProducts =
        _cart
            .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
    notifyListeners();
    return _filterProducts;
  }

  void productIncrement({required String productId, required int stock}) {
    int index = _cart.indexWhere((item) => item.id == productId);
    if (index == -1) {
      if (_cart[index].quantity < stock) {
        _cart[index] = _cart[index].copyWith(
          quantity: _cart[index].quantity + 1,
        );
      }
      return;
    }
  }

  void decrementProduct({required String productId}) {
    int index = _cart.indexWhere((item) => item.id == productId);
    if (index == -1) {
      return;
    } else {
      _cart[index] = _cart[index].copyWith(quantity: _cart[index].quantity - 1);
      notifyListeners();
    }
  }
}
