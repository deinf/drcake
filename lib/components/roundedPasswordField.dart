import 'package:drcake/components/textFielContainer.dart';
import 'package:flutter/material.dart';

import '../constant/assets.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  const RoundedPasswordField({
    super.key,
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        obscureText: true,
        decoration: const InputDecoration(
            hintText: "Password",
            icon: Icon(
              Icons.lock,
              color: kIconColor,
            ),
            // suffixIcon: Icon(
            //   Icons.visibility,
            //   color: kIconColor,
            // ),
            border: InputBorder.none),
      ),
    );
  }
}
