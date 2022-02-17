import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Function()? onTap;

  const CustomTextWidget({
    Key? key,
    required this.text,
    this.onTap,
    this.fontSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.grey[800],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
