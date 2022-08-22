import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gen/item.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 6)
class Item {
  Item({
    required this.pid,
    required this.form,
    required this.status,
    required this.created,
  });

  // id image (image url) to use in hero animation
  @HiveField(1)
  final String pid;
  // image url
  @HiveField(2)
  final String form;

  @HiveField(3)
  final String created;

  @HiveField(4)
  final String status;

  factory Item.fromJson(Map<String, dynamic> data) => _$ItemFromJson(data);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
