import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/gradients.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class DefaultButton extends StatelessWidget {
  final String buttonName;
  final Function() onTap;

  const DefaultButton({
    Key? key,
    required this.buttonName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 30, right: 30),
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          gradient: BLUE_GRADIENT,
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              blurRadius: 24,
              color: BLUE_SHADOW,
              offset: Offset(0, 16),
            )
          ],
        ),
        child: Center(
          child: Text(
            buttonName.titleCase,
            style: const TextStyle(
              color: WHITE_COLOR,
              fontSize: 20,
              fontFamily: 'RobotoSlab',
            ),
          ),
        ),
      ),
    );
  }
}
