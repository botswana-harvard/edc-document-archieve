import 'package:edc_document_archieve/gen/assets.gen.dart';
import 'package:edc_document_archieve/src/core/data/dummy_data.dart';
import 'package:edc_document_archieve/src/ui/screens/base/sub_screens/forms/widgets/gallery_image.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_appbar.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text_field.dart';
import 'package:edc_document_archieve/src/ui/widgets/default_button.dart';
import 'package:edc_document_archieve/src/ui/widgets/dropdown_field.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class CreateCRFormScreen extends StatefulWidget {
  static const String routeName = kCreateCRFormRoute;

  const CreateCRFormScreen({Key? key}) : super(key: key);

  @override
  _CreateCRFormScreenState createState() => _CreateCRFormScreenState();
}

class _CreateCRFormScreenState extends State<CreateCRFormScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double parentHeight = constraints.maxHeight;
        double parentWidth = constraints.maxWidth;
        return Scaffold(
          appBar: CustomAppBar(
            titleName: 'Upload Omang Document',
            implyLeading: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.all(8.0),
              height: parentHeight,
              width: parentWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: CustomText(text: 'PID Details')),
                  const SizedBox(height: 30),
                  CustomTextField(
                    labelText: '12334-33233-22',
                    margin: 5,
                    controller: TextEditingController(),
                  ),
                  const SizedBox(height: 30),
                  DropDownFormField(
                    dataSource: visitCodeChoice,
                    onChanged: onDropdownFiledChanged,
                    titleText: kVisitCode.titleCase,
                  ),
                  const SizedBox(height: 30),
                  DropDownFormField(
                    dataSource: timepointChoice,
                    onChanged: onDropdownFiledChanged,
                    titleText: kTimePoint.titleCase,
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomText(
                      text: 'Upload Document From',
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Chip(
                        avatar: const Icon(
                          Icons.photo_library_rounded,
                          color: kDarkBlue,
                        ),
                        label:
                            CustomText(text: kGallery.titleCase, fontSize: 17),
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                      ),
                      Chip(
                        avatar: const Icon(
                          Icons.add_a_photo_outlined,
                          color: kDarkBlue,
                        ),
                        label:
                            CustomText(text: kCamera.titleCase, fontSize: 17),
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomText(
                      text: 'Attachments',
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GalleryImage(
                      titleGallery: 'Uploaded Images',
                      imageUrls: [
                        Assets.images.test.snapshot2.path,
                        Assets.images.test.snapshot3.path,
                        Assets.images.test.snapshot4.path,
                        Assets.images.test.snapshot5.path,
                        Assets.images.test.snapshot6.path,
                        Assets.images.test.snapshot7.path,
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: DefaultButton(
            buttonName: kUpload.titleCase,
            onTap: onUploadButtonTapped,
            margin: const EdgeInsets.all(0.0),
            borderRadius: 0,
          ),
        );
      },
    );
  }

  void onUploadButtonTapped() {}

  void onDropdownFiledChanged(String? value) {}
}
