import 'package:edc_document_archieve/src/api/repository/offline/local_storage_repository.dart';
import 'package:edc_document_archieve/src/core/models/participant_crf.dart';
import 'package:edc_document_archieve/src/core/models/participant_non_crf.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:edc_document_archieve/src/providers/document_archieve_provider.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';

class DocumentArchieveOffLineRepository extends LocalStorageRepository
    implements DocumentArchieveProvider {
  @override
  Future<void> addParticipantCrfForm({
    required ParticipantCrf crf,
  }) async {
    String key = '${crf.pid}_crfs';
    List<ParticipantCrf> crfs = appStorageBox
        .get(key, defaultValue: <ParticipantCrf>[]).cast<ParticipantCrf>();
    try {
      final _ = crfs.firstWhere((form) => crf == form);
    } on StateError catch (e) {
      logger.e(e);
      crfs.add(crf);
    }
    await appStorageBox.delete(key);
    await appStorageBox.put(key, crfs);
  }

  @override
  Future<void> addParticipantNonCrfForm({
    required ParticipantNonCrf nonCrf,
  }) async {
    String key = '${nonCrf.pid}_non_crfs';
    List<ParticipantNonCrf> allNonCrfs = appStorageBox.get(key,
        defaultValue: <ParticipantNonCrf>[]).cast<ParticipantNonCrf>();
    try {
      ParticipantNonCrf filteredForm =
          allNonCrfs.firstWhere((form) => nonCrf == form);
      allNonCrfs.remove(filteredForm);
      filteredForm.uploads.addAll(nonCrf.uploads);
      allNonCrfs.add(filteredForm);
    } on StateError catch (e) {
      logger.e(e);
    }
    await appStorageBox.delete(key);
    await appStorageBox.put(key, allNonCrfs);
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
  Future<List<StudyDocument>> getAllForms(String studyName) async {
    String key = '${studyName}_forms';
    return appStorageBox
        .get(key, defaultValue: <StudyDocument>[]).cast<StudyDocument>();
  }

  @override
  Future<List<String>> getAllParticipants(String studyName) async {
    String key = '${studyName}_pids';
    return appStorageBox.get(key, defaultValue: <String>[]).cast<String>();
  }

  @override
  Future<List<String>> getAllStudies() async {
    // List<String> studies = ['Flourish', 'Tshilo Dikotla'];
    // await appStorageBox.put(kStudies, studies);
    return appStorageBox.get(kStudies, defaultValue: <String>[]).cast<String>();
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

  @override
  Future<List<ParticipantCrf>> getCrForms({required String pid}) async {
    String key = '${pid}_crfs';
    return appStorageBox
        .get(key, defaultValue: <ParticipantCrf>[]).cast<ParticipantCrf>();
  }

  @override
  Future<List<ParticipantNonCrf>> getNonCrForms({required String pid}) async {
    String key = '${pid}_non_crfs';
    return appStorageBox.get(key,
        defaultValue: <ParticipantNonCrf>[]).cast<ParticipantNonCrf>();
  }
}
