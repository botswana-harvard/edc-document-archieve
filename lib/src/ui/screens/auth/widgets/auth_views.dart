import 'package:edc_document_archieve/src/ui/widgets/logo.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/constants/gradients.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class AuthViews extends StatefulWidget {
  const AuthViews({Key? key}) : super(key: key);

  @override
  _AuthViewsState createState() => _AuthViewsState();
}

class _AuthViewsState extends State<AuthViews> {
  @override
  Widget build(BuildContext context) => body(context);

  Widget body(context) {
    return LayoutBuilder(
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
                messageTextComponent(),
                Container(margin: const EdgeInsets.only(top: 35)),
                textFieldComponent(type: "email", hintText: "Email Address"),
                Container(margin: const EdgeInsets.only(top: 20)),
                textFieldComponent(
                  type: "password",
                  hintText: "Password",
                  obscure: true,
                ),
                Container(margin: const EdgeInsets.only(top: 10)),
                continueButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget continueButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(left: 30, right: 30),
        width: double.infinity,
        height: 50,
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
            kLogin.titleCase,
            style: const TextStyle(
              color: WHITE_COLOR,
              fontSize: 18,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }

  Widget messageTextComponent() {
    return Text(
      'Log in to continue',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        color: Colors.grey[700],
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget textFieldComponent(
      {required String hintText, required String type, bool obscure = false}) {
    return Container(
      height: 55,
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
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}

Widget gradientTextComponent(Gradient gradient, String text,
    {double size = 48,
    FontWeight weight = FontWeight.w300,
    TextAlign align = TextAlign.center}) {
  const rect = Rect.fromLTWH(0.0, 0.0, 200.0, 70.0);
  final Shader linearGradient = gradient.createShader(rect);

  return Text(
    text,
    textAlign: align,
    style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        foreground: Paint()..shader = linearGradient),
  );
}
