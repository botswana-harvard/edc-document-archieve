import 'package:dio/dio.dart';
import 'package:edc_document_archieve/src/api/repository/online/base_online_repository.dart';

class DocumentArchieveOnLineRepository extends BaseOnlineRepository {
  Future<Map<String, dynamic>?> getProjects(String url) async {
    Response response = await postRequest(url);
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }

  Future<Response> pushDataToServer({required url, dynamic data}) async {
    return await postRequest(url, data: data);
  }
}
