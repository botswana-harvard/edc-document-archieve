import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'gen/study_document.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 2)
class StudyDocument extends HiveObject {
  @HiveField(1)
  late String name;

  @HiveField(2)
  late String type;

  StudyDocument({
    required this.name,
    required this.type,
  });

  factory StudyDocument.fromJson(Map<String, dynamic> data) =>
      _$StudyDocumentFromJson(data);

  Map<String, dynamic> toJson() => _$StudyDocumentToJson(this);
}
