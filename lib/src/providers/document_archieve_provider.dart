import 'package:edc_document_archieve/src/core/models/participant_crf.dart';
import 'package:edc_document_archieve/src/core/models/participant_non_crf.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';

abstract class DocumentArchieveProvider {
  late String? message;
  //Get all available studies to choose from
  Future<List<String>> getAllStudies();

  // Get all PIDs from edc API
  Future<Map<String, dynamic>> getAllParticipants(String studyName);

  //
  Future<List<StudyDocument>> getCaregiverForms(String studyName);
  Future<List<StudyDocument>> getChildForms(String studyName);

  Future<void> addParticipantIdentifier({
    required String studyName,
    required String pid,
    required String type,
  });

  Future<void> addParticipantCrfForm({
    required ParticipantCrf crf,
  });

  Future<void> addParticipantNonCrfForm({
    required ParticipantNonCrf nonCrf,
  });

  Future<List<ParticipantCrf>> deleteParticipantCrfForm({
    required ParticipantCrf crf,
  });

  Future<void> deleteParticipantNonCrfForm({
    required ParticipantNonCrf nonCrf,
  });

  Future<List<ParticipantCrf>> getCrForms({required String pid});

  Future<List<ParticipantNonCrf>> getNonCrForms({required String pid});

  Future<List<ParticipantCrf>> synchCrfData({
    required List<ParticipantCrf> crfs,
    required String selectedStudy,
  });

  Future<String> synchNonCrfData({
    required ParticipantNonCrf nonCrf,
    required String selectedStudy,
  });

  Future<void> loadDataFromApi();
}
