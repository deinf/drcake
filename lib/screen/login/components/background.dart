import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/assets.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            right: 0,
            width: size.width * 0.3,
            child: Image.asset(Assets.mainTop),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                Assets.bottomLeftMain,
                width: size.width * 0.2,
              )),
          child,
          Positioned(
              top: 60,
              left: 30,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ))
        ],
      ),
    );
  }
}
