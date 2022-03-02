import 'package:cool_alert/cool_alert.dart';
import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/core/data/dummy_data.dart';
import 'package:edc_document_archieve/src/core/models/participant_crf.dart';
import 'package:edc_document_archieve/src/services/app_service.dart';
import 'package:edc_document_archieve/src/services/bloc/document_archive_bloc.dart';
import 'package:edc_document_archieve/src/services/bloc/states/document_archive_state.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/forms/widgets/gallery_image.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_appbar.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text_field.dart';
import 'package:edc_document_archieve/src/ui/widgets/default_button.dart';
import 'package:edc_document_archieve/src/ui/widgets/dropdown_field.dart';
import 'package:edc_document_archieve/src/utils/constants/back.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';
import 'package:edc_document_archieve/src/utils/dialogs.dart';
import 'package:edc_document_archieve/src/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
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
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  List<String> uploads = [];
  ParticipantCrf? crf = Get.arguments;

  @override
  void initState() {
    _archieveBloc = Injector.resolve<DocumentArchieveBloc>();
    if (crf != null) {
      selectedVisitCode = crf!.visit;
      selectedTimePoint = crf!.timepoint;
      uploads = crf!.uploads;
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _appService = context.watch<AppService>();
    selectedDocumentName = _appService.selectedStudyDocument.name;
    selectedPid = _appService.selectedPid;
    if (_appService.selectedImages.isNotEmpty) {
      uploads = _appService.selectedImages;
    }
    super.didChangeDependencies();
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
            listener: (context, state) async {
              switch (state.status) {
                case DocumentArchieveStatus.loading:
                  Dialogs.showLoadingDialog(context);
                  break;
                case DocumentArchieveStatus.success:
                  Dialogs.closeLoadingDialog(context);
                  await CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    text: 'Crf form uploaded successfully!',
                    autoCloseDuration: const Duration(seconds: 3),
                  );
                  _appService.notifyWidgetListeners();
                  back();
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
                          imageUrls: uploads,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          bottomNavigationBar: DefaultButton(
            buttonName: crf != null ? kUpdate.titleCase : kUpload.titleCase,
            onTap: onUploadButtonTapped,
            margin: const EdgeInsets.all(0.0),
            borderRadius: 0,
          ),
        );
      },
    );
  }

  void onUploadButtonTapped() {
    if (_key.currentState!.validate() && uploads.isNotEmpty) {
      if (crf != null) {
        _archieveBloc.updateCrfDocument(
          visitCode: selectedVisitCode!,
          timePoint: selectedTimePoint!,
          uploads: uploads,
          crf: crf!,
        );
      } else {
        _archieveBloc.addCrfDocument(
          pid: selectedPid,
          visitCode: selectedVisitCode!,
          timePoint: selectedTimePoint!,
          uploads: uploads,
          studyDocument: _appService.selectedStudyDocument,
        );
      }
    }
  }

  void _onImageButtonPressed(ImageSource source) async {
    switch (source) {
      case ImageSource.gallery:
        try {
          List<XFile>? pickedFileList = await _picker.pickMultiImage(
            imageQuality: 50,
          );
          _appService.addAllImages(pickedFileList!.map((e) => e.path).toList());
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
            _appService.addSelectedImage(pickedFile.path);
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
