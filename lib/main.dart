import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/provider/login_provider.dart';
import 'package:grocery_shop/provider/product_provider.dart';
import 'package:grocery_shop/screens/splash%20screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'grocery shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: mainColor),
      home: SplashScreen(),
    );
  }
}
