import 'package:flutter/material.dart';

class BHPLogo extends StatelessWidget {
  final double height;
  final double width;

  const BHPLogo({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height / 4,
        width: width / 2,
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
