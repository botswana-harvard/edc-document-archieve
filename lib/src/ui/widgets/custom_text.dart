import 'package:edc_document_archieve/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Function()? onTap;
  final Color? color;
  final FontWeight fontWeight;

  const CustomText({
    Key? key,
    required this.text,
    this.onTap,
    this.fontSize = 20,
    this.color,
    this.fontWeight = FontWeight.w500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: fontSize,
          color: color ?? Colors.grey[800],
          fontWeight: fontWeight,
          fontFamily: FontFamily.robotoSlab,
        ),
      ),
    );
  }
}
