import 'package:edc_document_archieve/gen/fonts.gen.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';
import 'package:edc_document_archieve/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscure;
  final TextInputType keyboardType;
  final double margin;
  late TextEditingController controller;

  CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.margin = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: EdgeInsets.symmetric(horizontal: margin),
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: kLightGreyColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: TextFormField(
          obscureText: obscure,
          controller: controller,
          validator: (value) {
            switch (labelText.toLowerCase()) {
              case kEmail:
                return AuthValidator.emailValidator(
                  label: labelText,
                  value: value,
                );
              case kPassword:
                return AuthValidator.passwordValidator(
                  label: labelText,
                  value: value,
                );
              default:
                logger.e(labelText.titleCase);
                if (value == null || value.isEmpty) {
                  return 'This filed is required';
                }
                return null;
            }
          },
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: labelText,
            labelStyle: const TextStyle(
              fontFamily: FontFamily.robotoSlab,
            ),
          ),
        ),
      ),
    );
  }
}
