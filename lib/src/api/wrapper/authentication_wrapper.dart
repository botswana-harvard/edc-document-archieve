import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:edc_document_archieve/src/config/index.dart';
import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/core/models/user_account.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';
import 'package:edc_document_archieve/src/utils/enums.dart';

class AuthenticationWrapper implements AuthenticationProvider {
  AuthenticationWrapper() {
    _offlineRepository = Injector.resolve<AuthenticationOfflineRepository>();
    _onlineRepository = Injector.resolve<AuthenticationOnlineRepository>();
    _authStatus = AuthenticationStatus.unknown;
  }

  late AuthenticationOfflineRepository _offlineRepository;
  late AuthenticationOnlineRepository _onlineRepository;
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
    await _offlineRepository.logOut();
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
    return _offlineRepository.lastUserAccountLoggedIn();
  }

  Future<AuthenticationStatus> authenticateOnline(
      {required String username, required String password}) async {
    Response response =
        await _onlineRepository.login(username: username, password: password);
    switch (response.statusCode) {
      case 200:
        //lets encrypt the input password and compare with the users password
        List<int> bytes = utf8.encode(password);
        Digest hashedPassword = hasher.convert(bytes);
        //
        Map<String, dynamic> results = response.data;
        results['password'] = hashedPassword.toString();
        UserAccount userAccount = UserAccount.fromJson(results);
        //
        await _offlineRepository.userAccountsBox.put(username, userAccount);
        await _offlineRepository.addLastUserAccountLoggedIn(userAccount.token);
        await saveDataLocalStorage();
        return AuthenticationStatus.authenticated;
      default:
        error = response.data['non_field_errors'][0];
        return AuthenticationStatus.unauthenticated;
    }
  }

  Future<AuthenticationStatus> authenticateOffline(
      {required String username, required String password}) async {
    await _offlineRepository.login(username: username, password: password);
    return _offlineRepository.authStatus;
  }

  Future<void> saveDataLocalStorage() async {
    data = await _onlineRepository.getProjects();
    logger.e(data);
    if (data.isNotEmpty) {
      data.forEach((key, value) {
        String projectName = key;
        if (value.isNotEmpty) {
          Map<String, dynamic> pids = value['pids'];
          pids.forEach((key, value) async {
            key = projectName + '_$key';
            await _offlineRepository.appStorageBox.put(key, value);
          });
          Map<String, dynamic> careGiverForms = value['caregiver_forms'];
          careGiverForms.forEach((key, value) async {
            key = projectName + '_$key';
            await _offlineRepository.appStorageBox.put(key, value);
          });
          Map<String, dynamic> childForms = value['child_forms'];
          childForms.forEach((key, value) async {
            key = projectName + '_$key';
            await _offlineRepository.appStorageBox.put(key, value);
          });
        }
      });
      await _offlineRepository.appStorageBox.put(kProjects, data.keys.toList());
    }
  }
}
