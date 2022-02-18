import 'package:edc_document_archieve/src/ui/widgets/custom_appbar.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class PidsScreen extends StatelessWidget {
  static const String routeName = kPids;
  const PidsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleName: 'Flourish Study',
        implyLeading: true,
        actionButtons: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: DARK_BLUE,
            ),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.refresh,
          //     color: DARK_BLUE,
          //   ),
          // ),
        ],
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(10),
              height: 80,
              child: ListTile(
                tileColor: Theme.of(context).cardColor,
                leading: const Icon(Icons.person),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusColor: Colors.white,
                style: ListTileStyle.list,
                title: const Text('1234-33232-1223'),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            );
          },
          itemCount: 100),
    );
  }
}
