import 'package:dio/dio.dart';
import 'package:edc_document_archieve/src/api/repository/online/base_online_repository.dart';
import 'package:edc_document_archieve/src/api/wrapper/base_storage_wrapper.dart';
import 'package:edc_document_archieve/src/core/models/gallery_item.dart';
import 'package:edc_document_archieve/src/core/models/participant_crf.dart';
import 'package:edc_document_archieve/src/core/models/participant_non_crf.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:edc_document_archieve/src/providers/document_archieve_provider.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';

class DocumentArchieveWrapper extends BaseStorageWrapper
    implements DocumentArchieveProvider {
  late List<String>? participants;
  late List<String>? forms;
  late List<String>? studies;
  late String? message;

  @override
  Future<void> addParticipantCrfForm({
    required ParticipantCrf crf,
  }) async {
    await archieveOffLineRepository.addParticipantCrfForm(crf: crf);
  }

  @override
  Future<void> addParticipantIdentifier({
    required String studyName,
    required String pid,
    required String type,
  }) async {
    await archieveOffLineRepository.addParticipantIdentifier(
      studyName: studyName,
      pid: pid,
      type: type,
    );
  }

  @override
  Future<void> addParticipantNonCrfForm({
    required ParticipantNonCrf nonCrf,
  }) async {
    await archieveOffLineRepository.addParticipantNonCrfForm(
      nonCrf: nonCrf,
    );
  }

  @override
  Future<Map<String, dynamic>> getAllParticipants(String studyName) async {
    return await archieveOffLineRepository.getAllParticipants(studyName);
  }

  @override
  Future<List<String>> getAllStudies() async {
    return await archieveOffLineRepository.getAllStudies();
  }

  @override
  Future<List<ParticipantCrf>> getCrForms({required String pid}) async {
    return await archieveOffLineRepository.getCrForms(pid: pid);
  }

  @override
  Future<List<ParticipantNonCrf>> getNonCrForms({required String pid}) async {
    return await archieveOffLineRepository.getNonCrForms(pid: pid);
  }

  @override
  Future<List<ParticipantCrf>> deleteParticipantCrfForm(
      {required ParticipantCrf crf}) async {
    return await archieveOffLineRepository.deleteParticipantCrfForm(crf: crf);
  }

  @override
  Future<void> deleteParticipantNonCrfForm(
      {required ParticipantNonCrf nonCrf}) async {
    await archieveOffLineRepository.deleteParticipantNonCrfForm(nonCrf: nonCrf);
  }

  @override
  Future<List<StudyDocument>> getChildForms(String studyName) async {
    return await archieveOffLineRepository.getChildForms(studyName);
  }

  @override
  Future<List<StudyDocument>> getCaregiverForms(String studyName) async {
    return await archieveOffLineRepository.getCaregiverForms(studyName);
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
    Response response = await archieveOnLineRepository.pushDataToServer(
        url: url, data: formData);

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
    Map<String, dynamic> data = {};
    message = '';
    for (var crf in crfForms) {
      String modelName = crf.document.name.constantCase.toLowerCase();
      List<MultipartFile> uploads = [];
      for (GalleryItem upload in crf.uploads) {
        MultipartFile multipart =
            await MultipartFile.fromFile(upload.imageUrl, filename: upload.id);
        uploads.add(multipart);
      }

      if (selectedStudy == kTshiloDikotla) {
        data = {
          'subject_identifier': crf.pid,
          'app_label': crf.appName,
          'model_name': modelName,
          'visit_code': crf.visit,
          'timepoint': crf.timepoint,
          'files': uploads,
          'date_captured': convertDateTimeDisplay(crf.created),
          'username':
              archieveOffLineRepository.appStorageBox.get(kLastUserLoggedIn),
        };
      } else {
        data = {
          'subject_identifier': crf.pid,
          'app_label': crf.appName,
          'model_name': modelName,
          'visit_code': crf.visit,
          'timepoint': crf.timepoint,
          'files': uploads,
          'date_captured': convertDateTimeDisplay(crf.created),
          'username':
              archieveOffLineRepository.appStorageBox.get(kLastUserLoggedIn),
        };
      }

      if (uploads.isNotEmpty) {
        logger.e(data);
        message = await synchData(data: data, selectedStudy: selectedStudy);
        if (message == 'Success') {
          await archieveOffLineRepository.deleteParticipantCrfForm(crf: crf);
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
      'username':
          archieveOffLineRepository.appStorageBox.get(kLastUserLoggedIn),
    };

    if (nonCrf.version != null) {
      data['consent_version'] = nonCrf.version;
    }
    if (nonCrf.uploads.isEmpty) {
      return 'No data available to sync';
    }

    logger.e(data);
    String response = await synchData(data: data, selectedStudy: selectedStudy);
    if (response == 'Success') {
      await archieveOffLineRepository.deleteParticipantNonCrfForm(
          nonCrf: nonCrf);
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

  @override
  Future<void> loadDataFromApi() async {
    await saveDataLocalStorage();
  }
}
