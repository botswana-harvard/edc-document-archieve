import 'package:edc_document_archieve/gen/assets.gen.dart';
import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:edc_document_archieve/src/services/app_service.dart';
import 'package:edc_document_archieve/src/services/bloc/document_archive_bloc.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_appbar.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/forms/widgets/gallery_image.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

class NonCRFormScreen extends StatefulWidget {
  static const String routeName = kNonCrfformRoute;
  const NonCRFormScreen({Key? key}) : super(key: key);

  @override
  State<NonCRFormScreen> createState() => _NonCRFormScreenState();
}

class _NonCRFormScreenState extends State<NonCRFormScreen> {
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
                  title: Text(
                    _documentForm.name.titleCase,
                    style: const TextStyle(
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
                        Text(
                          _pid,
                          style: const TextStyle(
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
    Get.toNamed(kCreateNonCRFormRoute);
  }
}
