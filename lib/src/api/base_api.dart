import 'package:dio/dio.dart';
import 'package:edc_document_archieve/src/api/interceptor/api_interceptor.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';
import 'package:flutter/material.dart';

abstract class BaseAPI {
  late Dio _dio;

  ///
  final String baseUrl = kBaseUrl;

  ///

  BaseAPI() {
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
    required Map<String, dynamic> headers,
  }) async {
    late Response response;

    try {
      // set  for requests with custom headers
      Options _options = Options(headers: headers);
      response = await _dio.get(
        path,
        options: _options,
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
    required Map<String, dynamic> data,
    required Map<String, dynamic> headers,
    required String contentType,
    // bool setFormUrlEncodedContentType = false,
  }) async {
    late Response response;
    try {
      // set  for requests with custom headers
      Options _options = Options(
        validateStatus: (status) {
          return status! < 500;
        },
        headers: headers,
      );

      response = await _dio.post(
        path,
        data: data,
        options: _options..contentType = contentType,
      );

      /// this is out here because of [validateStatus < 500]
      return response;
    } on DioError catch (error) {
      // logger.e(error.message);
      logger.w("${error.message} \n${error.requestOptions.uri}");

      return response;
    }
  }
}
