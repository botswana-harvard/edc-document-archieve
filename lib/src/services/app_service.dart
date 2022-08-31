import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/core/models/gallery_item.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:edc_document_archieve/src/services/bloc/document_archive_bloc.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AppService with ChangeNotifier {
  late String _selectedStudy;
  late StudyDocument? _studyDocument;
  late String _selectedPid;
  late String _currentUser;
  List<GalleryItem> _selectedImages = [];

  //define Getters
  String get selectedStudy => _selectedStudy;
  String get selectedPid => _selectedPid;
  String get currentUser => _currentUser;
  StudyDocument get selectedStudyDocument => _studyDocument!;
  List<GalleryItem> get selectedImages => _selectedImages;

  //define Setters
  set selectedStudy(String selectedStudy) {
    _selectedStudy = selectedStudy;
    notifyWidgetListeners();
  }

  set selectedImages(List<GalleryItem> selectedImages) {
    _selectedImages = selectedImages;
    notifyWidgetListeners();
  }

  //define Setters
  set selectedPid(String pid) {
    _selectedPid = pid;
    notifyWidgetListeners();
  }

  set currentUser(String user) {
    _currentUser = user;
    notifyWidgetListeners();
  }

  set selectedStudyDocument(StudyDocument selectedStudyDocument) {
    _studyDocument = selectedStudyDocument;
    notifyWidgetListeners();
  }

  //add participant identifier and notifies UI about the new PID
  Future<void> addPid({required String pid, required String type}) async {
    await Injector.resolve<DocumentArchieveBloc>().addPid(
      pid: pid,
      studyName: selectedStudy,
      type: type,
    );
    notifyWidgetListeners();
  }

  void clear() {
    _selectedPid = '';
    _selectedStudy = '';
    _studyDocument = null;
    _selectedImages.clear();
  }

  void removeSelectedImage(String imageId) {
    _selectedImages.removeWhere((element) => element.id == imageId);
    notifyWidgetListeners();
  }

  void addSelectedImage(String xFile) {
    _selectedImages
        .add(GalleryItem(id: const Uuid().v4().toString(), imageUrl: xFile));
    notifyWidgetListeners();
  }

  void notifyWidgetListeners() {
    notifyListeners();
  }

  void addAllImages(List<String> list) {
    List<GalleryItem> temp = list
        .map(
          (image) => GalleryItem(
            id: const Uuid().v4().toString(),
            imageUrl: image,
          ),
        )
        .toList();
    _selectedImages.addAll(temp);
    notifyWidgetListeners();
  }
}
