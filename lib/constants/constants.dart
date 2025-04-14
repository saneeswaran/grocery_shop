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
  BoxShadow(offset: Offset(-1, 1), color: Colors.grey.shade400, blurRadius: 3),
  BoxShadow(offset: Offset(1, -1), color: Colors.grey.shade400, blurRadius: 3),
];

//Color
const Color mainColor = Color.fromRGBO(1, 102, 73, 1);

//icons
const String googleSvgIcon = "assets/svg/google.svg";

//api url

const String mainUrl = "http://192.168.56.1:3000";

//api routes
const String loginRoute = "$mainUrl/user/login";
const String registerRoute = "$mainUrl/user/register";
const String productsRoute = "$mainUrl/products";
const String verifyTokenRoute = "$mainUrl/user/verify-token";

//header
Map<String, String> headers = {
  'Content-Type': 'application/json; charset=UTF-8',
};
