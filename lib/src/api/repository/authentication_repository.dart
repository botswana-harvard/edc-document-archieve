import 'dart:async';

import 'package:dio/dio.dart';
import 'package:edc_document_archieve/src/api/repository/online/base_repository.dart';
import 'package:edc_document_archieve/src/providers/authentication_provider.dart';
import 'package:edc_document_archieve/src/utils/enums.dart';

class AuthenticationRepository extends BaseRepository
    implements AuthenticationProvider {
  @override
  AuthenticationStatus authStatus = AuthenticationStatus.unknown;

  @override
  void logOut() {
    authStatus = AuthenticationStatus.unauthenticated;
  }

  @override
  Future<void> login({required String email, required String password}) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => authStatus = AuthenticationStatus.authenticated,
    );
  }

  @override
  Future<void> resetPassword({required String newPassword}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<void> verifyEmail({required String email}) {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }
}
