import 'package:edc_document_archieve/src/core/models/gallery_item.dart';
import 'package:uuid/uuid.dart';

import 'gallery_Item_thumbnail.dart';
import 'gallery_image_wrapper.dart';
import 'package:flutter/material.dart';

class GalleryImage extends StatefulWidget {
  final List<GalleryItem> imageUrls;
  final String? titleGallery;

  const GalleryImage({Key? key, required this.imageUrls, this.titleGallery})
      : super(key: key);
  @override
  _GalleryImageState createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: widget.imageUrls.isEmpty
          ? const SizedBox.shrink()
          : GridView.builder(
              primary: false,
              itemCount:
                  widget.imageUrls.length > 3 ? 3 : widget.imageUrls.length,
              padding: const EdgeInsets.all(0),
              semanticChildCount: 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 0, crossAxisSpacing: 5),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  // if have less than 4 image w build GalleryItemThumbnail
                  // if have mor than 4 build image number 3 with number for other images
                  child: widget.imageUrls.length > 3 && index == 2
                      ? buildImageNumbers(index)
                      : GalleryItemThumbnail(
                          galleryItem: widget.imageUrls[index],
                          onTap: () {
                            openImageFullScreen(index);
                          },
                        ),
                );
              },
            ),
    );
  }

// build image with number for other images
  Widget buildImageNumbers(int index) {
    return GestureDetector(
      onTap: () {
        openImageFullScreen(index);
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: <Widget>[
          GalleryItemThumbnail(
            galleryItem: widget.imageUrls[index],
          ),
          Container(
            color: Colors.black.withOpacity(.7),
            child: Center(
              child: Text(
                "+${widget.imageUrls.length - index}",
                style: const TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }

// to open gallery image in full screen
  void openImageFullScreen(final int indexOfImage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryImageViewWrapper(
          titleGallery: widget.titleGallery,
          galleryItems: widget.imageUrls,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: indexOfImage,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
