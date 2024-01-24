import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/core/models/item.dart';
import 'package:edc_document_archieve/src/services/bloc/document_archive_bloc.dart';
import 'package:flutter/material.dart';

class SentItemService extends ChangeNotifier {
  final _archieveBloc = Injector.resolve<DocumentArchieveBloc>();
  List<Item> sentItems = [];
  List<Item> pendingItems = [];

  initItems() {
    sentItems = _archieveBloc.sentItems;
    pendingItems = _archieveBloc.pendingItems;
  }

  void notifyWidgetListeners() {
    initItems();
    notifyListeners();
  }
}
