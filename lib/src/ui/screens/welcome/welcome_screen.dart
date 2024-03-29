import 'package:edc_document_archieve/gen/fonts.gen.dart';
import 'package:edc_document_archieve/src/ui/widgets/animated_custom_button.dart';
import 'package:edc_document_archieve/src/ui/widgets/logo.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double parentHeight = constraints.maxHeight;
        double parentWidth = constraints.maxWidth;
        return Scaffold(
          body: Container(
            margin: const EdgeInsets.only(top: 50),
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BHPLogo(
                  parentHeight: parentHeight,
                  parentWidth: parentWidth,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    kWelcome.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xff828282),
                      fontSize: 36,
                      fontFamily: FontFamily.robotoSlab,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                AnimatedCustomButton(
                  name: kContinue,
                  onTap: onContinueButtonTapped,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onContinueButtonTapped() {
    Get.toNamed(kLogin);
  }
}
