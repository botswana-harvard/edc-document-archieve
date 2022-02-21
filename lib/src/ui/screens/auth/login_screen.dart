import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/services/bloc/authentication_bloc.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text_field.dart';
import 'package:edc_document_archieve/src/ui/widgets/default_button.dart';
import 'package:edc_document_archieve/src/ui/widgets/logo.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';
import 'package:edc_document_archieve/src/utils/dialogs.dart';
import 'package:edc_document_archieve/src/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
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
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _authenticationBloc = Injector.resolve<AuthenticationBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      bloc: _authenticationBloc,
      buildWhen: (AuthenticationState previous, AuthenticationState current) {
        if (previous != current) return true;
        return false;
      },
      builder: (BuildContext context, AuthenticationState state) {
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
      listener: (BuildContext context, AuthenticationState state) {
        Dialogs.closeLoadingDialog(context);
        switch (state.status) {
          case AuthenticationStatus.loading:
            Dialogs.showLoadingDialog(context, message: 'Logging in...');
            break;
          case AuthenticationStatus.authenticated:
            Get.offAndToNamed(kBaseRoute);
            break;
          case AuthenticationStatus.unauthenticated:
            Get.showSnackbar(const GetSnackBar(
              title: 'Error',
            ));
            break;
          default:
        }
      },
    );
  }

  Future<void> onButtonLoginTapped() async {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      _authenticationBloc.add(
        AuthenticationLoginSubmitted(
          email: email,
          password: password,
        ),
      );
    }
  }

  void onForgotPasswordTapped() {
    /// TODO:
  }
}
