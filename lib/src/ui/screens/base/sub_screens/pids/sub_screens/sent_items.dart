import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/services/bloc/document_archive_bloc.dart';
import 'package:edc_document_archieve/src/services/bloc/states/document_archive_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';

class SentItemScreen extends StatelessWidget {
  SentItemScreen({Key? key}) : super(key: key);

  final _archieveBloc = Injector.resolve<DocumentArchieveBloc>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                            '${_archieveBloc.sentItems[index].pid} - ${_archieveBloc.sentItems[index].form.titleCase}'),
                        subtitle: Text(
                            'Sent on ${_archieveBloc.sentItems[index].created}'),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: _archieveBloc.sentItems.length,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.cloud_off_outlined,
                            color: Colors.red),
                        title: const Text('150-222-333-032 - Clinician Notes'),
                        subtitle: const Text('Added on 26/08/202 12:45'),
                        trailing: Checkbox(
                          value: false,
                          onChanged: (value) {},
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: 20,
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: Container(
          height: 50,
          child: const ElevatedButton(
            child:
                Text('Synchronise data', style: TextStyle(color: Colors.blue)),
            onPressed: null,
          ),
        ),
      ),
    );
  }
}
