import 'package:edc_document_archieve/src/ui/widgets/custom_text.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text_field.dart';
import 'package:edc_document_archieve/src/ui/widgets/default_button.dart';
import 'package:edc_document_archieve/src/ui/widgets/logo.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recase/recase.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = kLoginRoute;

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double parentHeight = constraints.maxHeight;
          double parentWidth = constraints.maxWidth;
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(margin: const EdgeInsets.only(top: 35)),
                  BHPLogo(
                    height: parentHeight,
                    width: parentWidth,
                  ),
                  Container(margin: const EdgeInsets.only(top: 35)),
                  const CustomText(
                    text: 'Log in to continue',
                  ),
                  Container(margin: const EdgeInsets.only(top: 35)),
                  CustomTextField(
                    labelText: kEmail.titleCase,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Container(margin: const EdgeInsets.only(top: 20)),
                  CustomTextField(
                    labelText: kPassword.titleCase,
                    obscure: true,
                  ),
                  Container(margin: const EdgeInsets.only(top: 20)),
                  CustomText(
                    text: 'Forgot password? Click here to reset',
                    fontSize: 16,
                    onTap: onForgotPasswordTapped,
                  ),
                  Container(margin: const EdgeInsets.only(top: 30)),
                  DefaultButton(
                    buttonName: kLogin,
                    onTap: onButtonLoginTapped,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void onButtonLoginTapped() {
    /// TODO:
    Get.offAndToNamed(kBaseRoute);
  }

  void onForgotPasswordTapped() {
    /// TODO:
  }
}
