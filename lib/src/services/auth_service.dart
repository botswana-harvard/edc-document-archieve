import 'package:dio/dio.dart';
import 'package:edc_document_archieve/src/api/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final AuthRepository authRepository;
  late bool isLoggedIn;
  bool _isLoading = false;

  AuthService(this.authRepository);

  Future<void> login({required String email, required String password}) async {
    isLoading = true;
    Response response =
        await authRepository.login(email: email, password: password);
    switch (response.statusCode) {
      case 200:
        isLoggedIn = true;
        break;
      default:
        isLoggedIn = true;
    }
    isLoading = false;
  }

  void resetPassword({required String newPassword}) {
    // TODO: implement resetPassword
    notifyListeners();
  }

  void verifyEmail({required String email}) {
    // TODO: implement verifyEmail
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
}
