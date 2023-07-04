import 'package:flutter/material.dart';

import '../../../constant/assets.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(alignment: Alignment.center, children: [
        Positioned(
          top: 0,
          right: 0,
          width: size.width * 0.3,
          child: Image.asset(
            Assets.mainTop,
            color: kColorTop,
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              Assets.mainBottom,
              width: size.width * 0.2,
              color: kColorBottom,
            )),
        child
      ]),
    );
  }
}
