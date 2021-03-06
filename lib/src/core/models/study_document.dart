import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
part 'gen/study_document.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 2)
class StudyDocument extends HiveObject with EquatableMixin {
  @HiveField(1)
  late String name;

  @HiveField(2)
  late String type;

  @HiveField(3)
  late String id;

  @HiveField(4)
  late String pidType;

  @HiveField(5)
  late String appName;

  StudyDocument({
    required this.name,
    required this.type,
    required this.id,
    required this.pidType,
    required this.appName,
  });

  factory StudyDocument.fromJson(Map<String, dynamic> data) =>
      _$StudyDocumentFromJson(data);

  Map<String, dynamic> toJson() => _$StudyDocumentToJson(this);

  @override
  List<Object?> get props => [id];
}
