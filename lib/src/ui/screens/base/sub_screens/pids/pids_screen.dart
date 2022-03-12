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
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recase/recase.dart';

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

  List<StudyDocument>? caregiverDocuments;
  List<StudyDocument>? childDocuments;
  List<String> caregiverPids = [];
  List<String> childPids = [];
  List<GlobalKey<ExpansionTileCardState>> caregiverCardKeyList = [];
  List<GlobalKey<ExpansionTileCardState>> childCardKeyList = [];
  late PersistentTabController _controller;
  late ScrollController _caregiverScrollController;
  late ScrollController _childScrollController;
  bool isNavbarHidden = false;
  int previousIndex = 0;
  int currentIndex = 0;
  final RefreshController _caregiverRefreshController =
      RefreshController(initialRefresh: false);
  final RefreshController _childRefreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    _archieveBloc = Injector.resolve<DocumentArchieveBloc>();
    previousIndex = Get.arguments ?? previousIndex;
    _controller = PersistentTabController(initialIndex: previousIndex);
    _caregiverScrollController = ScrollController();
    _childScrollController = ScrollController();

    // _caregiverScrollController.addListener(listenToScrollDirection);
    // _childScrollController.addListener(listenToScrollDirection);
    super.initState();
  }

  @override
  void dispose() {
    _caregiverScrollController.removeListener(listenToScrollDirection);
    _childScrollController.removeListener(listenToScrollDirection);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _appService = context.watch<AppService>();
    _archieveBloc.getDocumentArchievePids(
        selectedStudy: _appService.selectedStudy);
    super.didChangeDependencies();
  }

  void listenToScrollDirection() {
    switch (_controller.index) {
      case 0:
        final ScrollDirection direction =
            _caregiverScrollController.position.userScrollDirection;
        if (direction == ScrollDirection.forward) {
          hideBottomNavBar();
        } else if (direction == ScrollDirection.reverse) {
          showBottomNavBar();
        }
        break;
      case 2:
        final ScrollDirection direction =
            _childScrollController.position.userScrollDirection;
        if (direction == ScrollDirection.forward) {
          hideBottomNavBar();
        } else if (direction == ScrollDirection.reverse) {
          showBottomNavBar();
        }
        break;
      default:
    }
  }

  void showBottomNavBar() {
    setState(() => isNavbarHidden = true);
  }

  void hideBottomNavBar() {
    setState(() => isNavbarHidden = false);
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
              caregiverDocuments = state.data[kCaregiverForms];
              childDocuments = state.data[kChildForms];

              for (int i = 0; i < caregiverPids.length; i++) {
                caregiverCardKeyList
                    .add(GlobalKey<ExpansionTileCardState>(debugLabel: '$i'));
              }
              for (int i = 0; i < childPids.length; i++) {
                childCardKeyList
                    .add(GlobalKey<ExpansionTileCardState>(debugLabel: '$i'));
              }
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
            titleName: _appService.selectedStudy.titleCase,
            implyLeading: true,
            actionButtons: [
              IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                      pids: _controller.index == 0 ? caregiverPids : childPids,
                      studyDocuments: _controller.index == 0
                          ? caregiverDocuments
                          : childDocuments,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  color: kDarkBlue,
                ),
              ),

              // TODO: list of pending pids to sync
              // IconButton(
              //     onPressed: () {}, icon: const Icon(Icons.pending_actions))
            ],
          ),
          body: PersistentTabView(
            context,
            screens: [
              ListPids(
                scrollController: _caregiverScrollController,
                pids: caregiverPids,
                onFolderButtonTapped: onFolderButtonTapped,
                studyDocuments: caregiverDocuments,
                cardKeyList: caregiverCardKeyList,
                onLoading: _onLoading,
                onRefresh: _onRefresh,
                refreshController: _caregiverRefreshController,
              ),
              CreatePidScreen(previousIndex: previousIndex),
              ListPids(
                scrollController: _childScrollController,
                pids: childPids,
                onFolderButtonTapped: onFolderButtonTapped,
                studyDocuments: childDocuments,
                cardKeyList: childCardKeyList,
                onLoading: _onLoading,
                onRefresh: _onRefresh,
                refreshController: _childRefreshController,
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
            hideNavigationBar: isNavbarHidden,
            onItemSelected: _onItemSelected,
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
        icon: const Icon(Icons.person_add, color: Colors.black87),
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

  void _onItemSelected(int value) {
    setState(() {
      previousIndex = currentIndex;
      currentIndex = value;
    });
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _caregiverRefreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    setState(() {});
    _caregiverRefreshController.loadComplete();
  }
}
