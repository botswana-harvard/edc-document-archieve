import 'package:edc_document_archieve/src/ui/screens/auth/auth_wrapper_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/auth/login_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/base/base_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/forms/create_crf_form_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/forms/create_non_crf_form_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/forms/crf_forms_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/forms/non_crf_forms_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/pids/pids_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/welcome/welcome_screen.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> pages = [
  GetPage(name: LoginScreen.routeName, page: () => const LoginScreen()),
  GetPage(name: BaseScreen.routeName, page: () => BaseScreen()),
  GetPage(name: PidsScreen.routeName, page: () => PidsScreen()),
  GetPage(name: CRFormScreen.routeName, page: () => const CRFormScreen()),
  GetPage(name: NonCRFormScreen.routeName, page: () => const NonCRFormScreen()),
  GetPage(name: WelcomeScreen.routeName, page: () => const WelcomeScreen()),
  GetPage(name: AuthWrapperScreen.routeName, page: () => AuthWrapperScreen()),
  GetPage(
    name: CreateCRFormScreen.routeName,
    page: () => const CreateCRFormScreen(),
  ),
  GetPage(
    name: CreateNonCRFormScreen.routeName,
    page: () => const CreateNonCRFormScreen(),
  ),
];
