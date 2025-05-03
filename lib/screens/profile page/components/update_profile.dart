import 'package:flutter/material.dart';
import 'package:grocery_shop/screens/profile%20page/provider/profile_provider.dart';
import 'package:grocery_shop/widgets/custom_elevated_button.dart';
import 'package:grocery_shop/widgets/custom_snack_bar.dart';
import 'package:grocery_shop/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile extends StatefulWidget {
  final String username;
  final String email;
  const UpdateProfile({super.key, required this.username, required this.email});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final emailController = TextEditingController();
  final userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userNameController.text = widget.username;
    emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(size.width * 0.02),
        child: Column(
          spacing: size.height * 0.02,
          children: [
            SizedBox(height: size.height * 0.2),
            CustomTextformField(
              controller: userNameController,
              labelText: "Name",
            ),
            CustomTextformField(
              controller: emailController,
              labelText: "Email",
            ),
            SizedBox(height: size.height * 0.2),
            SizedBox(
              height: size.height * 0.07,
              width: size.width * 1,
              child: CustomElevatedButton(
                onPressed: () async {
                  final pref = await SharedPreferences.getInstance();
                  final userId = pref.getString('userId');

                  if (userId == null || userId.isEmpty) {
                    failedSnackBar("User ID not found", context);
                    return;
                  }

                  final provider = Provider.of<ProfileProvider>(
                    context,
                    listen: false,
                  );

                  final bool isSuccess = await provider.updateUser(
                    id: userId,
                    context: context,
                    username: userNameController.text,
                    email: emailController.text,
                    currentPassword: 'superman',
                  );

                  if (context.mounted) {
                    if (isSuccess) {
                      Navigator.pop(context);
                      successSnackBar("Profile updated successfully", context);
                    } else {
                      failedSnackBar("Something went wrong", context);
                    }
                  }
                },

                text: "Update Profile",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
