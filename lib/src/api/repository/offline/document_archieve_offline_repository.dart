import 'package:edc_document_archieve/src/api/repository/offline/local_storage_repository.dart';
import 'package:edc_document_archieve/src/providers/document_archieve_provider.dart';

class DocumentArchieveOffLineRepository extends LocalStorageRepository
    implements DocumentArchieveProvider {
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
  Future<List<String>> getAllParticipants() {
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getAllStudies() async {
    List<String>? studies = appStorageBox.get('studies');
    if (studies != null && studies.isNotEmpty) {
      return studies;
    }

    appStorageBox.put('studies', ['Flourish', 'Tshilo Dikotla']);
    return [];
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
