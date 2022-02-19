import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/pids/sub_screens/create_pid_screen.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_appbar.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PidsScreen extends StatefulWidget {
  static const String routeName = kPidsRoute;
  const PidsScreen({Key? key}) : super(key: key);

  @override
  State<PidsScreen> createState() => _PidsScreenState();
}

class _PidsScreenState extends State<PidsScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> forms = [
      'Lab Results',
      'Omang Forms',
      'Clinician Notes',
      'Speciment Forms'
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: CustomAppBar(
        titleName: 'Flourish Study',
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
              title: const Text(
                '1234-33232-1223',
                style: TextStyle(
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
        itemCount: 100,
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
  }

  void onFolderButtonTapped() {
    Get.toNamed(kCrfformRoute);
  }

  void showNewPidDialog() {
    Get.dialog(const CreatePidScreen());
  }
}
