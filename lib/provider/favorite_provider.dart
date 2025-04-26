import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/http%20error%20handling/http_error_handling.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:grocery_shop/widgets/custom_snack_bar.dart';
import 'package:http/http.dart' as http;

class FavoriteProvider extends ChangeNotifier {
  List<ProductModel> _favoriteProduct = [];
  List<ProductModel> _filterProducts = [];

  List<ProductModel> get favoriteProduct => _favoriteProduct;
  List<ProductModel> get filterProducts => _filterProducts;

  Future<bool> addToFavoriteInDatabase({
    required BuildContext context,
    required String userId,
    required String productId,
    required ProductModel product,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$addToFavouriteInDatabaseRoute/$productId'),
        headers: headers,
        body: jsonEncode({'userId': userId, 'productId': productId}),
      );

      if (context.mounted) {
        bool isSuccess = false;
        httpErroHandling(
          context: context,
          response: response,
          onSuccess: () {
            if (context.mounted) {
              final bool isExists = _favoriteProduct.any(
                (product) => product.id == productId,
              );
              if (isExists) {
                failedSnackBar("Already added to favorite", context);
              } else {
                _favoriteProduct.add(product);
                notifyListeners();
                isSuccess = true;
                successSnackBar("Added to Favorite", context);
              }
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

  Future<bool> removeFromFavoruteInDatabase({
    required String id,
    required BuildContext context,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('$deleteFromFavouritesRoute/$id'),
        headers: headers,
      );

      if (context.mounted) {
        httpErroHandling(
          context: context,
          response: response,
          onSuccess: () {
            if (context.mounted) {
              successSnackBar("Removed from Favorite", context);
              _favoriteProduct.removeWhere((item) => item.id == id);
              notifyListeners();
            }
          },
        );
      }
      return true;
    } catch (e) {
      if (context.mounted) {
        showHttpError(context: context, error: e);
      }
    }
    return false;
  }

  Future<List<ProductModel>> fetchAllFavoriteProduct({
    required BuildContext context,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(fetchFavoriteProductRoute),
        headers: headers,
      );
      if (context.mounted) {
        httpErroHandling(
          context: context,
          response: response,
          onSuccess: () {
            List<dynamic> decoded = jsonDecode(response.body);
            _favoriteProduct =
                decoded.map((json) => ProductModel.fromMap(json)).toList();
            _filterProducts = _favoriteProduct;
            notifyListeners();
            successSnackBar("Favorite Product Fetched", context);
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showHttpError(context: context, error: e);
      }
    }
    return _favoriteProduct;
  }

  Future<List<ProductModel>> searchFavoriteProduct({
    required String query,
  }) async {
    _filterProducts =
        _favoriteProduct
            .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
    notifyListeners();
    return _filterProducts;
  }
}
