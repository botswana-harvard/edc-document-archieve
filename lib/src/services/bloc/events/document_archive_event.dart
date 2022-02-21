import 'package:equatable/equatable.dart';

abstract class DocumentArchieveEvent<T> extends Equatable {
  const DocumentArchieveEvent();

  @override
  List<Object> get props => [];
}

class DocumentArchieveLoaded extends DocumentArchieveEvent {}

class DocumentArchieveSelected extends DocumentArchieveEvent {}
