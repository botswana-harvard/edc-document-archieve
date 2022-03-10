import 'package:cool_alert/cool_alert.dart';
import 'package:edc_document_archieve/gen/fonts.gen.dart';
import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/core/models/gallery_item.dart';
import 'package:edc_document_archieve/src/core/models/participant_non_crf.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:edc_document_archieve/src/services/app_service.dart';
import 'package:edc_document_archieve/src/services/bloc/document_archive_bloc.dart';
import 'package:edc_document_archieve/src/services/bloc/states/document_archive_state.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_appbar.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/forms/widgets/gallery_image.dart';
import 'package:edc_document_archieve/src/utils/constants/back.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/dialogs.dart';
import 'package:edc_document_archieve/src/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
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
  late DocumentArchieveBloc _archieveBloc;
  ParticipantNonCrf? _participantNonCrf;
  List<GalleryItem> uploads = [];

  @override
  void didChangeDependencies() {
    _appService = context.watch<AppService>();
    _studyName = _appService.selectedStudy;
    _documentForm = _appService.selectedStudyDocument;
    _pid = _appService.selectedPid;
    _archieveBloc = Injector.resolve<DocumentArchieveBloc>();
    _archieveBloc.getParticipantForms(documentForm: _documentForm, pid: _pid);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double parentHeight = constraints.maxHeight;
        double parentWidth = constraints.maxWidth;
        return BlocConsumer<DocumentArchieveBloc, DocumentArchieveState>(
          bloc: _archieveBloc,
          listener: (BuildContext context, DocumentArchieveState state) {
            switch (state.status) {
              case DocumentArchieveStatus.loading:
                Dialogs.showLoadingDialog(context);
                break;
              case DocumentArchieveStatus.success:
                Dialogs.closeLoadingDialog(context);
                _participantNonCrf = state.data;
                if (_participantNonCrf != null) {
                  uploads = _participantNonCrf!.uploads;
                } else {
                  uploads = [];
                }
                break;
              default:
            }
          },
          builder: (BuildContext context, DocumentArchieveState state) {
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
                                onPressed: () {
                                  _archieveBloc.syncNonCrfData(
                                    nonCrf: _participantNonCrf!,
                                    currentUser: _appService.currentUser,
                                  );
                                },
                                child: const Text('Sync Data')),
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
                        child: _participantNonCrf != null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text("Tap to show image"),
                                  GalleryImage(
                                    titleGallery: 'Uploaded Images',
                                    imageUrls: uploads,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: onUpdateButtonPressed,
                                        child: const Text(
                                          'Update',
                                          style: TextStyle(
                                            fontFamily: FontFamily.robotoSlab,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: onDeleteButtonPressed,
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: FontFamily.robotoSlab,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            : const SizedBox.shrink(),
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
      },
    );
  }

  void onFolderButtonTapped() {
    _appService.clear();
    Get.toNamed(kCreateNonCRFormRoute);
  }

  void onUpdateButtonPressed() {
    _appService.selectedImages = _participantNonCrf!.uploads;
    Get.toNamed(kCreateNonCRFormRoute, arguments: _participantNonCrf);
  }

  void onConfirmDeleteButtonPressed() {
    back();
    _archieveBloc.deleteForm(crf: _participantNonCrf);
  }

  void onDeleteButtonPressed() {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.confirm,
      text: 'Are you sure you want to delete this form?',
      title: 'Delete ${_participantNonCrf!.document.name}',
      onConfirmBtnTap: onConfirmDeleteButtonPressed,
    );
  }
}
