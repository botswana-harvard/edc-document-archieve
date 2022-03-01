import 'dart:io';

import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/core/data/dummy_data.dart';
import 'package:edc_document_archieve/src/services/app_service.dart';
import 'package:edc_document_archieve/src/services/bloc/document_archive_bloc.dart';
import 'package:edc_document_archieve/src/services/bloc/states/document_archive_state.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/forms/widgets/gallery_image.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_appbar.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text_field.dart';
import 'package:edc_document_archieve/src/ui/widgets/default_button.dart';
import 'package:edc_document_archieve/src/ui/widgets/dropdown_field.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';
import 'package:edc_document_archieve/src/utils/dialogs.dart';
import 'package:edc_document_archieve/src/utils/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recase/recase.dart';

class CreateCRFormScreen extends StatefulWidget {
  static const String routeName = kCreateCRFormRoute;

  const CreateCRFormScreen({Key? key}) : super(key: key);

  @override
  _CreateCRFormScreenState createState() => _CreateCRFormScreenState();
}

class _CreateCRFormScreenState extends State<CreateCRFormScreen> {
  late DocumentArchieveBloc _archieveBloc;
  late AppService _appService;
  late String selectedDocumentName;
  late String selectedPid;
  String? selectedVisitCode;
  String? selectedTimePoint;
  List<XFile>? _imageFileList = [];
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    _archieveBloc = Injector.resolve<DocumentArchieveBloc>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _appService = context.watch<AppService>();
    selectedDocumentName = _appService.selectedStudyDocument.name;
    selectedPid = _appService.selectedPid;
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
            titleName: 'Upload $selectedDocumentName',
            implyLeading: true,
          ),
          body: BlocConsumer<DocumentArchieveBloc, DocumentArchieveState>(
            bloc: _archieveBloc,
            listener: (context, state) {
              switch (state.status) {
                case DocumentArchieveStatus.loading:
                  Dialogs.showLoadingDialog(context);
                  break;
                default:
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
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
                        labelText: selectedPid,
                        margin: 5,
                        controller: TextEditingController(),
                        readOnly: true,
                      ),
                      const SizedBox(height: 30),
                      Form(
                        key: _key,
                        child: Column(
                          children: [
                            DropDownFormField(
                              dataSource: visitCodeChoice,
                              onChanged: onDropdownVisitCodeChanged,
                              titleText: kVisitCode.titleCase,
                              value: selectedVisitCode,
                            ),
                            const SizedBox(height: 30),
                            DropDownFormField(
                              dataSource: timepointChoice,
                              onChanged: onDropdownTimePointChanged,
                              titleText: kTimePoint.titleCase,
                              value: selectedTimePoint,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: 'Upload $selectedDocumentName From',
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
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
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
                              label: CustomText(
                                  text: kCamera.titleCase, fontSize: 17),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
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
                          imageUrls:
                              _imageFileList!.map((e) => e.path).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
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

  void onUploadButtonTapped() {
    if (_key.currentState!.validate() && _imageFileList!.isNotEmpty) {
      List<String> images = _imageFileList!.map((e) => e.path).toList();
      _archieveBloc.addCrfDocument(
        pid: selectedPid,
        visitCode: selectedVisitCode!,
        timePoint: selectedTimePoint!,
        uploads: images,
        studyDocument: _appService.selectedStudyDocument,
      );
    }
  }

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

  void onDropdownVisitCodeChanged(String? value) {
    setState(() {
      selectedVisitCode = value;
      FocusScope.of(context).unfocus();
    });
  }

  void onDropdownTimePointChanged(String? value) {
    setState(() {
      selectedTimePoint = value;
      FocusScope.of(context).unfocus();
    });
  }
}
