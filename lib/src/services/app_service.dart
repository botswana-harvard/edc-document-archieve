import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:edc_document_archieve/src/services/bloc/document_archive_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppService with ChangeNotifier {
  late String _selectedStudy;
  late StudyDocument _studyDocument;
  late String _selectedPid;
  List<String> _selectedImages = [];

  //define Getters
  String get selectedStudy => _selectedStudy;
  String get selectedPid => _selectedPid;
  StudyDocument get selectedStudyDocument => _studyDocument;
  List<String> get selectedImages => _selectedImages;

  //define Setters
  set selectedStudy(String selectedStudy) {
    _selectedStudy = selectedStudy;
    notifyListeners();
  }

  set selectedImages(List<String> selectedImages) {
    _selectedImages = selectedImages;
    notifyListeners();
  }

  //define Setters
  set selectedPid(String pid) {
    _selectedPid = pid;
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

  void clear() {
    _selectedImages!.clear();
  }

  void removeSelectedImage(String imageUrl) {
    _selectedImages!.removeWhere((element) => element == imageUrl);
    notifyListeners();
  }

  void addSelectedImage(String xFile) {
    _selectedImages!.add(xFile);
    notifyListeners();
  }

  void notifyWidgetListeners() {
    notifyListeners();
  }

  // Future<void> onUploadButtonTapped({
  //   required String pid,
  //   required String visitCode,
  //   required String timePoint,
  //   required List<String> uploads,
  //   required StudyDocument studyDocument,
  // }) async {
  //   Injector.resolve<DocumentArchieveBloc>().addCrfDocument(
  //     pid: selectedPid,
  //     visitCode: visitCode,
  //     timePoint: timePoint,
  //     uploads: uploads,
  //     studyDocument: selectedStudyDocument,
  //   );
  // }
}
