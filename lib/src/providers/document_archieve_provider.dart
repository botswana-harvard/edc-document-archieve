abstract class DocumentArchieveProvider {
  //Get all available studies to choose from
  Future<List<String>> getAllStudies();

  // Get all PIDs from edc API
  Future<List<String>> getAllParticipants(String studyName);

  //
  Future<List<String>> getAllForms(String studyName);

  Future<List<String>> getAllVisits(String studyName);

  Future<List<String>> getAllTimePoints(String studyName);

  Future<void> addParticipantIdentifier({
    required String studyName,
    required String pid,
  });

  Future<void> addParticipantCrfForm(String studyName);

  Future<void> addParticipantNonCrfForm(String studyName);
}
