import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:edc_document_archieve/src/providers/document_archieve_provider.dart';
import 'package:edc_document_archieve/src/services/bloc/events/document_archive_event.dart';
import 'package:edc_document_archieve/src/services/bloc/states/document_archive_state.dart';

class DocumentArchieveBloc
    extends Bloc<DocumentArchieveEvent, DocumentArchieveState> {
  DocumentArchieveBloc({
    required this.documentArchieveRepository,
  }) : super(const DocumentArchieveState.initial()) {
    on<DocumentArchieveSelected>(
      _onDocumentArchieveStatusLoaded,
      transformer: sequential(),
    );
  }

  final DocumentArchieveProvider documentArchieveRepository;

  Future<void> _onDocumentArchieveStatusLoaded(
    DocumentArchieveSelected event,
    Emitter<DocumentArchieveState> emit,
  ) async {
    emit(const DocumentArchieveState<List<String>>.loading());
    List<String> allStudies = await documentArchieveRepository.getAllStudies();
    emit(DocumentArchieveState<List<String>>.loaded(allStudies));
  }
}
