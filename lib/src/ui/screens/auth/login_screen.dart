import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/services/auth_service.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text_field.dart';
import 'package:edc_document_archieve/src/ui/widgets/default_button.dart';
import 'package:edc_document_archieve/src/ui/widgets/logo.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';
import 'package:edc_document_archieve/src/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = kLoginRoute;

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> _formKey;
  late AuthService _authService;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthService>(
      create: (context) => Injector.resolve<AuthService>(),
      child: Consumer<AuthService>(
        builder: (context, authService, child) {
          _authService = authService;
          return Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) {
                double parentHeight = constraints.maxHeight;
                double parentWidth = constraints.maxWidth;
                return Container(
                  color: Colors.white,
                  height: parentHeight,
                  width: parentWidth,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(margin: const EdgeInsets.only(top: 35)),
                          BHPLogo(
                            parentHeight: parentHeight,
                            parentWidth: parentWidth,
                          ),
                          Container(margin: const EdgeInsets.only(top: 15)),
                          const CustomText(
                            text: 'Log in to continue',
                            fontWeight: FontWeight.bold,
                          ),
                          Container(margin: const EdgeInsets.only(top: 35)),
                          CustomTextField(
                            labelText: kEmail.titleCase,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                          ),
                          Container(margin: const EdgeInsets.only(top: 20)),
                          CustomTextField(
                            labelText: kPassword.titleCase,
                            obscure: true,
                            controller: passwordController,
                          ),
                          Container(margin: const EdgeInsets.only(top: 20)),
                          CustomText(
                            text: 'Forgot password? Click here to reset',
                            fontSize: 16,
                            onTap: onForgotPasswordTapped,
                            color: kDarkRed,
                          ),
                          Container(margin: const EdgeInsets.only(top: 30)),
                          DefaultButton(
                            buttonName: kLogin,
                            onTap: onButtonLoginTapped,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> onButtonLoginTapped() async {
    if (_formKey.currentState!.validate()) {
      Dialogs.showLoadingDialog(context, message: 'Logging in...');
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      logger.e('email = $email and password = $password');
      await _authService.login(email: email, password: password);
      if (!_authService.isLoading) {
        Dialogs.closeLoadingDialog(context);
      }
      Get.offAndToNamed(kBaseRoute);
    }
  }

  void onForgotPasswordTapped() {
    /// TODO:
  }
}
