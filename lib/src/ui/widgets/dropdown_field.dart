import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';

typedef ValueSetter<T> = void Function(T? value);

class DropDownFormField extends StatelessWidget {
  final String titleText;
  final String hintText;
  final String? value;
  final List dataSource;
  final ValueSetter<String> onChanged;

  const DropDownFormField({
    Key? key,
    this.titleText = 'Title',
    this.hintText = 'Select one option',
    this.value,
    required this.dataSource,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: (value) {
        if (value == null) {
          return '$titleText field is required';
        } else {
          return null;
        }
      },
      initialValue: value,
      builder: (FormFieldState state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: InputDecorator(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: kDarkBlue,
                  width: 0.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              errorText: state.errorText,
              contentPadding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              labelText: titleText,
              labelStyle: const TextStyle(
                color: kDarkBlue,
              ),
              hintText: hintText,
              filled: false,
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: kDarkBlue,
                  width: 0.0,
                ),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text(hintText),
                elevation: 0,
                underline: Container(
                  height: 1.0,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kDarkBlue,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                value: value,
                focusColor: kDarkBlue,
                isDense: false,
                isExpanded: true,
                onChanged: (String? newValue) {
                  state.didChange(newValue);
                  onChanged(newValue);
                },
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                items: dataSource.map((item) {
                  return DropdownMenuItem<String>(
                    value: item[kValue],
                    child: Text(item[kDisplay]),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
