import 'package:edc_document_archieve/src/ui/screens/auth/login_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/base/base_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/forms/crf_forms_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/forms/non_crf_forms_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/pids/pids_screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  LoginScreen.routeName: (_) => const LoginScreen(),
  BaseScreen.routeName: (_) => const BaseScreen(),
  PidsScreen.routeName: (_) => const PidsScreen(),
  CRFormScreen.routeName: (_) => const CRFormScreen(),
  NonCRFormScreen.routeName: (_) => const NonCRFormScreen(),
};
