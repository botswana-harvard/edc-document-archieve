import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/custom_regex_pattern.dart';
import 'package:flutter/foundation.dart';
import 'package:recase/recase.dart';

part 'auth_validator.dart';

String? emailRegexValidator(String? email) {
  RegExp regexEmail = RegExp(patternEmail);
  if (email != null && regexEmail.hasMatch(email.trim())) {
    return null;
  }
  return kInvalidEmailError.titleCase;
}
