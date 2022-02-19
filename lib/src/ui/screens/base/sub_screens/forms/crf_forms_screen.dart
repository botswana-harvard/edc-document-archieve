import 'package:edc_document_archieve/gen/assets.gen.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_appbar.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/gallery_image.dart';

class CRFormScreen extends StatelessWidget {
  static const String routeName = kCrfformRoute;
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
                  title: const CustomText(
                    text: 'Lab Results Forms',
                    fontWeight: FontWeight.bold,
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size(parentWidth, parentHeight / 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(Icons.calendar_today_outlined),
                        const SizedBox(width: 10),
                        const CustomText(text: '12123-212-12', fontSize: 16),
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
                            CustomText(text: 'Visit $index', fontSize: 18),
                            CustomText(text: 'Timepoint $index', fontSize: 16),
                          ],
                        ),
                        children: [
                          Column(
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
                        ],
                      ),
                    );
                  }, childCount: 15),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: onFolderButtonTapped,
            backgroundColor: kDarkBlue,
            child: const Icon(
              Icons.add_a_photo,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  void onFolderButtonTapped() {
    Get.toNamed(kCreateCRFormRoute);
  }
}
