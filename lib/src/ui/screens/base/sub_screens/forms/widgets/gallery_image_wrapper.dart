import 'dart:io';

import 'package:edc_document_archieve/src/core/models/gallery_item.dart';
import 'package:edc_document_archieve/src/services/app_service.dart';
import 'package:edc_document_archieve/src/utils/constants/back.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

// to view image in full screen
class GalleryImageViewWrapper extends StatefulWidget {
  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final int? initialIndex;
  final PageController pageController;
  final List<GalleryItem> galleryItems;
  final Axis scrollDirection;
  final String? titleGallery;

  GalleryImageViewWrapper({
    Key? key,
    this.loadingBuilder,
    this.titleGallery,
    this.backgroundDecoration,
    this.initialIndex,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  })  : pageController = PageController(initialPage: initialIndex ?? 0),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GalleryImageViewWrapperState();
  }
}

class _GalleryImageViewWrapperState extends State<GalleryImageViewWrapper> {
  final minScale = PhotoViewComputedScale.contained * 0.8;
  final maxScale = PhotoViewComputedScale.covered * 8;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AppService _appService;

  @override
  void didChangeDependencies() {
    _appService = context.watch<AppService>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    logger.e(Get.currentRoute);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.titleGallery ?? 'Galley'),
        actions: [
          if (Get.previousRoute != kCrfformRoute &&
              Get.previousRoute != kNonCrfformRoute)
            IconButton(
              onPressed: () {
                int index = widget.initialIndex ?? 0;
                String id = widget.galleryItems[index].id;
                _appService.removeSelectedImage(id);
                back();
              },
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: _buildImage,
          itemCount: widget.galleryItems.length,
          loadingBuilder: widget.loadingBuilder,
          backgroundDecoration: widget.backgroundDecoration,
          pageController: widget.pageController,
          scrollDirection: widget.scrollDirection,
        ),
      ),
    );
  }

// build image with zooming
  PhotoViewGalleryPageOptions _buildImage(BuildContext context, int index) {
    final GalleryItem item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions.customChild(
      child: kIsWeb
          ? Image.network(item.imageUrl)
          : Image.file(File(item.imageUrl)),
      initialScale: PhotoViewComputedScale.contained,
      minScale: minScale,
      maxScale: maxScale,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }
}
