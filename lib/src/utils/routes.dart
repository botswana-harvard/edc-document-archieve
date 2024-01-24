import 'package:edc_document_archieve/src/ui/screens/auth/auth_wrapper_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/auth/login_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/base/base_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/forms/create_crf_form_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/forms/create_non_crf_form_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/forms/crf_forms_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/forms/non_crf_forms_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/pids/pids_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/pids/sub_screens/sent_item_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/welcome/welcome_screen.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> pages = [
  GetPage(name: kLoginRoute, page: () => const LoginScreen()),
  GetPage(name: kBaseRoute, page: () => BaseScreen()),
  GetPage(name: kPidsRoute, page: () => const PidsScreen()),
  GetPage(name: kCrfformRoute, page: () => const CRFormScreen()),
  GetPage(name: kNonCrfformRoute, page: () => const NonCRFormScreen()),
  GetPage(name: kWelcomeRoute, page: () => const WelcomeScreen()),
  GetPage(name: kAuthWrapperRoute, page: () => const AuthWrapperScreen()),
  GetPage(name: kCreateCRFormRoute, page: () => const CreateCRFormScreen()),
  GetPage(
      name: kCreateNonCRFormRoute, page: () => const CreateNonCRFormScreen()),
  GetPage(name: kSentItemsRoute, page: () => SentItemScreen()),
];
