import 'package:edc_document_archieve/src/api/repository/offline/local_storage_repository.dart';
import 'package:edc_document_archieve/src/providers/document_archieve_provider.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';

class DocumentArchieveOffLineRepository extends LocalStorageRepository
    implements DocumentArchieveProvider {
  @override
  Future<void> addParticipantCrfForm(String studyName) {
    throw UnimplementedError();
  }

  @override
  Future<void> addParticipantIdentifier({
    required String studyName,
    required String pid,
  }) async {
    //Get keys
    String key = '${studyName}_pids';
    List<String>? pids = appStorageBox.get(key);
    if (pids != null && !pids.contains(pid)) {
      pids.add(pid);
    } else if (pids == null || pids.isEmpty) {
      pids = [pid];
    }
    await appStorageBox.delete(key);
    await appStorageBox.put(key, pids);
  }

  @override
  Future<void> addParticipantNonCrfForm(String studyName) {
    // TODO: implement addParticipantNonCrfForm
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getAllForms(String studyName) async {
    String key = '${studyName}_forms';
    List<String>? forms = appStorageBox.get(key);
    if (forms != null && forms.isNotEmpty) {
      return forms;
    }
    return [];
  }

  @override
  Future<List<String>> getAllParticipants(String studyName) async {
    String key = '${studyName}_pids';
    List<String>? participants = appStorageBox.get(key);
    if (participants != null && participants.isNotEmpty) {
      return participants;
    }
    return [];
  }

  @override
  Future<List<String>> getAllStudies() async {
    List<String>? studies = appStorageBox.get(kStudies);
    if (studies != null && studies.isNotEmpty) {
      return studies;
    }
    return [];
  }

  @override
  Future<List<String>> getAllTimePoints(String studyName) {
    // TODO: implement getAllTimePoints
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getAllVisits(String studyName) {
    // TODO: implement getAllVisits
    throw UnimplementedError();
  }
}
