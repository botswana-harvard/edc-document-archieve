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
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> _formKey;
  late AuthenticationBloc _authenticationBloc;
  late FocusNode _usernameFocusNode;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _authenticationBloc = Injector.resolve<AuthenticationBloc>();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      bloc: _authenticationBloc,
      // buildWhen: (AuthenticationState previous, AuthenticationState current) {
      //   if (previous != current) return true;
      //   return false;
      // },
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
                    // autovalidateMode: AutovalidateMode.always,
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
                          labelText: kUsername.titleCase,
                          controller: usernameController,
                          focusNode: _usernameFocusNode,
                        ),
                        Container(margin: const EdgeInsets.only(top: 20)),
                        CustomTextField(
                          labelText: kPassword.titleCase,
                          obscure: true,
                          controller: passwordController,
                          focusNode: _passwordFocusNode,
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
        switch (state.status) {
          case AuthenticationStatus.loading:
            Dialogs.showLoadingDialog(context, message: 'Logging in...');
            break;
          case AuthenticationStatus.authenticated:
            Get.toNamed(kBaseRoute);
            break;
          case AuthenticationStatus.unauthenticated:
            Dialogs.closeLoadingDialog(context);
            Get.showSnackbar(GetSnackBar(
              title: 'Authentication Error',
              message: state.error!,
              duration: const Duration(seconds: 2),
            ));
            break;
          default:
            Dialogs.closeLoadingDialog(context);
        }
      },
    );
  }

  Future<void> onButtonLoginTapped() async {
    //unfocus keyboard when clicking login button
    _usernameFocusNode.unfocus();
    _passwordFocusNode.unfocus();

    //check if the input values are not none
    if (_formKey.currentState!.validate()) {
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();
      _authenticationBloc.add(
        AuthenticationLoginSubmitted(
          username: username,
          password: password,
        ),
      );
    }
  }

  void onForgotPasswordTapped() {
    /// TODO:
  }
}
