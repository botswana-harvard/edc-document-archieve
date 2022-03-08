import 'package:edc_document_archieve/src/core/data/dummy_data.dart';
import 'package:edc_document_archieve/src/services/app_service.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text.dart';
import 'package:edc_document_archieve/src/ui/widgets/custom_text_field.dart';
import 'package:edc_document_archieve/src/ui/widgets/default_button.dart';
import 'package:edc_document_archieve/src/ui/widgets/dropdown_field.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CreatePidScreen extends StatefulWidget {
  const CreatePidScreen({Key? key}) : super(key: key);

  @override
  _CreatePidScreenState createState() => _CreatePidScreenState();
}

class _CreatePidScreenState extends State<CreatePidScreen> {
  late TextEditingController pidController;
  late GlobalKey<FormState> _formKey;
  late AppService _appService;
  String? selectedValue;
  late FocusNode focusNode;

  @override
  void initState() {
    pidController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _appService = context.read<AppService>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double parentHeight = constraints.maxHeight;
        double parentWidth = constraints.maxWidth;
        return Container(
          height: parentHeight,
          width: parentWidth,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: SingleChildScrollView(
            child: Column(
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
                        text: 'Add Participant Identifier (PID)',
                        color: kDarkBlue,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: kDarkBlue,
                  height: 2,
                  indent: 2,
                  thickness: 2.0,
                ),
                const SizedBox(height: 20),
                CustomText(
                  text:
                      'Please note that the PID that is added in the mobile app must be '
                      'a valid pid from ${_appService.selectedStudy} study',
                  fontSize: 14,
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      DropDownFormField(
                        dataSource: pidChoice,
                        onChanged: onDropdownChanged,
                        titleText: 'Select PID Type',
                        value: selectedValue,
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        labelText: 'PID',
                        margin: 0,
                        controller: pidController,
                        focusNode: focusNode,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                DefaultButton(buttonName: 'Save', onTap: onAddPidButtonPressed),
              ],
            ),
          ),
        );
      },
    );
  }

  void onAddPidButtonPressed() {
    if (_formKey.currentState!.validate()) {
      String pid = pidController.text.trim();
      FocusScope.of(context).unfocus();
      _appService.addPid(pid: pid, type: selectedValue!);
      Get.back();
    }
  }

  void onDropdownChanged(String? value) {
    setState(() {
      selectedValue = value;
    });
  }
}
