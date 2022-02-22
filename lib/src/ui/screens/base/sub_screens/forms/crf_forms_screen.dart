import 'package:edc_document_archieve/gen/assets.gen.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:edc_document_archieve/src/services/app_service.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_appbar.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

import 'widgets/gallery_image.dart';

class CRFormScreen extends StatefulWidget {
  static const String routeName = kCrfformRoute;
  const CRFormScreen({Key? key}) : super(key: key);

  @override
  State<CRFormScreen> createState() => _CRFormScreenState();
}

class _CRFormScreenState extends State<CRFormScreen> {
  late String _studyName;
  late StudyDocument _documentForm;
  late String _pid;
  late AppService _appService;

  @override
  void didChangeDependencies() {
    _appService = context.watch<AppService>();
    _studyName = _appService.selectedStudy;
    _documentForm = _appService.selectedStudyDocument;
    _pid = _appService.selectedPid;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double parentHeight = constraints.maxHeight;
        double parentWidth = constraints.maxWidth;
        return Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar: CustomAppBar(
            titleName: '${_studyName.titleCase} Study',
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
                  title: CustomText(
                    text: _documentForm.name.titleCase,
                    fontWeight: FontWeight.bold,
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size(parentWidth, parentHeight / 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(Icons.calendar_today_outlined),
                        const SizedBox(width: 10),
                        CustomText(text: _pid, fontSize: 16),
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
