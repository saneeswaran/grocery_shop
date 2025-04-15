import 'package:flutter/material.dart';
import 'package:grocery_shop/model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = sampleProducts;
  final List<Product> _favoriteProducts = [];
  final List<Product> _cartProducts = [];

  List<Product> get products => _products;
  List<Product> get favoriteProducts => _favoriteProducts;
  List<Product> get cartproducts => _cartProducts;

  // cart
  void addProductToCart(Product product) {
    _cartProducts.add(product.copyWith(stock: 1));
    notifyListeners();
  }

  void removeProductFromCart(int id) {
    _cartProducts.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  double get totalPrice =>
      _cartProducts.fold(0, (sum, product) => sum + product.offerPrice);

  double get specificProduct {
    double total = 0;
    for (int i = 0; i < _cartProducts.length; i++) {
      total += _cartProducts[i].offerPrice;
    }
    return total;
  }

  void productIncrement(int id, int maxStock) {
    final index = _cartProducts.indexWhere((product) => product.id == id);
    if (index == -1) return;
    if (_cartProducts[index].stock < maxStock) {
      _cartProducts[index] = _cartProducts[index].copyWith(
        stock: _cartProducts[index].stock + 1,
      );
      notifyListeners();
    }
  }

  void productDecrement(int id) {
    final index = _cartProducts.indexWhere((element) => element.id == id);
    if (index == -1) return;
    if (_cartProducts[index].stock > 1) {
      _cartProducts[index] = _cartProducts[index].copyWith(
        stock: _cartProducts[index].stock - 1,
      );
      notifyListeners();
    } else {
      removeProductFromCart(id);
    }
  }

  // favorite
  void addToFavorite(Product product) {
    _favoriteProducts.add(product.copyWith(stock: 1));
    notifyListeners();
  }

  void removeFromFavorite(int id) {
    _favoriteProducts.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  bool isFavCheck(int id) {
    return _favoriteProducts.any((product) => product.id == id);
  }
}
