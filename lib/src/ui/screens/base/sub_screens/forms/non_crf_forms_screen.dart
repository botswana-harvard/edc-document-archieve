import 'package:edc_document_archieve/gen/assets.gen.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_appbar.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';

import 'widgets/gallery_image.dart';

class NonCRFormScreen extends StatelessWidget {
  static const String routeName = kNonCrfform;
  const NonCRFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double parentHeight = constraints.maxHeight;
        double parentWidth = constraints.maxWidth;
        return Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar: CustomAppBar(
            titleName: 'Flourish Study',
            implyLeading: true,
          ),
          body: Container(
            height: parentHeight,
            color: Theme.of(context).canvasColor,
            width: parentWidth,
            margin: const EdgeInsets.only(top: 20, bottom: 40),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Theme.of(context).cardColor,
                  pinned: true,
                  floating: true,
                  title: const Text(
                    'Omang Forms',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size(parentWidth, parentHeight / 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 10),
                        const Text(
                          '12234-1221-3312',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                            onPressed: () {}, child: const Text('Sync Data')),
                      ],
                    ),
                  ),
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: Theme.of(context).canvasColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Tap to show image"),
                        GalleryImage(
                          titleGallery: 'Uploaded Images',
                          imageUrls: [
                            Assets.images.test.snapshot2.path,
                            Assets.images.test.snapshot3.path,
                            Assets.images.test.snapshot4.path,
                            Assets.images.test.snapshot5.path,
                            Assets.images.test.snapshot6.path,
                            Assets.images.test.snapshot7.path,
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.grey[600],
            child: const Icon(
              Icons.add_a_photo,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  void onFolderButtonTapped(BuildContext context) {
    //TODO
  }
}
