import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:grocery_shop/util/util.dart';
import 'package:grocery_shop/widgets/custom_snack_bar.dart';
import 'package:http/http.dart' as http;

class FavoriteProvider extends ChangeNotifier {
  List<ProductModel> _favorite = [];
  List<ProductModel> _filterFavorite = [];
  List<ProductModel> get favorite => _favorite;
  List<ProductModel> get filterFavorite => _filterFavorite;

  Future<List<ProductModel>> fetchAllFavoriteProduct({
    required BuildContext context,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(fetchFavoriteProductRoute),
        headers: headers,
      );
      if (context.mounted) {
        httpErrorHandling(
          context: context,
          response: response,
          onSuccess: () {
            final List<dynamic> decoded = jsonDecode(response.body);
            _favorite =
                decoded.map((json) => ProductModel.fromMap(json)).toList();
            _filterFavorite = _favorite;
            notifyListeners();
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showHttpError(context: context, e: e);
      }
    }
    return _favorite;
  }

  Future<bool> addToFavorite({
    required BuildContext context,
    required String userId,
    required String productId,
    required ProductModel product,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(addToFavouriteInDatabaseRoute),
        headers: headers,
        body: jsonEncode({'userId': userId, 'productId': productId}),
      );

      if (context.mounted) {
        httpErrorHandling(
          context: context,
          response: response,
          onSuccess: () {
            _favorite.add(product);
            _filterFavorite = _favorite;
            successSnackBar("Product added successfullt", context);
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

  Future<bool> deleteProductFromFavorites({
    required BuildContext context,
    required String userId,
    required String productId,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse(deleteFromFavouritesRoute),
        headers: headers,
        body: jsonEncode({'userId': userId, 'productId': productId}),
      );
      if (context.mounted) {
        httpErrorHandling(
          context: context,
          response: response,
          onSuccess: () {
            _favorite.removeWhere((item) => item.id == productId);
            _filterFavorite = _favorite;
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

  Future<List<ProductModel>> filterFavoriteProduct({
    required String query,
  }) async {
    _filterFavorite =
        _favorite
            .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
    return _filterFavorite;
  }
}
