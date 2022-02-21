import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:edc_document_archieve/src/api/repository/offline/local_storage_repository.dart';
import 'package:edc_document_archieve/src/core/models/user_account.dart';
import 'package:edc_document_archieve/src/providers/authentication_provider.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';
import 'package:edc_document_archieve/src/utils/enums.dart';

class AuthenticationOfflineRepository extends LocalStorageRepository
    implements AuthenticationProvider {
  AuthenticationOfflineRepository() {
    _authStatus = AuthenticationStatus.unknown;
  }

  late AuthenticationStatus _authStatus;
  Hash hasher = md5;

  @override
  AuthenticationStatus get authStatus => _authStatus;

  @override
  set authStatus(AuthenticationStatus status) => _authStatus = status;

  @override
  Future<void> logOut() async {
    //Get the last user logged in
    await userAccountsBox.delete(kLastUserLoggedIn);
    //Change auth status to un authenticated
    authStatus = AuthenticationStatus.unauthenticated;
  }

  @override
  Future<void> login({required String email, required String password}) async {
    //Get user from Hive database
    UserAccount? user = userAccountsBox.get(email);
    List<int> bytes = utf8.encode(password);

    //encrypt the input password and compare with the users password
    Digest hashedPassword = hasher.convert(bytes);

    //check if the user exists in Hive database, if exists verify password
    if (user != null && user.password == password) {
      await userAccountsBox.put(kLastUserLoggedIn, user.email);
      authStatus = AuthenticationStatus.authenticated;
      logger.wtf('Authenticated...');
    } else {
      authStatus = AuthenticationStatus.unauthenticated;
      logger.wtf('UnAuthenticated...');
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
  UserAccount? lastUserAccountLoggedIn() {
    //Get last logged in user from Hive database
    String email = userAccountsBox.get(kLastUserLoggedIn);
    UserAccount? user = userAccountsBox.get(email);
    return user;
  }
}
