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
      final crfDoc = crfs.firstWhere((form) => crf == form);
      crfs.remove(crfDoc);
      // ignore: empty_catches
    } on StateError catch (e) {}
    crfs.add(crf);
    await appStorageBox.delete(key);
    await appStorageBox.put(key, crfs);
  }

  @override
  Future<void> addParticipantNonCrfForm({
    required ParticipantNonCrf nonCrf,
  }) async {
    //Key to retrieve our docs
    String key = '${nonCrf.pid}_non_crfs';
    //get all participant's non crfs
    List<ParticipantNonCrf> nonCrfs = appStorageBox.get(key,
        defaultValue: <ParticipantNonCrf>[]).cast<ParticipantNonCrf>();
    try {
      //Get existing participant non crf form
      ParticipantNonCrf filteredForm =
          nonCrfs.firstWhere((form) => nonCrf == form);
      //remove it from list of non crfs
      nonCrfs.remove(filteredForm);
    } on StateError catch (e) {
      logger.e(e);
    }
    nonCrfs.add(nonCrf);
    await appStorageBox.delete(key);
    await appStorageBox.put(key, nonCrfs);
  }

  @override
  Future<void> addParticipantIdentifier({
    required String studyName,
    required String pid,
    required String type,
  }) async {
    //Get keys
    String pidsKey = '${studyName}_pids';
    List<String> caregiverPids = [];
    List<String> childPids = [];
    Map<String, dynamic> pids =
        appStorageBox.get(pidsKey, defaultValue: {}).cast<String, dynamic>();
    if (pids.isNotEmpty) {
      caregiverPids = pids[kCaregiverPid].cast<String>();
      childPids = pids[kChildPid].cast<String>();
    }

    switch (type) {
      case kCaregiverPid:
        if (!caregiverPids.contains(pid)) {
          caregiverPids.add(pid);
        } else if (childPids.isEmpty) {
          caregiverPids = [pid];
        }
        break;
      case kChildPid:
        if (!childPids.contains(pid)) {
          childPids.add(pid);
        } else if (childPids.isEmpty) {
          childPids = [pid];
        }
        break;
      default:
    }
    Map<String, dynamic> data = {
      kCaregiverPid: caregiverPids,
      kChildPid: childPids
    };

    await appStorageBox.delete(pidsKey);
    await appStorageBox.put(pidsKey, data);
  }

  @override
  Future<Map<String, dynamic>> getAllParticipants(String studyName) async {
    String pidsKey = '${studyName}_pids';
    List<String> caregiverPids = [];
    List<String> childPids = [];
    Map<String, dynamic> pids =
        appStorageBox.get(pidsKey, defaultValue: {}).cast<String, dynamic>();
    if (pids.isNotEmpty) {
      caregiverPids = pids[kCaregiverPid].cast<String>();
      childPids = pids[kChildPid].cast<String>();
    }

    Map<String, dynamic> data = {
      kCaregiverPid: caregiverPids,
      kChildPid: childPids
    };
    return data;
  }

  @override
  Future<List<String>> getAllStudies() async {
    return appStorageBox
        .get(kProjects, defaultValue: <String>[]).cast<String>();
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

  @override
  Future<List<ParticipantCrf>> deleteParticipantCrfForm(
      {required ParticipantCrf crf}) async {
    //Key to retrieve our docs
    String key = '${crf.pid}_crfs';
    //get all participant's non crfs
    List<ParticipantCrf> allCrfs = appStorageBox
        .get(key, defaultValue: <ParticipantCrf>[]).cast<ParticipantCrf>();

    //remove the crf from list of crfs
    allCrfs.remove(crf);

    // delete old list and add new updated list
    await appStorageBox.delete(key);
    await appStorageBox.put(key, allCrfs);

    return allCrfs;
  }

  @override
  Future<void> deleteParticipantNonCrfForm(
      {required ParticipantNonCrf nonCrf}) async {
    //Key to retrieve our docs
    String key = '${nonCrf.pid}_non_crfs';

    //get all participant's non crfs
    List<ParticipantNonCrf> allNonCrfs = appStorageBox.get(key,
        defaultValue: <ParticipantNonCrf>[]).cast<ParticipantNonCrf>();

    //remove the non crf from list of non crfs
    allNonCrfs.remove(nonCrf);

    // delete old list and add new updated list
    await appStorageBox.delete(key);
    await appStorageBox.put(key, allNonCrfs);
  }

  @override
  Future<List<StudyDocument>> getChildForms(String studyName) async {
    String formKey = '${studyName}_$kChildForms';
    List<StudyDocument> documents = await getForms(
      formKey: formKey,
      pidType: kChildPid,
    );
    return documents;
  }

  @override
  Future<List<StudyDocument>> getCaregiverForms(String studyName) async {
    String formKey = '${studyName}_$kCaregiverForms';
    List<StudyDocument> documents = await getForms(
      formKey: formKey,
      pidType: kCaregiverPid,
    );
    return documents;
  }

  Future<List<StudyDocument>> getForms({
    required String formKey,
    required String pidType,
  }) async {
    List<String> crfs = [];
    List<String> nonCrfs = [];
    List<StudyDocument> documents = [];
    Map<String, dynamic> caregiverForms = appStorageBox.get(
      formKey,
      defaultValue: {},
    ).cast<String, dynamic>();

    if (caregiverForms.isNotEmpty) {
      crfs = caregiverForms['${kCrfForm}s'].cast<String>();
      nonCrfs = caregiverForms['${kNonCrfForm}s'].cast<String>();
      for (String crf in crfs) {
        documents.add(StudyDocument.fromJson({
          'name': crf,
          'type': kCrfForm,
          'pidType': pidType,
        }));
      }

      for (String nonCrf in nonCrfs) {
        documents.add(StudyDocument.fromJson({
          'name': nonCrf,
          'type': kNonCrfForm,
          'pidType': pidType,
        }));
      }
    }
    return documents;
  }
}
