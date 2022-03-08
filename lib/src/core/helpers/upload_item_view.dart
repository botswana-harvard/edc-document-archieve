import 'package:edc_document_archieve/src/core/models/upload_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uploader/flutter_uploader.dart';

typedef CancelUploadCallback = Future<void> Function(String id);

class UploadItemView extends StatelessWidget {
  final UploadItem item;
  final CancelUploadCallback onCancel;

  const UploadItemView({
    Key? key,
    required this.item,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = item.progress.toDouble() / 100;
    final widget = item.status == UploadTaskStatus.running
        ? LinearProgressIndicator(value: progress)
        : const SizedBox.shrink();
    final SizedBox buttonWidget;
    if (item.status == UploadTaskStatus.running) {
      buttonWidget = SizedBox(
        height: 50,
        width: 50,
        child: IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () => onCancel(item.id),
        ),
      );
    } else {
      buttonWidget = const SizedBox.shrink();
    }
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(item.tag),
              Container(
                height: 5.0,
              ),
              Text(item.status.description),
              Container(
                height: 5.0,
              ),
              widget
            ],
          ),
        ),
        buttonWidget
      ],
    );
  }
}
