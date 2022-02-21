import 'package:edc_document_archieve/src/api/repository/offline/document_archieve_offline_repository.dart';
import 'package:edc_document_archieve/src/api/repository/online/document_archieve_online_repository.dart';
import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/providers/document_archieve_provider.dart';

class DocumentArchieveWrapper implements DocumentArchieveProvider {
  DocumentArchieveWrapper() {
    _offlineRepository = Injector.resolve<DocumentArchieveOffLineRepository>();
    _onlineRepository = Injector.resolve<DocumentArchieveOnLineRepository>();
  }

  late DocumentArchieveOffLineRepository _offlineRepository;
  late DocumentArchieveOnLineRepository _onlineRepository;

  @override
  Future<void> addParticipantCrfForm() {
    // TODO: implement addParticipantCrfForm
    throw UnimplementedError();
  }

  @override
  Future<void> addParticipantIdentifier() {
    // TODO: implement addParticipantIdentifier
    throw UnimplementedError();
  }

  @override
  Future<void> addParticipantNonCrfForm() {
    // TODO: implement addParticipantNonCrfForm
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getAllForms() {
    // TODO: implement getAllForms
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getAllParticipants() async {
    return await _offlineRepository.getAllParticipants();
  }

  @override
  Future<List<String>> getAllStudies() async {
    return await _offlineRepository.getAllStudies();
  }

  @override
  Future<List<String>> getAllTimePoints() {
    // TODO: implement getAllTimePoints
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getAllVisits() {
    // TODO: implement getAllVisits
    throw UnimplementedError();
  }
}
