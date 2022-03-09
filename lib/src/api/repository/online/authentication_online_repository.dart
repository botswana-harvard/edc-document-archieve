import 'dart:async';

import 'package:dio/dio.dart';
import 'package:edc_document_archieve/src/api/repository/online/base_online_repository.dart';

class AuthenticationOnlineRepository extends BaseOnlineRepository {
  Future<Response> login(loginUrl,
      {required String username, required String password}) async {
    Map<String, dynamic> params = {'username': username, 'password': password};
    loginUrl += 'api-token-auth/';
    Response response = await postRequest(loginUrl, data: params);
    return response;
  }

  Future<Map<String, dynamic>> getProjects(String url) async {
    url += 'projects/';
    Response response = await getRequest(url);
    if (response.statusCode == 200) {
      return response.data;
    }
    return {};
  }
}
