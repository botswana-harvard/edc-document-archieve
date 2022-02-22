import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'participant_non_crf.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 4)
class ParticipantNonCrf extends HiveObject {
  @HiveField(1)
  late String pid;

  @HiveField(2)
  late StudyDocument document;

  @HiveField(3)
  late List<String> uploads;

  ParticipantNonCrf({
    required this.pid,
    required this.document,
    required this.uploads,
  });

  factory ParticipantNonCrf.fromJson(Map<String, dynamic> data) =>
      _$ParticipantNonCrfFromJson(data);

  Map<String, dynamic> toJson() => _$ParticipantNonCrfToJson(this);
}
