import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:edc_document_archieve/src/api/repository/online/base_online_repository.dart';
import 'package:edc_document_archieve/src/api/wrapper/base_storage_wrapper.dart';
import 'package:edc_document_archieve/src/config/index.dart';
import 'package:edc_document_archieve/src/core/models/user_account.dart';
import 'package:edc_document_archieve/src/utils/enums.dart';

class AuthenticationWrapper extends BaseStorageWrapper
    implements AuthenticationProvider {
  AuthenticationWrapper() {
    _authStatus = AuthenticationStatus.unknown;
  }

  late AuthenticationStatus _authStatus;
  late Map<String, dynamic> data;
  final Hash hasher = md5;

  @override
  late String error;

  @override
  AuthenticationStatus get authStatus => _authStatus;

  @override
  set authStatus(AuthenticationStatus status) => _authStatus = status;

  @override
  Future<void> logOut() async {
    await offlineAuthRepository.logOut();
  }

  @override
  Future<void> login(
      {required String username, required String password}) async {
    //if check offLine login
    authStatus =
        await authenticateOffline(password: password, username: username);
    //if login failed check onLine
    if (authStatus != AuthenticationStatus.authenticated) {
      authStatus =
          await authenticateOnline(password: password, username: username);
    }
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

  @override
  String lastUserAccountLoggedIn() {
    return offlineAuthRepository.lastUserAccountLoggedIn();
  }

  Future<AuthenticationStatus> authenticateOnline(
      {required String username, required String password}) async {
    List<Response<dynamic>?> responses = await Future.wait([
      onlineAuthRepository.login(BaseOnlineRepository.flourishUrl,
          username: username, password: password),
      onlineAuthRepository.login(BaseOnlineRepository.tdUrl,
          username: username, password: password)
    ]);

    Response? response = responses.firstWhere(
        (response) => response?.statusCode == 200,
        orElse: () => null);

    if (response == null) {
      error = 'Unable to Login with provided Credentials';
      return AuthenticationStatus.unauthenticated;
    } else {
      //lets encrypt the input password and compare with the users password
      List<int> bytes = utf8.encode(password);
      Digest hashedPassword = hasher.convert(bytes);
      //
      Map<String, dynamic> results = response.data;
      results['password'] = hashedPassword.toString();
      UserAccount userAccount = UserAccount.fromJson(results);
      //
      await offlineAuthRepository.userAccountsBox.put(username, userAccount);
      await offlineAuthRepository
          .addLastUserAccountLoggedIn(userAccount.username);
      await offlineAuthRepository.addToken(userAccount.token);
      await saveDataLocalStorage();
      return AuthenticationStatus.authenticated;
    }
  }

  Future<AuthenticationStatus> authenticateOffline(
      {required String username, required String password}) async {
    await offlineAuthRepository.login(username: username, password: password);
    return offlineAuthRepository.authStatus;
  }
}
