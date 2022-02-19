import 'package:dio/dio.dart';

/// Authentication repository class
abstract class AuthRepository {
  /// This method takes 2 argument (email and password) and returns void
  Future<Response<Map<String, dynamic>>> login({
    required String email,
    required String password,
  });

  /// This method takes 1 argument (email) and returns void
  Future<Response<Map<String, dynamic>>> verifyEmail({
    required String email,
  });

  /// This method takes 1 argument (new password) and returns void
  Future<Response<Map<String, dynamic>>> resetPassword({
    required String newPassword,
  });
}
