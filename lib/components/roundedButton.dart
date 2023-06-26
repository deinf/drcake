import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final double width;
  final void Function() press;
  final Color color, textColor;
  const RoundedButton({
    this.width = 0.0,
    super.key,
    required this.text,
    this.color = Colors.blue,
    required this.press,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: TextButton(
            style: TextButton.styleFrom(
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.zero),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                backgroundColor: color),
            onPressed: press,
            child: Text(
              text,
              style: TextStyle(color: textColor),
            )),
      ),
    );
  }
}
