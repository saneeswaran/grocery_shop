import 'package:flutter/material.dart';

List<Color> color = [Colors.green, Colors.red, Colors.yellow, Colors.orange];
List<Widget> carouselItems = List.generate(
  4,
  (index) => Container(
    decoration: BoxDecoration(
      color: color[index],
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

List<BoxShadow> categoryContainerShadow = [
  BoxShadow(
    offset: const Offset(-1, 1),
    color: Colors.grey.shade500,
    blurRadius: 3,
  ),
  BoxShadow(
    offset: const Offset(1, -1),
    color: Colors.grey.shade500,
    blurRadius: 3,
  ),
];
List<BoxShadow> dailyNeedsProductShadow = [
  BoxShadow(
    offset: const Offset(-1, 1),
    color: Colors.grey.shade300,
    blurRadius: 3,
    blurStyle: BlurStyle.outer,
  ),
  BoxShadow(
    offset: const Offset(1, -1),
    color: Colors.grey.shade300,
    blurRadius: 3,
    blurStyle: BlurStyle.outer,
  ),
];

//Color
const Color mainColor = Color.fromRGBO(1, 102, 73, 1);

//icons
const String googleSvgIcon = "assets/svg/google.svg";

//api url

const String mainUrl = "http://192.168.56.1:3000";

//currency
const String indianCurrency = '₹';

//api routes
const String loginRoute = "$mainUrl/user/login";
const String registerRoute = "$mainUrl/user/register";
const String productsRoute = "$mainUrl/products";
const String verifyTokenRoute = "$mainUrl/user/verify-token";

//products
const String getAllProductRoute = '$mainUrl/product/get-all-products';
const String getAllProductByCategoryRoute =
    '$mainUrl/product/get-products-by-category';
const String getProductsBySubcategoryRoute =
    '$mainUrl/product/get-products-by-subcategory';
//category routes
const String getAllCategoryRoute = '$mainUrl/category/get-all-categories';
const String getCategoryByIdRoute = '$mainUrl/category/get-by-id';

//subcategory routes
const String getAllSubCategoryRoute = '$mainUrl/subcategory/getAllSubcategory';
const String getAllSubCategoryProductRoute =
    '$mainUrl/subcategory/get-all-sub-categories-product';
const String getSubcategryByCategoryIdRoute =
    '$mainUrl/subcategory/get-sub-category-by-id';

//favorite
const String addToFavouriteInDatabaseRoute =
    '$mainUrl/favorite/add-to-favorite';
const String deleteFromFavouritesRoute =
    '$mainUrl/favorite/delete-from-favorite';
const String fetchFavoriteProductRoute = '$mainUrl/favorite/get-favorite';
const String getSpecificUserFavoriteRoute =
    '$mainUrl/favorite/get-user-favorite';

//cart
const String getCartProductRoute = '$mainUrl/cart/get-cart-product';
const String addToCartRoute = '$mainUrl/cart/add-to-cart';
const String deleteFromCartRoute = '$mainUrl/cart/delete-from-cart';
const String getUserCartProductRoute = '$mainUrl/cart/get-user-cart-product';

//header
Map<String, String> headers = {'Content-Type': 'application/json'};

//shadow

const List<BoxShadow> boxShadow = [
  BoxShadow(
    color: Colors.grey,
    offset: Offset(0.0, 1.0), //(x,y)
    blurRadius: 3.0,
  ),
];
