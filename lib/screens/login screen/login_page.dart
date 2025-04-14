import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_shop/provider/login_provider.dart';
import 'package:grocery_shop/widgets/custom_snack_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../home page/drawer_page.dart';
import '../home page/home_page.dart';
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
  @override
  Widget build(BuildContext context) {
    void moveToNextPage() async {
      final provider = Provider.of<LoginProvider>(context, listen: false);
      final isLogin = await provider.loginUser(
        context: context,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (isLogin) {
        successSnackBar("Login Success", context);
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 500),
            child: const DrawerPage(body: HomePage()),
          ),
        );
      } else {
        failedSnackBar("Login Failed", context);
      }
    }

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
              Text(
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
                    onPressed: () {
                      moveToNextPage();
                    },
                    text: "LOGIN",
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.07),
              Center(
                child: const Text(
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
          child: Text(
            "Create an account",
            style: TextStyle(color: Colors.black),
          ),
        ),
        Icon(Icons.arrow_forward_sharp, color: Colors.red),
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
            Icon(Icons.facebook, color: Colors.blue, size: 30),
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
