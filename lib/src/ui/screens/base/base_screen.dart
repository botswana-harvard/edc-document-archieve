import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/services/app_service.dart';
import 'package:edc_document_archieve/src/services/bloc/document_archive_bloc.dart';
import 'package:edc_document_archieve/src/services/bloc/events/document_archive_event.dart';
import 'package:edc_document_archieve/src/services/bloc/states/document_archive_state.dart';
import 'package:edc_document_archieve/src/ui/screens/base/widgets/study_container.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_appbar.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/dialogs.dart';
import 'package:edc_document_archieve/src/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

// ignore: must_be_immutable
class BaseScreen extends StatelessWidget {
  static const String routeName = kBaseRoute;

  BaseScreen({Key? key}) : super(key: key);

  late List<String>? availableStudies = [];
  final DocumentArchieveBloc _documentArchieveBloc =
      Injector.resolve<DocumentArchieveBloc>();
  late AppService _appService;

  @override
  Widget build(BuildContext context) {
    //
    _appService = Provider.of<AppService>(context);
    //
    return BlocConsumer<DocumentArchieveBloc, DocumentArchieveState>(
      bloc: _documentArchieveBloc,
      builder: (BuildContext context, DocumentArchieveState state) {
        if (availableStudies == null || availableStudies!.isEmpty) {
          _documentArchieveBloc.add(DocumentArchieveSelected());
        }
        return LayoutBuilder(
          builder: (context, constraints) {
            double parentHeight = constraints.maxHeight;
            double parentWidth = constraints.maxWidth;
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: CustomAppBar(
                titleName: kAppName.toUpperCase(),
              ),
              body: Container(
                color: Colors.white,
                height: parentHeight / 2,
                width: parentWidth,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 100,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.grey[100],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      const CustomText(
                        text: 'Select Study',
                        fontSize: 30,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 30),
                      ...availableStudies!
                          .map(
                            (studyName) => Column(
                              children: [
                                CustomStudyCard(
                                  cardColor: Colors.lightBlue[300],
                                  onTap: () => onStudySeleted(studyName),
                                  studyName: studyName.titleCase,
                                ),
                                const SizedBox(height: 30),
                              ],
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      listener: (BuildContext context, DocumentArchieveState state) {
        switch (state.status) {
          case DocumentArchieveStatus.success:
            Dialogs.closeLoadingDialog(context);
            availableStudies = state.data;
            break;
          case DocumentArchieveStatus.error:
            Dialogs.closeLoadingDialog(context);
            Get.showSnackbar(const GetSnackBar(title: 'Error'));
            break;
          case DocumentArchieveStatus.loading:
            Dialogs.showLoadingDialog(context, message: 'fetching studies...');
            break;
          default:
        }
      },
    );
  }

  void onStudySeleted(String studySelected) {
    _appService.selectedStudy = studySelected;
    Get.toNamed(kPidsRoute);
  }
}
