import 'package:edc_document_archieve/src/api/repository/online/base_online_repository.dart';
import 'package:edc_document_archieve/src/config/index.dart';
import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';

class BaseStorageWrapper {
  BaseStorageWrapper() {
    offlineAuthRepository = Injector.resolve<AuthenticationOfflineRepository>();
    onlineAuthRepository = Injector.resolve<AuthenticationOnlineRepository>();
    archieveOnLineRepository =
        Injector.resolve<DocumentArchieveOnLineRepository>();
    archieveOffLineRepository =
        Injector.resolve<DocumentArchieveOffLineRepository>();
  }

  late AuthenticationOfflineRepository offlineAuthRepository;
  late AuthenticationOnlineRepository onlineAuthRepository;
  late DocumentArchieveOnLineRepository archieveOnLineRepository;
  late DocumentArchieveOffLineRepository archieveOffLineRepository;

  saveProjectDataLocalStorage({
    required String project,
    required Map<String, dynamic> data,
  }) async {
    if (data.isNotEmpty) {
      if (data.isNotEmpty) {
        Map<String, dynamic> pids = data['pids'];
        await offlineAuthRepository.appStorageBox.delete('${project}_pids');
        await offlineAuthRepository.appStorageBox.put('${project}_pids', pids);
        Map<String, dynamic> careGiverForms = data['caregiver_forms'];
        await offlineAuthRepository.appStorageBox
            .delete('${project}_caregiver_forms');
        await offlineAuthRepository.appStorageBox
            .put('${project}_caregiver_forms', careGiverForms);
        Map<String, dynamic> childForms = data['child_forms'];
        await offlineAuthRepository.appStorageBox
            .delete('${project}_child_forms');
        await offlineAuthRepository.appStorageBox
            .put('${project}_child_forms', childForms);
      }
    }
  }

  Future<void> saveDataLocalStorage() async {
    String tdUrl = BaseOnlineRepository.tdUrl;
    String flourishUrl = BaseOnlineRepository.flourishUrl;

    List<dynamic> response = await Future.wait([
      onlineAuthRepository.getProjects(flourishUrl, study: kFlourish),
      onlineAuthRepository.getProjects(tdUrl, study: kTshiloDikotla)
    ]);
    //get flourish data from flourish edc
    saveProjectDataLocalStorage(data: response[0], project: kFlourish);
    saveProjectDataLocalStorage(data: response[1], project: kTshiloDikotla);

    //save projects to loval storage
    await offlineAuthRepository.appStorageBox
        .put(kProjects, [kFlourish, kTshiloDikotla]);
  }
}
