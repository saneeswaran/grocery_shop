import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../provider/login_provider.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../login screen/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);

    void moveToNextPage() {
      provider.registerUser(
        context: context,
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            spacing: size.height * 0.02, // giving space between widgets
            crossAxisAlignment: CrossAxisAlignment.start, //make alignment left
            children: [
              SizedBox(height: size.height * 0.15),
              Text(
                "Sign up",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.015),
              //fields
              CustomTextformField(
                controller: usernameController,
                labelText: "name",
              ),
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
                    onPressed: moveToNextPage,
                    text: "SIGN UP",
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
                child: const LoginPage(),
              ),
            );
          },
          child: Text(
            "Already have an accouont?",
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
