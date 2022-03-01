import 'package:edc_document_archieve/gen/assets.gen.dart';
import 'package:edc_document_archieve/src/api/repository/offline/local_storage_repository.dart';
import 'package:edc_document_archieve/src/core/models/participant_crf.dart';
import 'package:edc_document_archieve/src/core/models/participant_non_crf.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
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
  Future<List<StudyDocument>> getAllForms(String studyName) async {
    String key = '${studyName}_forms';
    return appStorageBox
        .get(key, defaultValue: <StudyDocument>[]).cast<StudyDocument>();
    // List<Map<String, dynamic>> listForms = [
    //   {
    //     'name': 'Lab Results',
    //     'type': 'crf',
    //   },
    //   {'name': 'Omang Forms', 'type': 'non_crf'},
    //   {'name': 'Clinician Notes', 'type': 'crf'},
    //   {'name': 'Speciment Forms', 'type': 'crf'}
    // ];
    // List<StudyDocument> studyDocs =
    //     listForms.map((json) => StudyDocument.fromJson(json)).toList();
    // await appStorageBox.put(key, studyDocs);
  }

  @override
  Future<List<String>> getAllParticipants(String studyName) async {
    String key = '${studyName}_pids';
    return appStorageBox.get(key, defaultValue: <String>[]).cast<String>();
  }

  @override
  Future<List<String>> getAllStudies() async {
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
    // List<Map<String, dynamic>> listForms = [
    //   {
    //     'pid': pid,
    //     'visit': '1',
    //     'timepoint': '0',
    //     'uploads': [
    //       Assets.images.test.snapshot2.path,
    //       Assets.images.test.snapshot3.path,
    //       Assets.images.test.snapshot4.path,
    //       Assets.images.test.snapshot5.path,
    //       Assets.images.test.snapshot6.path,
    //       Assets.images.test.snapshot7.path,
    //     ],
    //     'document': {
    //       'name': 'Lab Results',
    //       'type': 'crf',
    //     }
    //   },
    //   {
    //     'pid': pid,
    //     'visit': '2',
    //     'timepoint': '1',
    //     'uploads': [
    //       Assets.images.test.snapshot2.path,
    //       Assets.images.test.snapshot3.path,
    //       Assets.images.test.snapshot4.path,
    //       Assets.images.test.snapshot5.path,
    //       Assets.images.test.snapshot6.path,
    //       Assets.images.test.snapshot7.path,
    //     ],
    //     'document': {
    //       'name': 'Lab Results',
    //       'type': 'crf',
    //     }
    //   },
    // ];
    // List<ParticipantCrf> pidDocs =
    //     listForms.map((json) => ParticipantCrf.fromJson(json)).toList();
    // await appStorageBox.put(key, pidDocs);
  }

  @override
  Future<ParticipantNonCrf?> getNonCrForms({required String pid}) async {
    String key = '${pid}_non_crfs';
    return appStorageBox.get(key);
    // Map<String, dynamic> data = {
    //   'pid': pid,
    //   'uploads': [
    //     Assets.images.test.snapshot2.path,
    //     Assets.images.test.snapshot3.path,
    //     Assets.images.test.snapshot4.path,
    //     Assets.images.test.snapshot5.path,
    //     Assets.images.test.snapshot6.path,
    //     Assets.images.test.snapshot7.path,
    //   ],
    //   'document': {
    //     'name': 'Omang',
    //     'type': 'crf',
    //   }
    // };
    // ParticipantNonCrf pidDocs = ParticipantNonCrf.fromJson(data);
    // await appStorageBox.put(key, pidDocs);
  }
}
