import 'package:flutter/material.dart';
import 'package:grocery_shop/screens/bottom%20nav%20bar/bottom_navi_bar.dart';
import 'package:grocery_shop/screens/login%20screen/login_page.dart';
import 'package:grocery_shop/util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    moveToOtherPage();
  }

  void moveToOtherPage() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    if (token == null) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    } else {
      if (mounted) {
        moveToNextPageWithReplace(context, const BottomNaviBar());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Splash Screen")));
  }
}
