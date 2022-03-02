import 'package:edc_document_archieve/src/core/models/participant_crf.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:equatable/equatable.dart';

abstract class DocumentArchieveEvent<T> extends Equatable {
  const DocumentArchieveEvent();

  @override
  List<Object> get props => [];
}

class DocumentArchieveLoaded extends DocumentArchieveEvent {}

class DocumentArchieveStudySelected extends DocumentArchieveEvent {}

class DocumentArchievePidsRequested<String> extends DocumentArchieveEvent {
  final String studySelected;

  const DocumentArchievePidsRequested({required this.studySelected});
}

class DocumentArchieveStudiesRequested extends DocumentArchieveEvent {}

class DocumentArchievePidCreated<String> extends DocumentArchieveEvent {
  final String pid;

  const DocumentArchievePidCreated({required this.pid});
}

class DocumentArchieveVisitRequested extends DocumentArchieveEvent {}

class DocumentArchieveFormRequested extends DocumentArchieveEvent {
  final String pid;
  final StudyDocument documentForm;

  const DocumentArchieveFormRequested({
    required this.pid,
    required this.documentForm,
  });
}

class DocumentArchieveFormAdded extends DocumentArchieveEvent {
  final dynamic form;
  const DocumentArchieveFormAdded({required this.form});
}

class DocumentArchieveFormDeleted extends DocumentArchieveEvent {
  final dynamic form;
  const DocumentArchieveFormDeleted({required this.form});
}
