import 'package:drcake/constant/assets.dart';
import 'package:drcake/components/roundedButton.dart';
import 'package:drcake/controllers/loginController.dart';
import 'package:drcake/screen/login/components/background.dart';
import 'package:drcake/screen/signUp/signUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/alreadyHaveAnAccount.dart';
import '../../../components/roundedInputField.dart';
import '../../../components/roundedPasswordField.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  LoginController loginController = Get.put(LoginController());

  bool pengecekanUsername = false;
  bool pengecekanLogin = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Image.asset(
              Assets.loginImage,
              scale: 6,
              fit: BoxFit.none,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedInputField(
              controller: loginController.usernameController,
              icon: Icons.person,
              iconColor: kIconColor,
              hinText: "Email/Username",
              onChanged: (value) {
                if (value == "") {
                  pengecekanUsername = true;
                } else {
                  pengecekanUsername = false;
                }
                setState(() {});
              },
            ),
            pengecekanUsername == false
                ? Container()
                : const Text(
                    "Username harus diisi!",
                    style: TextStyle(color: kPrimaryColor, fontSize: 12),
                  ),
            RoundedPasswordField(
              controller: loginController.passwordController,
              onChanged: (value) {
                if (value == "") {
                  pengecekanLogin = true;
                } else {
                  pengecekanLogin = false;
                }
                setState(() {});
              },
            ),
            pengecekanLogin == false
                ? Container()
                : const Text(
                    "Pasword harus diisi!",
                    style: TextStyle(color: kPrimaryColor, fontSize: 12),
                  ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                if (loginController.usernameController.text.trim() == "") {
                } else if (loginController.passwordController.text == "") {
                } else {
                  loginController.getDataUser();
                }
              },
              color: kPrimaryColor,
              width: size.width * 0.8,
              textColor: Colors.white,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            AlreadyHaveAnAccount(
              press: () {
                Get.off(const SignUpScreen(),
                    transition: Transition.rightToLeft);
              },
            )
          ],
        ),
      ),
    );
  }
}
