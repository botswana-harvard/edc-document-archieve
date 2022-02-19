import 'package:edc_document_archieve/src/ui/screens/base/widgets/study_container.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_appbar.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recase/recase.dart';

class BaseScreen extends StatelessWidget {
  static const String routeName = kBaseRoute;

  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  const CustomTextWidget(
                    text: 'Select Study',
                    fontSize: 30,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 30),
                  CustomStudyCard(
                    cardColor: Colors.blue[300],
                    onTap: onStudySeleted,
                    studyName: kFlourish.titleCase,
                  ),
                  const SizedBox(height: 30),
                  CustomStudyCard(
                    cardColor: Colors.green[300],
                    onTap: onStudySeleted,
                    studyName: kTshiloDikotla.titleCase,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void onStudySeleted() {
    Get.toNamed(kPidsRoute);
  }
}
