import 'package:edc_document_archieve/src/ui/widgets/custom_text.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text_field.dart';
import 'package:edc_document_archieve/src/utils/constants/back.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CreatePidScreen extends StatefulWidget {
  const CreatePidScreen({Key? key}) : super(key: key);

  @override
  _CreatePidScreenState createState() => _CreatePidScreenState();
}

class _CreatePidScreenState extends State<CreatePidScreen> {
  late TextEditingController pidController;

  @override
  void initState() {
    pidController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double parentHeight = constraints.maxHeight;
        double parentWidth = constraints.maxWidth;
        return AlertDialog(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.person,
                      color: kDarkBlue,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CustomText(
                        text: 'Add New PID',
                        color: kDarkBlue,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: kDarkBlue,
                  height: 2,
                  indent: 2,
                  thickness: 2.3,
                ),
              ],
            ),
            actions: [
              const TextButton(
                onPressed: back,
                child: CustomText(
                  text: 'Cancel',
                  fontSize: 16,
                  color: kDarkRed,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const CustomText(
                  text: 'Save',
                  fontSize: 16,
                  color: kDarkBlue,
                ),
              ),
            ],
            alignment: Alignment.center,
            content: Builder(
              builder: (context) {
                return SizedBox(
                  height: parentHeight / 6,
                  width: parentWidth,
                  child: Column(
                    children: [
                      const CustomText(
                        text: 'Please note that the PID that is added must be '
                            'a valid pid from EDC',
                        fontSize: 14,
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        labelText: 'PID',
                        margin: 0,
                        controller: pidController,
                      ),
                    ],
                  ),
                );
              },
            ));
      },
    );
  }
}
