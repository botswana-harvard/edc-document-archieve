import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'participant_crf.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 1)
class ParticipantCrf extends HiveObject {
  @HiveField(1)
  late String pid;

  @HiveField(2)
  late String visit;

  @HiveField(3)
  late String timepoint;

  @HiveField(4)
  late StudyDocument document;

  @HiveField(5)
  late List<String> uploads;

  ParticipantCrf({
    required this.pid,
    required this.visit,
    required this.timepoint,
    required this.document,
    required this.uploads,
  });

  factory ParticipantCrf.fromJson(Map<String, dynamic> data) =>
      _$ParticipantCrfFromJson(data);

  Map<String, dynamic> toJson() => _$ParticipantCrfToJson(this);
}
