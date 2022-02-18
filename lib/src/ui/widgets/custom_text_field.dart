import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscure;
  final TextInputType keyboardType;
  final EdgeInsets margin;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.margin = const EdgeInsets.only(left: 30, right: 30),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: margin,
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: kLightGreyColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: TextField(
          obscureText: obscure,
          onChanged: (value) => {},
          keyboardType: keyboardType,
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: labelText,
              labelStyle: const TextStyle(
                fontFamily: 'RobotoSlab',
              )),
        ),
      ),
    );
  }
}
