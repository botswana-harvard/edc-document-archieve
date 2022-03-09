import 'package:edc_document_archieve/src/api/repository/offline/document_archieve_offline_repository.dart';
import 'package:edc_document_archieve/src/api/repository/online/base_online_repository.dart';
import 'package:edc_document_archieve/src/api/repository/online/document_archieve_online_repository.dart';
import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/core/models/participant_crf.dart';
import 'package:edc_document_archieve/src/core/models/participant_non_crf.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:edc_document_archieve/src/providers/document_archieve_provider.dart';

class DocumentArchieveWrapper implements DocumentArchieveProvider {
  DocumentArchieveWrapper() {
    _offlineRepository = Injector.resolve<DocumentArchieveOffLineRepository>();
    _onlineRepository = Injector.resolve<DocumentArchieveOnLineRepository>();
  }

  late DocumentArchieveOffLineRepository _offlineRepository;
  late DocumentArchieveOnLineRepository _onlineRepository;
  late List<String>? participants;
  late List<String>? forms;
  late List<String>? studies;

  @override
  Future<void> addParticipantCrfForm({
    required ParticipantCrf crf,
  }) async {
    await _offlineRepository.addParticipantCrfForm(crf: crf);
  }

  @override
  Future<void> addParticipantIdentifier({
    required String studyName,
    required String pid,
    required String type,
  }) async {
    await _offlineRepository.addParticipantIdentifier(
      studyName: studyName,
      pid: pid,
      type: type,
    );
  }

  @override
  Future<void> addParticipantNonCrfForm({
    required ParticipantNonCrf nonCrf,
  }) async {
    await _offlineRepository.addParticipantNonCrfForm(nonCrf: nonCrf);
  }

  @override
  Future<Map<String, dynamic>> getAllParticipants(String studyName) async {
    return await _offlineRepository.getAllParticipants(studyName);
  }

  @override
  Future<List<String>> getAllStudies() async {
    return await _offlineRepository.getAllStudies();
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
    return await _offlineRepository.getCrForms(pid: pid);
  }

  @override
  Future<List<ParticipantNonCrf>> getNonCrForms({required String pid}) async {
    return await _offlineRepository.getNonCrForms(pid: pid);
  }

  @override
  Future<List<ParticipantCrf>> deleteParticipantCrfForm(
      {required ParticipantCrf crf}) async {
    return await _offlineRepository.deleteParticipantCrfForm(crf: crf);
  }

  @override
  Future<void> deleteParticipantNonCrfForm(
      {required ParticipantNonCrf nonCrf}) async {
    await _offlineRepository.deleteParticipantNonCrfForm(nonCrf: nonCrf);
  }

  @override
  Future<List<StudyDocument>> getChildForms(String studyName) async {
    return await _offlineRepository.getChildForms(studyName);
  }

  @override
  Future<List<StudyDocument>> getCaregiverForms(String studyName) async {
    return await _offlineRepository.getCaregiverForms(studyName);
  }
}
