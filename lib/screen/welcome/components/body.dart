import 'package:drcake/constant/assets.dart';
import 'package:drcake/screen/login/loginScreen.dart';
import 'package:drcake/screen/signUp/signUpScreen.dart';
import 'package:drcake/screen/welcome/components/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/roundedButton.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "DR CAKE",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: kPrimaryColor),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Image.asset(
              Assets.mainBg,
              scale: 6,
              fit: BoxFit.none,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedButton(
              width: size.width * 0.8,
              press: () {
                Get.to(const LoginScreen(),
                    // duration: Duration(seconds: 1),
                    transition: Transition.rightToLeft);
              },
              color: kPrimaryColor,
              text: "LOGIN",
            ),
            SizedBox(
              width: size.width * .8,
              child: const Row(children: <Widget>[
                Expanded(child: Divider()),
                Text("OR"),
                Expanded(child: Divider()),
              ]),
            ),
            RoundedButton(
              width: size.width * 0.8,
              press: () {
                Get.to(const SignUpScreen(),
                    // duration: Duration(seconds: 1),
                    transition: Transition.rightToLeft);
              },
              color: kPrimmaryColorLight,
              text: "SIGNUP",
            ),
          ],
        ),
      ),
    );
  }
}
