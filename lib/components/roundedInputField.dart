import 'package:drcake/components/textFielContainer.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String? hinText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final Color? iconColor;
  final TextEditingController controller;

  const RoundedInputField({
    super.key,
    this.hinText,
    this.icon,
    this.onChanged,
    this.iconColor,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: iconColor,
            ),
            hintText: hinText,
            border: InputBorder.none),
      ),
    );
  }
}
