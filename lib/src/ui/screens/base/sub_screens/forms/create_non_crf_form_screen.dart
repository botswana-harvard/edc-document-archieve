import 'dart:io';

import 'package:edc_document_archieve/gen/assets.gen.dart';
import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/core/models/participant_non_crf.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:edc_document_archieve/src/services/app_service.dart';
import 'package:edc_document_archieve/src/services/bloc/document_archive_bloc.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/forms/widgets/gallery_image.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_appbar.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text_field.dart';
import 'package:edc_document_archieve/src/ui/widgets/default_button.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

class CreateNonCRFormScreen extends StatefulWidget {
  static const String routeName = kCreateNonCRFormRoute;

  const CreateNonCRFormScreen({Key? key}) : super(key: key);

  @override
  _CreateNonCRFormScreenState createState() => _CreateNonCRFormScreenState();
}

class _CreateNonCRFormScreenState extends State<CreateNonCRFormScreen> {
  late StudyDocument _documentForm;
  late String _pid;
  late AppService _appService;
  late DocumentArchieveBloc _archieveBloc;
  List<XFile>? _imageFileList = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void didChangeDependencies() {
    _appService = context.watch<AppService>();
    _documentForm = _appService.selectedStudyDocument;
    _pid = _appService.selectedPid;
    _archieveBloc = Injector.resolve<DocumentArchieveBloc>();
    _imageFileList = _appService.selectedImages;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _appService.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double parentHeight = constraints.maxHeight;
        double parentWidth = constraints.maxWidth;
        return Scaffold(
          appBar: CustomAppBar(
            titleName: 'Upload ${_documentForm.name}',
            implyLeading: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.all(8.0),
              height: parentHeight,
              width: parentWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: CustomText(text: 'PID Details')),
                  const SizedBox(height: 30),
                  CustomTextField(
                    labelText: _pid,
                    margin: 5,
                    controller: TextEditingController(),
                    readOnly: true,
                    focusNode: FocusNode(),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      text: 'Upload ${_documentForm.name} From',
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          _onImageButtonPressed(ImageSource.gallery);
                        },
                        child: Chip(
                          avatar: const Icon(
                            Icons.photo_library_rounded,
                            color: kDarkBlue,
                          ),
                          label: CustomText(
                              text: kGallery.titleCase, fontSize: 17),
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _onImageButtonPressed(ImageSource.camera);
                        },
                        child: Chip(
                          avatar: const Icon(
                            Icons.add_a_photo_outlined,
                            color: kDarkBlue,
                          ),
                          label:
                              CustomText(text: kCamera.titleCase, fontSize: 17),
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomText(
                      text: 'Attachments',
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GalleryImage(
                      titleGallery: 'Uploaded Images',
                      imageUrls: _imageFileList!.map((e) => e.path).toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: DefaultButton(
            buttonName: kUpload.titleCase,
            onTap: onUploadButtonTapped,
            margin: const EdgeInsets.all(0.0),
            borderRadius: 0,
          ),
        );
      },
    );
  }

  void onDropdownFiledChanged(String? value) {}

  void onUploadButtonTapped() {}

  void _onImageButtonPressed(ImageSource source) async {
    switch (source) {
      case ImageSource.gallery:
        try {
          List<XFile>? pickedFileList = await _picker.pickMultiImage(
            imageQuality: 50,
          );
          _appService.selectedImages = pickedFileList;
        } catch (e) {
          logger.e(e);
        }
        break;
      case ImageSource.camera:
        try {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
            imageQuality: 50,
          );
          if (pickedFile != null) {
            _appService.addSelectedImage(pickedFile);
          }
        } catch (e) {
          logger.e(e);
        }
        break;
      default:
    }
  }
}
