import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edc_document_archieve/src/api/repository/offline/app_storage_repository.dart';
import 'package:edc_document_archieve/src/api/repository/offline/local_storage_repository.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';

const String _loginUrl = '';

const String _postNameUrl = '';

final List<String> customCookieUrls = [
  _loginUrl,
  _postNameUrl,
];

class ApiInterceptor extends Interceptor {
  final AppStorageRepository _localStorageService = AppStorageRepository();

  String userAgent =
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0";

  ApiInterceptor() {
    setUserAgent();
  }

  Future<void> setUserAgent() async {
    try {
      // userAgent = await FlutterUserAgent.getPropertyAsync('userAgent');
    } catch (e) {}
  }

  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // set user agent
      options.headers["User-Agent"] = userAgent;

      String url = options.uri.toString();
    } catch (e) {
      /// todo: non fatal error on registration
      logger.e(e);
    }

    // return options;
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    try {
      // the url that requested this response
      String requestUrl = response.requestOptions.uri.toString();

      // save cookies
      if (requestUrl == _loginUrl) {
        String responseCookies = jsonEncode(response.headers["set-cookie"]);
        _localStorageService.setCookies(responseCookies);
      }
    } catch (e) {
      logger.e(e);
    }

    // return response;
    return super.onResponse(response, handler);
  }
}
