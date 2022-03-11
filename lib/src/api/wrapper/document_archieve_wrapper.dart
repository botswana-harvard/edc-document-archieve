import 'package:dio/dio.dart';
import 'package:edc_document_archieve/src/api/repository/offline/document_archieve_offline_repository.dart';
import 'package:edc_document_archieve/src/api/repository/online/base_online_repository.dart';
import 'package:edc_document_archieve/src/api/repository/online/document_archieve_online_repository.dart';
import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/core/models/gallery_item.dart';
import 'package:edc_document_archieve/src/core/models/participant_crf.dart';
import 'package:edc_document_archieve/src/core/models/participant_non_crf.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:edc_document_archieve/src/providers/document_archieve_provider.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';

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
  late String? message;

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

  @protected
  Future<String> synchData({
    required String selectedStudy,
    required Map<String, dynamic> data,
  }) async {
    String url;
    switch (selectedStudy) {
      case kFlourish:
        url = BaseOnlineRepository.flourishUrl + 'projects/';
        break;
      case kTshiloDikotla:
        url = BaseOnlineRepository.tdUrl + 'projects/';
        break;
      default:
        url = '';
    }
    FormData formData = FormData.fromMap(data);
    Response response =
        await _onlineRepository.pushDataToServer(url: url, data: formData);

    switch (response.statusCode) {
      case 200:
        return 'Success';
      case 400:
        return 'Bad Request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 500:
        return 'Internal Server Error';
      case 502:
        return 'Bad Gateway';
      default:
        return response.statusMessage!;
    }
  }

  @override
  Future<List<ParticipantCrf>> synchCrfData({
    required List<ParticipantCrf> crfs,
    required String selectedStudy,
  }) async {
    List<ParticipantCrf> crfForms = crfs.map((e) => e).toList();
    message = '';
    for (var crf in crfForms) {
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
        'username': _offlineRepository.appStorageBox.get(kLastUserLoggedIn),
      };
      if (uploads.isNotEmpty) {
        message = await synchData(data: data, selectedStudy: selectedStudy);
        if (message == 'Success') {
          await _offlineRepository.deleteParticipantCrfForm(crf: crf);
          crfs.remove(crf);
        }
      }
    }
    return crfs;
  }

  @override
  Future<String> synchNonCrfData({
    required ParticipantNonCrf nonCrf,
    required String selectedStudy,
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
      'username': _offlineRepository.appStorageBox.get(kLastUserLoggedIn),
    };
    if (nonCrf.uploads.isEmpty) {
      return 'No data available to sync';
    }
    String response = await synchData(data: data, selectedStudy: selectedStudy);
    if (response == 'Success') {
      await _offlineRepository.deleteParticipantNonCrfForm(nonCrf: nonCrf);
    }
    return response;
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy HH:mm');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
}
