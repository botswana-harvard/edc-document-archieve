abstract class DocumentArchieveProvider {
  //Get all available studies to choose from
  Future<List<String>> getAllStudies();

  // Get all PIDs from edc API
  Future<List<String>> getAllParticipants();

  //
  Future<List<String>> getAllForms();

  Future<List<String>> getAllVisits();

  Future<List<String>> getAllTimePoints();

  Future<void> addParticipantIdentifier();

  Future<void> addParticipantCrfForm();

  Future<void> addParticipantNonCrfForm();
}
