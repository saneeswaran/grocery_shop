import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_shop/screens/bottom%20nav%20bar/bottom_navi_bar.dart';
import 'package:grocery_shop/screens/register%20screen/provider/register_provider.dart';
import 'package:grocery_shop/util/util.dart';
import 'package:grocery_shop/widgets/custom_snack_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/constants.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../register screen/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  void loginUser() async {
    final provider = Provider.of<RegisterProvider>(context, listen: false);
    bool isSuccess = await provider.loginUser(
      context: context,
      email: emailController.text,
      password: passwordController.text,
    );
    if (mounted) {
      if (isSuccess) {
        moveToNextPageWithReplace(context, const BottomNaviBar());
      } else {
        if (context.mounted) {
          failedSnackBar("Invalid email or password", context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            spacing: size.height * 0.03, // giving space between widgets
            crossAxisAlignment: CrossAxisAlignment.start, //make alignment left
            children: [
              SizedBox(height: size.height * 0.15),
              const Text(
                "Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.015),
              //fields
              CustomTextformField(
                controller: emailController,
                labelText: "Email",
              ),
              CustomTextformField(
                controller: passwordController,
                labelText: "Password",
              ),
              _alreadyHaveAnAccount(context),
              Center(
                child: SizedBox(
                  height: size.height * 0.07,
                  width: size.width * 0.7,
                  child: CustomElevatedButton(
                    onPressed: loginUser,
                    text: "LOGIN",
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.07),
              const Center(
                child: Text(
                  "Or login with social account",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              signInWithSocialMethods(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget _alreadyHaveAnAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, //make alignment righ
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 600),
                child: const RegisterPage(),
              ),
            );
          },
          child: const Text(
            "Create an account",
            style: TextStyle(color: Colors.black),
          ),
        ),
        const Icon(Icons.arrow_forward_sharp, color: Colors.red),
      ],
    );
  }

  Widget signInWithSocialMethods(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _socialMethodContainer(
            size,
            SvgPicture.asset(
              googleSvgIcon,
              height: 5,
              width: 5,
              fit: BoxFit.scaleDown,
            ),
          ),
          _socialMethodContainer(
            size,
            const Icon(Icons.facebook, color: Colors.blue, size: 30),
          ),
        ],
      ),
    );
  }

  Widget _socialMethodContainer(Size size, Widget iconWidget) {
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: iconWidget,
    );
  }
}
