import 'package:edc_document_archieve/src/api/repository/offline/document_archieve_offline_repository.dart';
import 'package:edc_document_archieve/src/api/repository/online/document_archieve_online_repository.dart';
import 'package:edc_document_archieve/src/config/injector.dart';
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
  Future<void> addParticipantCrfForm(String studyName) {
    // TODO: implement addParticipantCrfForm
    throw UnimplementedError();
  }

  @override
  Future<void> addParticipantIdentifier(
      {required String studyName, required String pid}) async {
    await _offlineRepository.addParticipantIdentifier(
      studyName: studyName,
      pid: pid,
    );
  }

  @override
  Future<void> addParticipantNonCrfForm(String studyName) {
    // TODO: implement addParticipantNonCrfForm
    throw UnimplementedError();
  }

  @override
  Future<List<StudyDocument>> getAllForms(String studyName) async {
    return await _offlineRepository.getAllForms(studyName);
  }

  @override
  Future<List<String>> getAllParticipants(String studyName) async {
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
}