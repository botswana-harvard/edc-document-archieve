import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:edc_document_archieve/src/api/repository/online/base_online_repository.dart';
import 'package:edc_document_archieve/src/config/index.dart';
import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/core/models/user_account.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
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
    List<Response<dynamic>?> responses = await Future.wait([
      _onlineRepository.login(BaseOnlineRepository.flourishUrl,
          username: username, password: password),
      _onlineRepository.login(BaseOnlineRepository.tdUrl,
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
      await _offlineRepository.userAccountsBox.put(username, userAccount);
      await _offlineRepository.addLastUserAccountLoggedIn(userAccount.username);
      await _offlineRepository.addToken(userAccount.token);
      await saveDataLocalStorage();
      return AuthenticationStatus.authenticated;
    }
  }

  Future<AuthenticationStatus> authenticateOffline(
      {required String username, required String password}) async {
    await _offlineRepository.login(username: username, password: password);
    return _offlineRepository.authStatus;
  }

  Future<void> saveDataLocalStorage() async {
    String tdUrl = BaseOnlineRepository.tdUrl;
    String flourishUrl = BaseOnlineRepository.flourishUrl;

    List<dynamic> response = await Future.wait([
      _onlineRepository.getProjects(flourishUrl, study: kFlourish),
      _onlineRepository.getProjects(tdUrl, study: kTshiloDikotla)
    ]);
    //get flourish data from flourish edc
    saveProjectDataLocalStorage(data: response[0], project: kFlourish);
    saveProjectDataLocalStorage(data: response[1], project: kTshiloDikotla);

    //save projects to loval storage
    await _offlineRepository.appStorageBox
        .put(kProjects, [kFlourish, kTshiloDikotla]);
  }

  saveProjectDataLocalStorage({
    required String project,
    required Map<String, dynamic> data,
  }) async {
    if (data.isNotEmpty) {
      if (data.isNotEmpty) {
        Map<String, dynamic> pids = data['pids'];
        await _offlineRepository.appStorageBox.put('${project}_pids', pids);
        Map<String, dynamic> careGiverForms = data['caregiver_forms'];
        await _offlineRepository.appStorageBox
            .put('${project}_caregiver_forms', careGiverForms);
        Map<String, dynamic> childForms = data['child_forms'];
        await _offlineRepository.appStorageBox
            .put('${project}_child_forms', childForms);
      }
    }
  }
}
