import 'package:dio/dio.dart';
import 'package:edc_document_archieve/src/api/repository/online/interceptor/api_interceptor.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as Foundation;

abstract class BaseOnlineRepository {
  late Dio _dio;

  static const String flourishUrl = Foundation.kReleaseMode
      ? 'https://flourish.bhp.org.bw/edc_da_api/'
      : 'http://flourish-dev.bhp.org.bw/edc_da_api/';

  static const String tdUrl = Foundation.kReleaseMode
      ? 'https://td-live.bhp.org.bw/edc_da_api/'
      : 'https://td-test.bhp.org.bw/edc_da_api/';

  BaseOnlineRepository() {
    /// dio base settings
    BaseOptions options = BaseOptions(
      receiveTimeout: 60000,
      connectTimeout: 60000,
    );

    _dio = Dio(options);
    _dio.interceptors.add(ApiInterceptor());
  }

  ///
  @protected
  Future<Response> getRequest(
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    late Response response;

    try {
      // set  for requests with custom headers
      Options _options = Options(headers: headers);
      response = await _dio.get(
        path,
        options: _options,
        queryParameters: queryParameters,
      );

      return response;
    } on DioError catch (error) {
      // logger.w(error.message);
      logger.w("${error.message} \n${error.requestOptions.uri}");

      return response;
    }
  }

  ///
  @protected
  Future<Response> postRequest(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    String? contentType,
    // bool setFormUrlEncodedContentType = false,
  }) async {
    late Response? response;
    Options _options = Options(
      validateStatus: (status) {
        return status! < 500;
      },
      headers: headers,
    );
    try {
      // set for requests with custom headers

      response = await _dio.post(
        path,
        data: data,
      );

      /// this is out here because of [validateStatus < 500]
      return response;
    } on DioError catch (error) {
      // logger.e(error.message);
      logger.w("${error.message} \n${error.response?.realUri}");

      return Response(
          statusMessage: error.message,
          statusCode: error.response?.statusCode,
          requestOptions: error.requestOptions);
    }
  }
}
