import 'package:edc_document_archieve/src/core/models/user_account.dart';
import 'package:edc_document_archieve/src/utils/enums.dart';

abstract class AuthenticationProvider {
  //This variable holds the authntication status of the user
  AuthenticationStatus get authStatus;

  set authStatus(AuthenticationStatus status);

  /// This method takes 2 argument (email and password) and returns void
  Future<void> login({required String email, required String password});

  /// This method takes 1 argument (email) and returns void
  Future<void> verifyEmail({required String email});

  /// This method takes 1 argument (new password) and returns void
  Future<void> resetPassword({required String newPassword});

  //This method clears out cookies and tokens used to authenticate user
  void logOut();

  //Get the last user logged in
  UserAccount? lastUserAccountLoggedIn();
}
