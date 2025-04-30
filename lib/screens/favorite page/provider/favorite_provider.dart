import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:grocery_shop/util/util.dart';
import 'package:grocery_shop/widgets/custom_snack_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  List<ProductModel> _favorite = [];
  List<ProductModel> _filterFavorite = [];
  bool _isShowSearchBar = false;
  bool get isShowSearchBar => _isShowSearchBar;
  List<ProductModel> get favorite => _favorite;
  List<ProductModel> get filterFavorite => _filterFavorite;

  Future<List<ProductModel>> fetchSpecificUserFavoriteProduct({
    required BuildContext context,
  }) async {
    final pref = await SharedPreferences.getInstance();
    final userId = pref.getString('userId');
    try {
      final response = await http.get(
        Uri.parse('$getSpecificUserFavoriteRoute/$userId'),
        headers: headers,
      );

      if (context.mounted) {
        httpErrorHandling(
          context: context,
          response: response,
          onSuccess: () {
            final List<dynamic> decoded = jsonDecode(response.body);
            _favorite =
                decoded.map((json) {
                  final productData = json['productId'];
                  return ProductModel.fromMap(productData);
                }).toList();
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
    required String productId,
    required ProductModel product,
  }) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final userId = pref.getString('userId');
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
    required String productId,
  }) async {
    final pref = await SharedPreferences.getInstance();
    final userId = pref.getString('userId');
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

  bool showSearchBar() {
    _isShowSearchBar = !_isShowSearchBar;
    notifyListeners();
    return isShowSearchBar;
  }

  bool removeSearchBar() {
    _isShowSearchBar = false;
    notifyListeners();
    return _isShowSearchBar;
  }
}
