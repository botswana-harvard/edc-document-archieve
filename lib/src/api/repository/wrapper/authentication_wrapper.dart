import 'package:edc_document_archieve/src/api/repository/offline/authentication_offline_repository.dart';
import 'package:edc_document_archieve/src/api/repository/online/authentication_online_repository.dart';
import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/providers/authentication_provider.dart';
import 'package:edc_document_archieve/src/utils/enums.dart';

class AuthenticationWrapper implements AuthenticationProvider {
  late AuthenticationOfflineRepository _offlineRepository;
  late AuthenticationOnlineRepository _onlineRepository;

  AuthenticationWrapper() {
    _offlineRepository = Injector.resolve<AuthenticationOfflineRepository>();
    _onlineRepository = Injector.resolve<AuthenticationOnlineRepository>();
  }
  @override
  AuthenticationStatus get authStatus => AuthenticationStatus.unknown;

  set authStatus(AuthenticationStatus status) => authStatus = status;

  @override
  void logOut() {
    // TODO: implement logOut
  }

  @override
  Future<void> login({required String email, required String password}) async {
    await _offlineRepository.login(email: email, password: password);
    authStatus = _offlineRepository.authStatus;
    if (authStatus != AuthenticationStatus.authenticated) {
      await _onlineRepository.login(email: email, password: password);
      authStatus = _onlineRepository.authStatus;
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
}
