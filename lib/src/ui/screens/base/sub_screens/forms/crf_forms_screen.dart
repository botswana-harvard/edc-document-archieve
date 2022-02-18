import 'package:edc_document_archieve/src/ui/widgets/custom_appbar.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';

import 'widgets/gallery_image.dart';

class CRFormScreen extends StatelessWidget {
  static const String routeName = kCrfform;
  const CRFormScreen({Key? key}) : super(key: key);

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
                    'Lab Results Forms',
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
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      color: Theme.of(context).canvasColor,
                      child: ExpansionTile(
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Visit $index',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Timepoint $index',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              )
                            ]),
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Text("Tap to show image"),
                              GalleryImage(
                                titleGallery: 'Uploaded Images',
                                imageUrls: [
                                  'assets/images/test/snapshot2.jpeg',
                                  'assets/images/test/snapshot3.jpeg',
                                  'assets/images/test/snapshot4.jpeg',
                                  'assets/images/test/snapshot5.jpeg',
                                  'assets/images/test/snapshot6.jpeg',
                                  'assets/images/test/snapshot7.jpeg',
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }, childCount: 15),
                ),
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
