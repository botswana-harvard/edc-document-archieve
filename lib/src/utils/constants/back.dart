import 'package:flutter/material.dart';

void back(
  BuildContext context, {
  dynamic result,
}) {
  Navigator.pop(context, result);
}
