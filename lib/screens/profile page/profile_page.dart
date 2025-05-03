import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/screens/login%20screen/login_page.dart';
import 'package:grocery_shop/screens/profile%20page/components/update_profile.dart';
import 'package:grocery_shop/screens/profile%20page/provider/profile_provider.dart';
import 'package:grocery_shop/util/util.dart';
import 'package:grocery_shop/widgets/custom_elevated_button.dart';
import 'package:grocery_shop/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).getUser();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    final user = provider.user;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: size.height * 0.02,
        children: [
          Container(
            height: size.height * 0.40,
            width: size.width * 1,
            decoration: const BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Center(
              child: Container(
                height: size.height * 0.2,
                width: size.width * 0.5,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      "https://organicmandya.com/cdn/shop/files/Apples_bf998dd2-0ee8-4880-9726-0723c6fbcff3.jpg?v=1721368465&width=1000",
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(size.height * 0.02),
            child: Column(
              spacing: size.height * 0.02,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Details",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  user.username,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: size.height * 0.10),
                SizedBox(
                  height: size.height * 0.07,
                  width: size.width * 0.9,
                  child: CustomElevatedButton(
                    onPressed: () {
                      moveToPage(
                        context,
                        UpdateProfile(
                          username: user.username,
                          email: user.email,
                        ),
                      );
                    },
                    text: "Edit Profile",
                  ),
                ),
                SizedBox(
                  height: size.height * 0.07,
                  width: size.width * 0.9,
                  child: CustomElevatedButton(
                    onPressed: () async {
                      final pref = await SharedPreferences.getInstance();
                      final bool isSuccess = await pref.remove('token');
                      if (context.mounted) {
                        if (isSuccess) {
                          moveToNextPageWithReplace(context, const LoginPage());
                        } else {
                          failedSnackBar("Logout Failed", context);
                        }
                      }
                    },
                    text: "LogOut",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
