import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:edc_document_archieve/src/services/bloc/document_archive_bloc.dart';
import 'package:flutter/material.dart';

class AppService with ChangeNotifier {
  late String _selectedStudy;
  late StudyDocument _studyDocument;

  //define Getters
  String get selectedStudy => _selectedStudy;
  StudyDocument get selectedStudyDocument => _studyDocument;

  //define Setters
  set selectedStudy(String selectedStudy) {
    _selectedStudy = selectedStudy;
    notifyListeners();
  }

  set selectedStudyDocument(StudyDocument selectedStudyDocument) {
    _studyDocument = selectedStudyDocument;
    notifyListeners();
  }

  //add participant identifier and notifies UI about the new PID
  Future<void> addPid(String pid) async {
    await Injector.resolve<DocumentArchieveBloc>().addPid(
      pid: pid,
      studyName: selectedStudy,
    );
    notifyListeners();
  }
}
