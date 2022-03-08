import 'package:edc_document_archieve/src/utils/enums.dart';
import 'package:flutter_uploader/flutter_uploader.dart';

class UploadItem {
  final String id;
  final String tag;
  final MediaType type;
  final int progress;
  final UploadTaskStatus status;

  UploadItem({
    required this.id,
    required this.tag,
    required this.type,
    this.progress = 0,
    this.status = UploadTaskStatus.undefined,
  });

  UploadItem copyWith({UploadTaskStatus? statusT, int? progressT}) =>
      UploadItem(
        id: id,
        tag: tag,
        type: type,
        status: statusT ?? status,
        progress: progressT ?? progress,
      );

  bool isCompleted() =>
      status == UploadTaskStatus.canceled ||
      status == UploadTaskStatus.complete ||
      status == UploadTaskStatus.failed;
}
