import 'package:flutter/material.dart';

class BHPLogo extends StatelessWidget {
  final double parentHeight;
  final double parentWidth;

  const BHPLogo({
    Key? key,
    required this.parentHeight,
    required this.parentWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: parentHeight / 3.5,
        width: parentWidth / 2,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
