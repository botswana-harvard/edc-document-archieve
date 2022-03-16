import 'dart:async';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:edc_document_archieve/gen/fonts.gen.dart';
import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/core/models/gallery_item.dart';
import 'package:edc_document_archieve/src/core/models/participant_crf.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:edc_document_archieve/src/services/app_service.dart';
import 'package:edc_document_archieve/src/services/bloc/document_archive_bloc.dart';
import 'package:edc_document_archieve/src/services/bloc/states/document_archive_state.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/forms/widgets/gallery_image.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_appbar.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text.dart';
import 'package:edc_document_archieve/src/utils/constants/back.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';
import 'package:edc_document_archieve/src/utils/dialogs.dart';
import 'package:edc_document_archieve/src/utils/enums.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:recase/recase.dart';

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
  late DocumentArchieveBloc _archieveBloc;
  List<ParticipantCrf> _partcipantCrfs = [];
  List<GlobalKey<ExpansionTileCardState>> cardKeyList = [];

  @override
  void didChangeDependencies() {
    _appService = context.watch<AppService>();
    _studyName = _appService.selectedStudy;
    _documentForm = _appService.selectedStudyDocument;
    _pid = _appService.selectedPid;
    _archieveBloc = Injector.resolve<DocumentArchieveBloc>();
    _archieveBloc.getParticipantForms(pid: _pid, documentForm: _documentForm);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocumentArchieveBloc, DocumentArchieveState>(
      bloc: _archieveBloc,
      listener: (BuildContext context, DocumentArchieveState state) async {
        switch (state.status) {
          case DocumentArchieveStatus.loading:
            String message = '';
            if (state.data == 'sync') {
              message = 'Synchronizing data...';
            } else {
              message = 'Please Wait...';
            }
            Dialogs.showLoadingDialog(context, message: message);
            break;
          case DocumentArchieveStatus.success:
            Dialogs.closeLoadingDialog(context);
            if (state.data != null) {
              _partcipantCrfs = state.data;
            }
            break;
          case DocumentArchieveStatus.error:
            Dialogs.closeLoadingDialog(context);
            await CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              text: state.data,
            );
            break;
          default:
        }
      },
      builder: (context, state) {
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
                                onPressed: () async {
                                  if (_partcipantCrfs.isEmpty) {
                                    await CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.info,
                                      text: 'No records to sync',
                                      title: _documentForm.name.titleCase,
                                    );
                                  } else {
                                    _archieveBloc.syncCrfsData(
                                      partcipantCrfs: _partcipantCrfs,
                                      selectedStudy: _appService.selectedStudy,
                                    );
                                  }
                                },
                                child: const Text('Sync Data')),
                          ],
                        ),
                      ),
                      automaticallyImplyLeading: false,
                      centerTitle: true,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        String visit = _partcipantCrfs[index].visit;
                        String timepoint = _partcipantCrfs[index].timepoint;
                        List<GalleryItem> uploads =
                            _partcipantCrfs[index].uploads;
                        cardKeyList.add(GlobalKey<ExpansionTileCardState>(
                            debugLabel: '$index'));
                        return Container(
                          padding: const EdgeInsets.all(10),
                          color: Theme.of(context).canvasColor,
                          child: ExpansionTileCard(
                            key: cardKeyList[index],
                            onExpansionChanged: (value) {
                              if (value) {
                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  for (var i = 0; i < cardKeyList.length; i++) {
                                    if (index != i) {
                                      cardKeyList[i].currentState?.collapse();
                                    }
                                  }
                                });
                              }
                            },
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Visit: ${visit.substring(1)}',
                                  fontSize: 18,
                                ),
                                CustomText(
                                  text: 'Timepoint: $timepoint',
                                  fontSize: 16,
                                ),
                              ],
                            ),
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  if (uploads.isNotEmpty)
                                    const Text("Tap to show image"),
                                  GalleryImage(
                                    titleGallery: 'Uploaded Images',
                                    imageUrls: uploads,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () => onUpdateButtonPressed(
                                        _partcipantCrfs[index]),
                                    child: const Text(
                                      'Edit',
                                      style: TextStyle(
                                        fontFamily: FontFamily.robotoSlab,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => onDeleteButtonPressed(
                                        _partcipantCrfs[index]),
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
                          ),
                        );
                      }, childCount: _partcipantCrfs.length),
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
      },
    );
  }

  void onFolderButtonTapped() {
    _appService.clear();
    Get.toNamed(kCreateCRFormRoute);
  }

  void onUpdateButtonPressed(ParticipantCrf crf) {
    _appService.selectedImages = crf.uploads;
    Get.toNamed(kCreateCRFormRoute, arguments: crf);
  }

  void onConfirmDeleteButtonPressed(ParticipantCrf crf) {
    back();
    _archieveBloc.deleteForm(crf: crf);
  }

  void onDeleteButtonPressed(ParticipantCrf crf) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.confirm,
      text: 'Are you sure you want to delete this form?',
      title: 'Delete ${crf.document.name}',
      onConfirmBtnTap: () => onConfirmDeleteButtonPressed(crf),
    );
  }
}
