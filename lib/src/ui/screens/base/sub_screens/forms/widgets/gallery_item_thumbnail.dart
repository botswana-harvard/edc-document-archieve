import 'package:edc_document_archieve/src/core/models/gallery_item.dart';
import 'package:flutter/material.dart';

// to show image in Row
class GalleryItemThumbnail extends StatelessWidget {
  const GalleryItemThumbnail({Key? key, required this.galleryItem, this.onTap})
      : super(key: key);

  final GalleryItem galleryItem;

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: galleryItem.id,
        child: Image.asset(
          galleryItem.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
