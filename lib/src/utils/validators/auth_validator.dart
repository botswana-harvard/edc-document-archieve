part of 'validator.dart';

class AuthValidator {
  static String? validator({required String label, String? value}) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return '$label is required'.titleCase;
    }
    return null;
  }

  static String? emailValidator({required String label, String? value}) {
    String? isEmpty = validator(label: label, value: value);
    if (isEmpty != null) return isEmpty;
    return emailRegexValidator(value);
  }

  static String? passwordValidator({required String label, String? value}) {
    String? isEmpty = validator(label: label, value: value);
    if (isEmpty != null) return isEmpty;
    if (value != null && value.length < 8) {
      return kShortPassError.titleCase;
    } else {
      return null;
    }
  }

  static String? confirmPasswordValidator({
    required String label,
    required String password,
    required String confirmPassword,
  }) {
    String? isEmpty = validator(label: label, value: confirmPassword);
    if (isEmpty != null) return isEmpty;
    if (confirmPassword.length < 8) {
      return kShortPassError;
    } else if (password != confirmPassword) {
      if (kDebugMode) {
        print(' password is $password and confirmPassword is $confirmPassword');
      }
      return kMatchPassError.titleCase;
    } else {
      return null;
    }
  }
}
