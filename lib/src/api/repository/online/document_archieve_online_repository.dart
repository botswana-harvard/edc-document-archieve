import 'package:dio/dio.dart';
import 'package:edc_document_archieve/src/api/repository/online/base_online_repository.dart';

class DocumentArchieveOnLineRepository extends BaseOnlineRepository {
  Future<Map<String, dynamic>?> getProjects() async {
    String projectsUrl = baseUrl + 'projects/';
    Response response = await postRequest(projectsUrl);
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }
}
