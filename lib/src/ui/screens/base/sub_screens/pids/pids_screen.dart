import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/services/app_service.dart';
import 'package:edc_document_archieve/src/services/bloc/document_archive_bloc.dart';
import 'package:edc_document_archieve/src/services/bloc/states/document_archive_state.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/pids/sub_screens/create_pid_screen.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_appbar.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/debugLog.dart';
import 'package:edc_document_archieve/src/utils/dialogs.dart';
import 'package:edc_document_archieve/src/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PidsScreen extends StatefulWidget {
  static const String routeName = kPidsRoute;

  PidsScreen({Key? key}) : super(key: key);

  @override
  State<PidsScreen> createState() => _PidsScreenState();
}

class _PidsScreenState extends State<PidsScreen> {
  late AppService _appService;
  late DocumentArchieveBloc _archieveBloc;

  late List<String> forms;
  late List<String> pids;

  @override
  void initState() {
    _archieveBloc = Injector.resolve<DocumentArchieveBloc>();
    forms = [];
    pids = [];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _appService = context.watch<AppService>();
    _archieveBloc.getDocumentArchievePids(
      selectedStudy: _appService.selectedStudy,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocumentArchieveBloc, DocumentArchieveState>(
      bloc: _archieveBloc,
      listener: (BuildContext context, DocumentArchieveState state) {
        switch (state.status) {
          case DocumentArchieveStatus.loading:
            Dialogs.showLoadingDialog(context, message: 'Loading PIDs...');
            break;
          case DocumentArchieveStatus.success:
            if (state.data != null) {
              pids = state.data[kParticipants].reversed.toList();
              forms = state.data[kForms];
            }
            Dialogs.closeLoadingDialog(context);
            break;
          case DocumentArchieveStatus.error:
            Dialogs.closeLoadingDialog(context);
            break;
          default:
        }
      },
      builder: (BuildContext context, DocumentArchieveState state) {
        return Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar: CustomAppBar(
            titleName: _appService.selectedStudy,
            implyLeading: true,
            actionButtons: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: kDarkBlue,
                ),
              ),
            ],
          ),
          body: ListView.separated(
            separatorBuilder: (context, index) {
              return Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 1.5,
                  width: MediaQuery.of(context).size.width,
                  child: const Divider(
                    thickness: 1,
                  ),
                ),
              );
            },
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: ExpansionTile(
                  leading: const Icon(
                    Icons.folder,
                    size: 30,
                  ),
                  title: Text(
                    pids[index],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    ...forms.map((form) => Container(
                          padding: const EdgeInsets.all(10),
                          height: 80,
                          child: ListTile(
                            tileColor: Theme.of(context).canvasColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusColor: Colors.white,
                            style: ListTileStyle.list,
                            title: Text(form),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: onFolderButtonTapped,
                          ),
                        )),
                  ],
                ),
              );
            },
            itemCount: pids.length,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: showNewPidDialog,
            child: const Icon(
              Icons.add,
              color: kWhiteColor,
              size: 40,
            ),
          ),
        );
      },
    );
  }

  void onFolderButtonTapped() {
    Get.toNamed(kCrfformRoute);
  }

  void showNewPidDialog() {
    Get.dialog(const CreatePidScreen());
  }
}
