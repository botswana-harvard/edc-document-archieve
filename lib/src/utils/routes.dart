import 'package:edc_document_archieve/src/ui/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  LoginScreen.routeName: (_) => const LoginScreen(),
};
