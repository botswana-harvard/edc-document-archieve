import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gen/item.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 6)
class Item {
  Item({
    required this.pid,
    required this.modelName,
    required this.status,
    required this.created,
    required this.document,
  });

  // id image (image url) to use in hero animation
  @HiveField(1)
  final String pid;
  // image url
  @HiveField(2)
  final String modelName;

  @HiveField(3)
  final String created;

  @HiveField(4)
  final String status;

  @HiveField(5)
  final StudyDocument document;

  factory Item.fromJson(Map<String, dynamic> data) => _$ItemFromJson(data);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
