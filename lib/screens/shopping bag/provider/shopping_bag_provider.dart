import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:grocery_shop/util/util.dart';
import 'package:grocery_shop/widgets/custom_snack_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingBagProvider extends ChangeNotifier {
  List<ProductModel> _cart = [];
  List<ProductModel> _filterCart = [];
  bool _isShowSearchBar = false;
  final double _tax = 250;
  final double _discount = 100.0;
  double get subtotal => totalItemPrice + tax - discount;
  double get tax => _tax;
  double get discount => _discount;
  bool get isShowSearchBar => _isShowSearchBar;
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
    required String productId,
    required ProductModel product,
  }) async {
    final pref = await SharedPreferences.getInstance();
    final userId = pref.getString('userId');
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
            _cart.add(product.copyWith());
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
    required String productId,
  }) async {
    final pref = await SharedPreferences.getInstance();
    final userId = pref.getString('userId');
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
            successSnackBar("Product removed successfully", context);
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

  Future<List<ProductModel>> getUserCartProduct({
    required BuildContext context,
  }) async {
    final pref = await SharedPreferences.getInstance();
    final userId = pref.getString('userId');
    try {
      final response = await http.get(
        Uri.parse('$getUserCartProductRoute/$userId'),
        headers: headers,
      );

      if (context.mounted) {
        httpErrorHandling(
          context: context,
          response: response,
          onSuccess: () {
            final List<dynamic> decoded = jsonDecode(response.body);

            _cart =
                decoded.map((json) {
                  final productData = json['productId'];
                  final quantity = json['quantity'] ?? 1;
                  return ProductModel.fromMap(
                    productData,
                  ).copyWith(quantity: quantity);
                }).toList();
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

  Future<List<ProductModel>> filterCartProduct({required String query}) async {
    if (query.isEmpty) {
      _filterCart = _cart;
    } else {
      _filterCart =
          _cart
              .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
      notifyListeners();
    }
    return _filterCart;
  }

  void increaseQuantity({required String productId, required int stock}) {
    final int index = _cart.indexWhere((item) => item.id == productId);
    if (index == -1) return;

    if (_cart[index].quantity >= stock) {
      return;
    }

    _cart[index] = _cart[index].copyWith(quantity: _cart[index].quantity + 1);
    notifyListeners();
  }

  void decreaseQuantity({
    required String productId,
    required BuildContext context,
  }) {
    final int index = _cart.indexWhere((item) => item.id == productId);
    if (index == -1 || _cart[index].quantity <= 1) {
      deleteProductFromCart(context: context, productId: productId);
    }

    _cart[index] = _cart[index].copyWith(quantity: _cart[index].quantity - 1);
    notifyListeners();
  }

  double calculateTotalPrice({required String productId}) {
    double total = 0.0;
    final int index = _cart.indexWhere((item) => item.id == productId);
    if (index == -1) return total;
    total += _cart[index].price * _cart[index].quantity;
    return total;
  }

  double get totalItemPrice {
    double totalItemPrice = 0.0;
    for (var product in _cart) {
      totalItemPrice += product.quantity * product.price;
    }
    return totalItemPrice;
  }

  bool showSearchBar() {
    _isShowSearchBar = !_isShowSearchBar;
    notifyListeners();
    return _isShowSearchBar;
  }

  bool hideSearchBar() {
    _isShowSearchBar = false;
    notifyListeners();
    return _isShowSearchBar;
  }
}
