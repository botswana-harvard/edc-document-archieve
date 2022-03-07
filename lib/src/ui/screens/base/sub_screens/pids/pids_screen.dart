import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:edc_document_archieve/src/services/app_service.dart';
import 'package:edc_document_archieve/src/services/bloc/document_archive_bloc.dart';
import 'package:edc_document_archieve/src/services/bloc/states/document_archive_state.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/pids/sub_screens/create_pid_screen.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/pids/sub_screens/list_pids.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/pids/sub_screens/search_pid_screen.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_appbar.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:edc_document_archieve/src/utils/dialogs.dart';
import 'package:edc_document_archieve/src/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// ignore: must_be_immutable
class PidsScreen extends StatefulWidget {
  static const String routeName = kPidsRoute;

  const PidsScreen({Key? key}) : super(key: key);

  @override
  State<PidsScreen> createState() => _PidsScreenState();
}

class _PidsScreenState extends State<PidsScreen> {
  late AppService _appService;
  late DocumentArchieveBloc _archieveBloc;

  List<StudyDocument>? studyDocuments;
  List<String> caregiverPids = [];
  List<String> childPids = [];
  late PersistentTabController _controller;

  @override
  void initState() {
    _archieveBloc = Injector.resolve<DocumentArchieveBloc>();
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _appService = context.watch<AppService>();
    _archieveBloc.getDocumentArchievePids(
        selectedStudy: _appService.selectedStudy);
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
              caregiverPids = state.data[kCaregiverPid].reversed.toList();
              childPids = state.data[kChildPid].reversed.toList();
              //studyDocuments = state.data[kForms];
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
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                      pids: caregiverPids,
                      studyDocuments: studyDocuments,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  color: kDarkBlue,
                ),
              ),
            ],
          ),
          body: PersistentTabView(
            context,
            screens: [
              ListPids(
                pids: caregiverPids,
                onFolderButtonTapped: onFolderButtonTapped,
                studyDocuments: studyDocuments,
              ),
              const CreatePidScreen(),
              ListPids(
                pids: childPids,
                onFolderButtonTapped: onFolderButtonTapped,
                studyDocuments: studyDocuments,
              )
            ],
            controller: _controller,
            items: _navBarsItems(),
            navBarStyle: NavBarStyle.style15,
            confineInSafeArea: true,
            backgroundColor: Colors.white,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
                ? 0.0
                : kBottomNavigationBarHeight,
            hideNavigationBarWhenKeyboardShows: true,
            margin: const EdgeInsets.all(0.0),
            popActionScreens: PopActionScreensType.all,
            bottomScreenMargin: 0.0,
            decoration: const NavBarDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        );
      },
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.group),
        title: "Caregiver",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add),
        title: ("Add PID"),
        activeColorPrimary: Colors.blueAccent,
        activeColorSecondary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.child_care),
        title: ("Child"),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  void onFolderButtonTapped(StudyDocument document) {
    _appService.selectedStudyDocument = document;
    switch (document.type) {
      case kCrfForm:
        Get.toNamed(kCrfformRoute);
        break;
      case kNonCrfForm:
        Get.toNamed(kNonCrfformRoute);
        break;
      default:
    }
  }

  void showNewPidDialog() {
    Get.dialog(const CreatePidScreen());
  }
}
