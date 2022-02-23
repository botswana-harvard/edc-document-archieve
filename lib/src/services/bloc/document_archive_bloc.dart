import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:edc_document_archieve/src/core/models/participant_crf.dart';
import 'package:edc_document_archieve/src/core/models/participant_non_crf.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:edc_document_archieve/src/providers/document_archieve_provider.dart';
import 'package:edc_document_archieve/src/services/bloc/events/document_archive_event.dart';
import 'package:edc_document_archieve/src/services/bloc/states/document_archive_state.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';

class DocumentArchieveBloc
    extends Bloc<DocumentArchieveEvent, DocumentArchieveState> {
  DocumentArchieveBloc({required this.documentArchieveRepository})
      : super(const DocumentArchieveState.initial()) {
    on<DocumentArchieveStudiesRequested>(
      _onDocumentArchieveStudySelected,
      transformer: sequential(),
    );
    on<DocumentArchievePidsRequested>(
      _onDocumentArchievePidsRequested,
      transformer: sequential(),
    );

    on<DocumentArchieveFormRequested>(
      _onDocumentArchieveFormRequested,
      transformer: sequential(),
    );
  }

  final DocumentArchieveProvider documentArchieveRepository;

  Future<void> _onDocumentArchieveStudySelected(
    DocumentArchieveStudiesRequested event,
    Emitter<DocumentArchieveState> emit,
  ) async {
    emit(const DocumentArchieveState<List<String>>.loading());
    List<String> allStudies = await documentArchieveRepository.getAllStudies();
    emit(DocumentArchieveState<List<String>>.loaded(data: allStudies));
  }

  Future<void> _onDocumentArchievePidsRequested(
    DocumentArchievePidsRequested event,
    Emitter<DocumentArchieveState> emit,
  ) async {
    emit(const DocumentArchieveState<Map<String, dynamic>>.loading());
    Map<String, dynamic> data = await getParticipantsForms(event.studySelected);
    emit(DocumentArchieveState<Map<String, dynamic>>.loaded(data: data));
  }

  Future<void> _onDocumentArchieveFormRequested(
    DocumentArchieveFormRequested event,
    Emitter<DocumentArchieveState> emit,
  ) async {
    emit(const DocumentArchieveState<Map<String, dynamic>>.loading());
    String form = event.form;
    switch (form) {
      case kCrfForm:
        List<ParticipantCrf> data =
            await documentArchieveRepository.getCrForms(pid: event.pid);
        return emit(
            DocumentArchieveState<List<ParticipantCrf>>.loaded(data: data));
      case kNonCrfForm:
        ParticipantNonCrf data =
            await documentArchieveRepository.getNonCrForms(pid: event.pid);
        return emit(
            DocumentArchieveState<ParticipantNonCrf>.loaded(data: data));
      default:
    }
  }

  void getDocumentArchievePids({required String selectedStudy}) {
    add(DocumentArchievePidsRequested(studySelected: selectedStudy));
  }

  void getDocumentArchieveStudy() {
    add(DocumentArchieveStudiesRequested());
  }

  Future<void> addPid({required String studyName, required String pid}) async {
    await documentArchieveRepository.addParticipantIdentifier(
        pid: pid, studyName: studyName);
  }

  Future<Map<String, dynamic>> getParticipantsForms(
      String studySelected) async {
    List<String> pids =
        await documentArchieveRepository.getAllParticipants(studySelected);
    List<StudyDocument> forms =
        await documentArchieveRepository.getAllForms(studySelected);

    Map<String, dynamic> data = {
      kForms: forms,
      kParticipants: pids,
    };
    return data;
  }

  void getParticipantForms({required String pid, required String form}) {
    add(DocumentArchieveFormRequested(pid: pid, form: form));
  }
}
