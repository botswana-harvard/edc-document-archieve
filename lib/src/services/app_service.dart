import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/services/bloc/document_archive_bloc.dart';
import 'package:flutter/material.dart';

class AppService with ChangeNotifier {
  String _selectedStudy = '';

  String get selectedStudy => _selectedStudy;

  set selectedStudy(String selectedStudy) {
    _selectedStudy = selectedStudy;
    notifyListeners();
  }

  Future<void> addPid(String pid) async {
    await Injector.resolve<DocumentArchieveBloc>().addPid(
      pid: pid,
      studyName: selectedStudy,
    );
    notifyListeners();
  }
}
