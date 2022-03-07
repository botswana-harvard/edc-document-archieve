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

    on<DocumentArchieveFormAdded>(
      _onDocumentArchieveFormAdded,
      transformer: sequential(),
    );

    on<DocumentArchieveFormDeleted>(
      _onDocumentArchieveFormDeleted,
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
    StudyDocument documentForm = event.documentForm;
    switch (documentForm.type) {
      case kCrfForm:
        List<ParticipantCrf> data =
            await documentArchieveRepository.getCrForms(pid: event.pid);
        data = data
            .where((element) => element.document.name == documentForm.name)
            .toList();
        data = data.reversed.toList();
        return emit(
            DocumentArchieveState<List<ParticipantCrf>>.loaded(data: data));
      case kNonCrfForm:
        List<ParticipantNonCrf> data =
            await documentArchieveRepository.getNonCrForms(pid: event.pid);
        try {
          ParticipantNonCrf nonCrf = data.firstWhere(
              (element) => element.document.name == documentForm.name);
          return emit(
              DocumentArchieveState<ParticipantNonCrf>.loaded(data: nonCrf));
        } catch (e) {
          return emit(const DocumentArchieveState<ParticipantNonCrf>.loaded());
        }
      default:
    }
  }

  Future<void> _onDocumentArchieveFormAdded(
    DocumentArchieveFormAdded event,
    Emitter<DocumentArchieveState> emit,
  ) async {
    emit(const DocumentArchieveState<Map<String, dynamic>>.loading());
    String documentType = event.form.document.type;
    switch (documentType) {
      case kCrfForm:
        ParticipantCrf crf = event.form;
        await documentArchieveRepository.addParticipantCrfForm(crf: crf);
        break;
      case kNonCrfForm:
        ParticipantNonCrf nonCrf = event.form;
        await documentArchieveRepository.addParticipantNonCrfForm(
            nonCrf: nonCrf);
        break;
      default:
    }
    emit(const DocumentArchieveState.loaded());
  }

  Future<void> _onDocumentArchieveFormDeleted(
    DocumentArchieveFormDeleted event,
    Emitter<DocumentArchieveState> emit,
  ) async {
    emit(const DocumentArchieveState<Map<String, dynamic>>.loading());
    String documentType = event.form.document.type;
    switch (documentType) {
      case kCrfForm:
        ParticipantCrf crf = event.form;
        List<ParticipantCrf> data =
            await documentArchieveRepository.deleteParticipantCrfForm(crf: crf);
        data = data.reversed.toList();
        return emit(
            DocumentArchieveState<List<ParticipantCrf>>.loaded(data: data));
      case kNonCrfForm:
        ParticipantNonCrf nonCrf = event.form;
        await documentArchieveRepository.deleteParticipantNonCrfForm(
            nonCrf: nonCrf);
        return emit(
            const DocumentArchieveState<List<ParticipantNonCrf>>.loaded());
      default:
    }
    emit(const DocumentArchieveState.loaded());
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
    Map<String, dynamic> results =
        await documentArchieveRepository.getAllParticipants(studySelected);
    List<StudyDocument> caregiverForms =
        await documentArchieveRepository.getCaregiverForms(studySelected);

    List<StudyDocument> childForms =
        await documentArchieveRepository.getChildForms(studySelected);

    Map<String, dynamic> data = {
      kCaregiverForms: caregiverForms,
      kChildForms: childForms,
      kCaregiverPid: results[kCaregiverPid],
      kChildPid: results[kChildPid]
    };
    return data;
  }

  void getParticipantForms(
      {required String pid, required StudyDocument documentForm}) {
    add(DocumentArchieveFormRequested(pid: pid, documentForm: documentForm));
  }

  void addCrfDocument({
    required String pid,
    required String visitCode,
    required String timePoint,
    required List<String> uploads,
    required StudyDocument studyDocument,
  }) {
    ParticipantCrf crf = ParticipantCrf.fromJson({
      'pid': pid,
      'visit': visitCode,
      'timepoint': timePoint,
      'uploads': uploads,
      'document': studyDocument.toJson()
    });
    add(DocumentArchieveFormAdded(form: crf));
  }

  void addNonCrfDocument({
    required String pid,
    required List<String> uploads,
    required StudyDocument studyDocument,
  }) {
    ParticipantNonCrf nonCrf = ParticipantNonCrf.fromJson({
      'pid': pid,
      'uploads': uploads,
      'document': studyDocument.toJson(),
    });
    add(DocumentArchieveFormAdded(form: nonCrf));
  }

  void updateCrfDocument({
    required String visitCode,
    required String timePoint,
    required List<String> uploads,
    required ParticipantCrf crf,
  }) {
    crf.visit = visitCode;
    crf.timepoint = timePoint;
    crf.uploads = uploads;
    add(DocumentArchieveFormAdded(form: crf));
  }

  void updateNonCrfDocument({
    required List<String> uploads,
    required ParticipantNonCrf nonCrf,
  }) {
    nonCrf.uploads = uploads;
    add(DocumentArchieveFormAdded(form: nonCrf));
  }

  void deleteForm({required dynamic crf}) {
    add(DocumentArchieveFormDeleted(form: crf));
  }
}
