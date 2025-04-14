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
    _cartProducts.add(product);
    notifyListeners();
  }

  void removeProductFromCart(int id) {
    _cartProducts.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  // favorite
  void addToFavorite(Product product) {
    _favoriteProducts.add(product);
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
