import 'package:flutter/material.dart';

import '../constant/assets.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  final bool login;
  final void Function()? press;
  const AlreadyHaveAnAccount({
    super.key,
    this.login = true,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "Don't have an account ? " : "Already have an account ? ",
          style: const TextStyle(color: kPrimmaryColorLight),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: const TextStyle(
                color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
