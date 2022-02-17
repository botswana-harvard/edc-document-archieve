import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String textType;
  final bool obscure;
  final TextInputType keyboardType;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.textType,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(left: 30, right: 30),
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: LIGHT_GREY_COLOR,
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
