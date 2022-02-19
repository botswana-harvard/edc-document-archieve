import 'package:edc_document_archieve/src/ui/widgets/custom_text.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/gradients.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class DefaultButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;
  final EdgeInsets? margin;
  final double borderRadius;

  const DefaultButton({
    Key? key,
    required this.buttonName,
    required this.onTap,
    this.margin = const EdgeInsets.only(left: 30, right: 30),
    this.borderRadius = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          gradient: kBlueGradient,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: const [
            BoxShadow(
              blurRadius: 24,
              color: kBlueShadow,
              offset: Offset(0, 16),
            )
          ],
        ),
        child: Center(
          child: CustomText(
            text: buttonName.titleCase,
          ),
        ),
      ),
    );
  }
}
