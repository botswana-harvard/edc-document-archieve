import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/core/models/user_account.dart';
import 'package:edc_document_archieve/src/services/bloc/authentication_bloc.dart';
import 'package:edc_document_archieve/src/ui/screens/base/base_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/welcome/welcome_screen.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class AuthWrapperScreen extends StatelessWidget {
  static const String routeName = kAuthWrapperRoute;

  const AuthWrapperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserAccount? lastUserAccountLoggedIn =
        Injector.resolve<AuthenticationBloc>().lastAccountLoggedIn();
    if (lastUserAccountLoggedIn == null) {
      return const WelcomeScreen();
    }
    return BaseScreen();
  }
}
