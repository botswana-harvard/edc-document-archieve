import 'package:edc_document_archieve/src/ui/widgets/custom_appbar.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text_field.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class CreateNonCRFormScreen extends StatefulWidget {
  static const String routeName = kCreateNonCRFormRoute;

  const CreateNonCRFormScreen({Key? key}) : super(key: key);

  @override
  _CreateNonCRFormScreenState createState() => _CreateNonCRFormScreenState();
}

class _CreateNonCRFormScreenState extends State<CreateNonCRFormScreen> {
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
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.all(8.0),
              height: parentHeight,
              width: parentWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CustomText(text: 'PID Details Upload'),
                  SizedBox(height: 30),
                  CustomTextField(labelText: '12334-33233-22')
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
