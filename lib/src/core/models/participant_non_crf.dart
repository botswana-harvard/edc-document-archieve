import 'package:edc_document_archieve/src/core/models/gallery_item.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
part 'gen/participant_non_crf.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 4)
class ParticipantNonCrf extends HiveObject with EquatableMixin {
  @HiveField(1)
  late String pid;

  @HiveField(2)
  late StudyDocument document;

  @HiveField(3)
  late List<GalleryItem> uploads;

  @HiveField(4)
  late String id;

  @HiveField(5)
  String appName;

  @HiveField(6)
  String created;

  @HiveField(7)
  String? version;

  ParticipantNonCrf({
    required this.pid,
    required this.document,
    required this.uploads,
    required this.id,
    required this.appName,
    required this.created,
    this.version,
  });

  factory ParticipantNonCrf.fromJson(Map<String, dynamic> data) =>
      _$ParticipantNonCrfFromJson(data);

  Map<String, dynamic> toJson() => _$ParticipantNonCrfToJson(this);

  @override
  List<Object?> get props => [pid, document];
}
