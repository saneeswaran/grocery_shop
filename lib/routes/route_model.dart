import 'package:flutter/material.dart';
import 'package:grocery_shop/screens/all%20category/all_category.dart';
import 'package:grocery_shop/screens/favorite/favorite_page.dart';
import 'package:grocery_shop/screens/home%20page/drawer_page.dart';
import 'package:grocery_shop/screens/home%20page/home_page.dart';
import 'package:grocery_shop/screens/my%20orders/my_orders_page.dart';
import 'package:grocery_shop/screens/track%20order/track_order_page.dart';
import 'package:page_transition/page_transition.dart';

import '../screens/shopping bag/shopping_bag.dart';

class RouteModel {
  final String title;
  final IconData icon;
  final void Function(BuildContext context) onTap;

  RouteModel({required this.title, required this.icon, required this.onTap});
}

List<RouteModel> pages = [
  RouteModel(
    title: "Home",
    icon: Icons.home,
    onTap: (BuildContext context) {
      _moveToNextPage(context: context, route: HomePage());
    },
  ),
  RouteModel(
    title: "All Categories",
    icon: Icons.category,
    onTap: (BuildContext context) {
      _moveToNextPage(context: context, route: AllCategory());
    },
  ),
  RouteModel(
    title: "Shopping Bag",
    icon: Icons.shopping_bag,
    onTap: (BuildContext context) {
      _moveToNextPage(context: context, route: ShoppingBag());
    },
  ),
  RouteModel(
    title: "Favorite",
    icon: Icons.favorite,
    onTap: (BuildContext context) {
      _moveToNextPage(context: context, route: FavoritePage());
    },
  ),
  RouteModel(
    title: "My Orders",
    icon: Icons.list,
    onTap: (BuildContext context) {
      _moveToNextPage(context: context, route: MyOrdersPage());
    },
  ),
  RouteModel(
    title: "Track Order",
    icon: Icons.location_searching,
    onTap: (BuildContext context) {
      _moveToNextPage(context: context, route: TrackOrderPage());
    },
  ),
  RouteModel(
    title: "Address",
    icon: Icons.location_on,
    onTap: (BuildContext context) {
      _moveToNextPage(context: context, route: HomePage());
    },
  ),
  RouteModel(
    title: "Coupen",
    icon: Icons.crop_square_outlined,
    onTap: (BuildContext context) {
      _moveToNextPage(context: context, route: HomePage());
    },
  ),
  RouteModel(
    title: "Customer Support",
    icon: Icons.contact_support,
    onTap: (BuildContext context) {
      _moveToNextPage(context: context, route: HomePage());
    },
  ),
  RouteModel(
    title: "Settings",
    icon: Icons.settings,
    onTap: (BuildContext context) {
      _moveToNextPage(context: context, route: HomePage());
    },
  ),
  RouteModel(
    title: "Wallet",
    icon: Icons.wallet,
    onTap: (BuildContext context) {
      _moveToNextPage(context: context, route: HomePage());
    },
  ),
];

Future<Object?> _moveToNextPage({
  required BuildContext context,
  required Widget route,
}) {
  return Navigator.push(
    context,
    PageTransition(
      type: PageTransitionType.fade,
      duration: const Duration(milliseconds: 500),
      child: DrawerPage(body: route),
    ),
  );
}
