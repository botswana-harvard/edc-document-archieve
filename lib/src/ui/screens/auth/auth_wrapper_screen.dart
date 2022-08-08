import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/services/bloc/authentication_bloc.dart';
import 'package:edc_document_archieve/src/ui/screens/base/base_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

class AuthWrapperScreen extends StatelessWidget {
  const AuthWrapperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String token = Injector.resolve<AuthenticationBloc>().lastAccountLoggedIn();
    if (token.isEmpty) {
      return const WelcomeScreen();
    }
    return BaseScreen();
  }
}
