import 'package:dio/src/response.dart';
import 'package:edc_document_archieve/src/api/base_api.dart';
import 'package:edc_document_archieve/src/api/repository/auth_repository.dart';

class AuthAPI extends BaseAPI implements AuthRepository {
  @override
  Future<Response<Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Response<Map<String, dynamic>>> resetPassword({
    required String newPassword,
  }) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Response<Map<String, dynamic>>> verifyEmail({
    required String email,
  }) {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }
}
