import 'package:flutter/material.dart';
import 'package:grocery_shop/screens/favorite%20page/favorite_page.dart';
import 'package:grocery_shop/screens/profile%20page/profile_page.dart';
import 'package:grocery_shop/screens/shopping%20bag/shopping_bag.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../home page/home_page.dart';

class BottomNaviBar extends StatefulWidget {
  const BottomNaviBar({super.key});

  @override
  State<BottomNaviBar> createState() => _BottomNaviBarState();
}

List<String> bottomNavBarTitle = const [
  "Home",
  "Shop",
  "Bag",
  "Favourite",
  "Profile",
];
List<Widget> bottomNavBarPages = [
  const HomePage(),
  const FavoritePage(),
  const ShoppingBag(),
  const FavoritePage(),
  const ProfilePage(),
];
List<Icon> bottomNavBaricons = const [
  Icon(Icons.home),
  Icon(Icons.shopping_cart),
  Icon(Icons.shopping_bag),
  Icon(Icons.favorite),
  Icon(Icons.person),
];

class _BottomNaviBarState extends State<BottomNaviBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: PersistentTabView(
          tabs: List.generate(
            bottomNavBarPages.length,
            (index) => PersistentTabConfig(
              screen: bottomNavBarPages[index],
              item: ItemConfig(
                icon: bottomNavBaricons[index],
                title: bottomNavBarTitle[index],
                activeForegroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          navBarBuilder:
              (navBarConfig) => Style1BottomNavBar(navBarConfig: navBarConfig),
        ),
      ),
    );
  }
}
