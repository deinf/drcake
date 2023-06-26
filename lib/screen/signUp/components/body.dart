import 'package:drcake/controllers/registrationController.dart';
import 'package:drcake/screen/login/loginScreen.dart';
import 'package:drcake/screen/signUp/components/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/alreadyHaveAnAccount.dart';
import '../../../components/roundedButton.dart';
import '../../../components/roundedInputField.dart';
import '../../../components/roundedPasswordField.dart';
import '../../../constant/assets.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  RegistrationController registrationController =
      Get.put(RegistrationController());

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
              "Sign Up",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Image.asset(
              Assets.signUpImage,
              scale: 2,
              fit: BoxFit.none,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedInputField(
              controller: registrationController.usernameController,
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
                : Text(
                    "Username harus diisi!",
                    style: TextStyle(color: kPrimaryColor, fontSize: 12),
                  ),
            RoundedPasswordField(
              controller: registrationController.passwordController,
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
                : Text(
                    "Pasword harus diisi!",
                    style: TextStyle(color: kPrimaryColor, fontSize: 12),
                  ),
            RoundedButton(
              text: "SIGN UP",
              press: () {
                if (registrationController.passwordController.text == "") {
                  pengecekanLogin = true;
                  setState(() {});
                } else if (registrationController.usernameController.text ==
                    "") {
                  pengecekanUsername = true;
                  setState(() {});
                } else {
                  pengecekanLogin = false;
                  pengecekanUsername = false;
                  setState(() {});
                  registrationController.registerUser();
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
              login: false,
              press: () {
                Get.off(const LoginScreen(),
                    transition: Transition.rightToLeft);
              },
            )
          ],
        ),
      ),
    );
  }
}
