import 'package:flutter/material.dart';

class AppService with ChangeNotifier {
  String _selectedStudy = '';

  String get selectedStudy => _selectedStudy;

  set selectedStudy(String selectedStudy) {
    _selectedStudy = selectedStudy;
    notifyListeners();
  }
}
