import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart' as dio;
import 'package:edc_document_archieve/src/core/models/gallery_item.dart';
import 'package:edc_document_archieve/src/core/models/participant_crf.dart';
import 'package:edc_document_archieve/src/core/models/participant_non_crf.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:edc_document_archieve/src/providers/document_archieve_provider.dart';
import 'package:edc_document_archieve/src/services/bloc/events/document_archive_event.dart';
import 'package:edc_document_archieve/src/services/bloc/states/document_archive_state.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';
import 'package:get/get.dart' as Get;
import "package:dio/dio.dart";
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';

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

    on<DocumentArchieveCrfFormSyncRequested>(
      _onDocumentArchieveCrfFormSyncRequested,
      transformer: sequential(),
    );

    on<DocumentArchieveNonCrfFormSyncRequested>(
      _onDocumentArchieveNonCrfFormSyncRequested,
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

  Future<FutureOr<void>> _onDocumentArchieveCrfFormSyncRequested(
      DocumentArchieveCrfFormSyncRequested event,
      Emitter<DocumentArchieveState> emit) async {
    emit(const DocumentArchieveState.loading());
    List<Map<String, dynamic>> data = event.data;
    await documentArchieveRepository.synchCrfData(data);
    emit(const DocumentArchieveState.loaded());
  }

  Future<FutureOr<void>> _onDocumentArchieveNonCrfFormSyncRequested(
      DocumentArchieveNonCrfFormSyncRequested event,
      Emitter<DocumentArchieveState> emit) async {
    Map<String, dynamic> data = event.data;
    emit(const DocumentArchieveState.loading());
    await documentArchieveRepository.synchNonCrfData(data);
    emit(const DocumentArchieveState.loaded());
  }

  void getDocumentArchievePids({required String selectedStudy}) {
    add(DocumentArchievePidsRequested(studySelected: selectedStudy));
  }

  void getDocumentArchieveStudy() {
    add(DocumentArchieveStudiesRequested());
  }

  void getParticipantForms(
      {required String pid, required StudyDocument documentForm}) {
    add(DocumentArchieveFormRequested(pid: pid, documentForm: documentForm));
  }

  void addCrfDocument({
    required String pid,
    required String visitCode,
    required String timePoint,
    required List<GalleryItem> uploads,
    required StudyDocument studyDocument,
  }) {
    ParticipantCrf crf = ParticipantCrf.fromJson({
      'pid': pid,
      'visit': visitCode,
      'timepoint': timePoint,
      'uploads': uploads,
      'document': studyDocument.toJson(),
      'appName': studyDocument.appName,
      'created': DateTime.now().toString(),
    });
    add(DocumentArchieveFormAdded(form: crf));
  }

  void addNonCrfDocument({
    required String pid,
    required List<GalleryItem> uploads,
    required StudyDocument studyDocument,
  }) {
    ParticipantNonCrf nonCrf = ParticipantNonCrf.fromJson({
      'pid': pid,
      'uploads': uploads,
      'document': studyDocument.toJson(),
      'appName': studyDocument.appName,
      'created': DateTime.now().toString()
    });
    add(DocumentArchieveFormAdded(form: nonCrf));
  }

  void updateCrfDocument({
    required String visitCode,
    required String timePoint,
    required List<GalleryItem> uploads,
    required ParticipantCrf crf,
  }) {
    crf.visit = visitCode;
    crf.timepoint = timePoint;
    crf.uploads = uploads;
    add(DocumentArchieveFormAdded(form: crf));
  }

  void updateNonCrfDocument({
    required List<GalleryItem> uploads,
    required ParticipantNonCrf nonCrf,
  }) {
    nonCrf.uploads = uploads;
    add(DocumentArchieveFormAdded(form: nonCrf));
  }

  void deleteForm({required dynamic crf}) {
    add(DocumentArchieveFormDeleted(form: crf));
  }

  Future<void> syncCrfsData({
    required List<ParticipantCrf> partcipantCrfs,
    required String currentUser,
  }) async {
    List<Map<String, dynamic>> results = [];
    for (var crf in partcipantCrfs) {
      String modelName = crf.document.name.constantCase.toLowerCase();
      List<MultipartFile> uploads = [];
      for (GalleryItem upload in crf.uploads) {
        MultipartFile multipart =
            await MultipartFile.fromFile(upload.imageUrl, filename: upload.id);
        uploads.add(multipart);
      }

      Map<String, dynamic> data = {
        'subject_identifier': crf.pid,
        'app_label': crf.appName,
        'model_name': modelName,
        'visit_code': crf.visit.substring(1),
        'timepoint': crf.timepoint,
        'files': uploads,
        'date_captured': convertDateTimeDisplay(crf.created),
        'username': currentUser,
      };
      results.add(data);
    }
    logger.e(results);
    add(DocumentArchieveCrfFormSyncRequested(data: results));
  }

  Future<void> syncNonCrfData({
    required ParticipantNonCrf nonCrf,
    required String currentUser,
  }) async {
    String modelName = nonCrf.document.name.constantCase.toLowerCase();
    List<MultipartFile> uploads = [];
    for (GalleryItem upload in nonCrf.uploads) {
      MultipartFile multipart =
          await MultipartFile.fromFile(upload.imageUrl, filename: upload.id);
      uploads.add(multipart);
    }
    Map<String, dynamic> data = {
      'subject_identifier': nonCrf.pid,
      'app_label': nonCrf.appName,
      'model_name': modelName,
      'files': uploads,
      'date_captured': convertDateTimeDisplay(nonCrf.created),
      'username': currentUser,
    };
    add(DocumentArchieveNonCrfFormSyncRequested(data: data));
  }

  Future<void> addPid({
    required String studyName,
    required String pid,
    required String type,
  }) async {
    await documentArchieveRepository.addParticipantIdentifier(
      pid: pid,
      studyName: studyName,
      type: type,
    );
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

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy HH:mm');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
}
