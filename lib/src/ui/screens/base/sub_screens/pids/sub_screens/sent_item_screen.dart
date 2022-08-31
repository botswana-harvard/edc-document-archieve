import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/core/models/item.dart';
import 'package:edc_document_archieve/src/services/app_service.dart';
import 'package:edc_document_archieve/src/services/bloc/document_archive_bloc.dart';
import 'package:edc_document_archieve/src/services/bloc/states/document_archive_state.dart';
import 'package:edc_document_archieve/src/services/sent_item_service.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:recase/recase.dart';

class SentItemScreen extends StatefulWidget {
  const SentItemScreen({Key? key}) : super(key: key);

  @override
  State<SentItemScreen> createState() => _SentItemScreenState();
}

class _SentItemScreenState extends State<SentItemScreen> {
  final _archieveBloc = Injector.resolve<DocumentArchieveBloc>();
  late AppService _appService;
  late SentItemService _sentItemService;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _appService = context.watch<AppService>();
    _sentItemService = context.watch<SentItemService>()..initItems();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.check),
                text: 'Sent Items',
              ),
              Tab(
                icon: Icon(Icons.cloud_sync_outlined),
                text: 'Pending Sync',
              ),
            ],
          ),
        ),
        body: BlocConsumer<DocumentArchieveBloc, DocumentArchieveState>(
          bloc: _archieveBloc,
          listener: (BuildContext context, DocumentArchieveState state) {},
          builder: (BuildContext context, DocumentArchieveState state) {
            return TabBarView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.check, color: Colors.green),
                        title: Text(
                            '${_sentItemService.sentItems[index].pid} - ${_sentItemService.sentItems[index].modelName.titleCase}'),
                        subtitle: Text(
                            'Sent on ${_sentItemService.sentItems[index].created}'),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: _sentItemService.sentItems.length,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.cloud_off_outlined,
                            color: Colors.red),
                        title: Text(
                            '${_sentItemService.pendingItems[index].pid} - ${_sentItemService.pendingItems[index].modelName.titleCase}'),
                        subtitle: Text(
                            'Added on ${_sentItemService.pendingItems[index].created}'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          _appService.selectedStudyDocument =
                              _sentItemService.pendingItems[index].document;
                          _appService.selectedPid =
                              _sentItemService.pendingItems[index].pid;
                          switch (_sentItemService
                              .pendingItems[index].document.type) {
                            case kCrfForm:
                              Get.toNamed(kCrfformRoute);
                              break;
                            case kNonCrfForm:
                              Get.toNamed(kNonCrfformRoute);
                              break;
                            default:
                          }
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: _sentItemService.pendingItems.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
