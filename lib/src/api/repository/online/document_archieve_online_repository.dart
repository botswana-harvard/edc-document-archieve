import 'package:dio/dio.dart';
import 'package:edc_document_archieve/src/api/repository/online/base_online_repository.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';

class DocumentArchieveOnLineRepository extends BaseOnlineRepository {
  Future<Map<String, dynamic>> getProjects(String url,
      {required String study}) async {
    url += 'projects/';
    Map<String, dynamic> data = {'study': study};
    Response response = await getRequest(url, queryParameters: data);
    if (response.statusCode == 200) {
      logger.w(response.data);
      return response.data;
    }
    return <String, dynamic>{};
  }

  Future<Response> pushDataToServer({required url, dynamic data}) async {
    return await postRequest(url, data: data);
  }
}
