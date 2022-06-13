import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gen/gallery_item.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 5)
class GalleryItem {
  GalleryItem({
    required this.id,
    required this.imageUrl,
  });

  // id image (image url) to use in hero animation
  @HiveField(1)
  final String id;
  // image url
  @HiveField(2)
  final String imageUrl;

  factory GalleryItem.fromJson(Map<String, dynamic> data) =>
      _$GalleryItemFromJson(data);

  Map<String, dynamic> toJson() => _$GalleryItemToJson(this);
}
